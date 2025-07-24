package com.example.demo.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.demo.annotation.LogExecution;
import com.example.demo.commom.UserContext;
import com.example.demo.dto.BookCommentDTO;
import com.example.demo.entity.Book;
import com.example.demo.entity.BookComment;
import com.example.demo.entity.User;
import com.example.demo.mapper.BookCommentMapper;
import com.example.demo.mapper.BookMapper;
import com.example.demo.service.BookService;
import com.example.demo.service.CommentService;
import com.example.demo.service.UserService;
import com.example.demo.vo.BookCommentVO;
import com.example.demo.vo.CommentStatisticsVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.stream.Collectors;
@Service
public class CommentServiceImpl extends ServiceImpl<BookCommentMapper, BookComment> implements CommentService {
    @Autowired
    private BookCommentMapper mapper;

    @Autowired
    private UserContext userContext;
    @Autowired
    private UserService userService;
    @Autowired
    private BookMapper bookMapper;
    @Autowired
    private BookService bookService;

    /**
     *
     * @param dto
     */
    @LogExecution
    @Override
    public void createComment(BookCommentDTO dto) {
        // 获取当前用户
        Integer userId = Math.toIntExact(userContext.getUserId());

        User operatorUser = userService.getById(userId);
        dto.setByPerson(operatorUser.getNickName());

        User commentator=userService.getByName(dto.getUserName());
        dto.setUserId(commentator.getId());

        Book book=bookService.getByName(dto.getBookName());
        dto.setBookId(book.getId());
        Integer borrowCount = book.getBorrowCount();
        BigDecimal ratingAvg = book.getRatingAvg();

        if (borrowCount == 0) {
            book.setRatingAvg(BigDecimal.valueOf(dto.getRating()));
        } else {
            // 新评分计算逻辑：加权平均 = (原评分 * 原评论数 + 新评分) / (原评论数 + 1)
            BigDecimal newAvg = ratingAvg.multiply(BigDecimal.valueOf(borrowCount))
                    .add(BigDecimal.valueOf(dto.getRating()))
                    .divide(BigDecimal.valueOf(borrowCount + 1), 2, RoundingMode.HALF_UP);

            // 更新 book 表中的 ratingAvg 字段
            book.setRatingAvg(newAvg);
        }

        bookMapper.updateById(book);

        // 保存评论
        BookComment comment = new BookComment();
        BeanUtils.copyProperties(dto, comment);
        mapper.insert(comment);
    }

    @Override
    public void updateComment(Integer id, BookCommentDTO dto) {
        BookComment e = mapper.selectById(id);
        if (e == null) throw new RuntimeException("评论不存在：" + id);
        BeanUtils.copyProperties(dto, e);
        mapper.updateById(e);
    }

    @Override
    public void deleteComment(Integer id) {
        mapper.deleteById(id);
    }

    @Override
    public void deleteCommentsBatch(List<Integer> ids) {
        mapper.deleteBatchIds(ids);
    }

    @Override
    public Page<BookCommentVO> pageByBook(Integer bookId, int page, int size) {
        Page<BookComment> pe = mapper.selectPage(new Page<>(page, size),
                new QueryWrapper<BookComment>().eq("book_id", bookId));
        Page<BookCommentVO> po = new Page<>(pe.getCurrent(), pe.getSize(), pe.getTotal());
        po.setRecords(pe.getRecords().stream().map(e -> {
            BookCommentVO vo = new BookCommentVO();
            BeanUtils.copyProperties(e, vo);
            return vo;
        }).collect(Collectors.toList()));
        return po;
    }

    @Override
    public Page<BookCommentVO> pageByUser(Integer userId, int page, int size) {
        Page<BookComment> pe = mapper.selectPage(new Page<>(page, size),
                new QueryWrapper<BookComment>().eq("user_id", userId));
        Page<BookCommentVO> po = new Page<>(pe.getCurrent(), pe.getSize(), pe.getTotal());
        po.setRecords(pe.getRecords().stream().map(e -> {
            BookCommentVO vo = new BookCommentVO();
            BeanUtils.copyProperties(e, vo);
            return vo;
        }).collect(Collectors.toList()));
        return po;
    }

    @Override
    public double calcAverageRating(Integer bookId) {
        List<BookComment> list = mapper.selectList(
                new QueryWrapper<BookComment>().eq("book_id", bookId));
        return list.stream().mapToInt(BookComment::getRating).average().orElse(0.0);
    }

    @Override
    public CommentStatisticsVO getStatistics(Integer bookId) {
        List<BookComment> list = mapper.selectList(
                new QueryWrapper<BookComment>().eq("book_id", bookId));
        long total = list.size();
        long positive = list.stream().filter(c -> c.getRating() >= 4).count();
        CommentStatisticsVO vo = new CommentStatisticsVO();
        vo.setTotal(total);
        vo.setPositiveCount(positive);
        vo.setPositiveRate(total==0?0: positive*100.0/total);
        return vo;
    }

    @Override
    public boolean hasCommented(Integer bookId, Integer userId) {
        Integer count = mapper.selectCount(new QueryWrapper<BookComment>()
                .eq("book_id", bookId).eq("user_id", userId));
        return count != null && count > 0;
    }

    @Override
    public List<BookCommentVO> latestComments(int limit) {
        return mapper.selectList(new QueryWrapper<BookComment>()
                        .orderByDesc("create_time").last("LIMIT " + limit))
                .stream().map(e -> {
                    BookCommentVO vo = new BookCommentVO();
                    BeanUtils.copyProperties(e, vo);
                    return vo;
                }).collect(Collectors.toList());
    }

    @Override
    public List<BookCommentVO> highRatedComments(int limit) {
        return mapper.selectList(new QueryWrapper<BookComment>()
                        .ge("rating", 4).orderByDesc("rating").last("LIMIT " + limit))
                .stream().map(e -> {
                    BookCommentVO vo = new BookCommentVO();
                    BeanUtils.copyProperties(e, vo);
                    return vo;
                }).collect(Collectors.toList());
    }

    @Override
    public void updateStatus(Integer id, Integer status) {
        BookComment e = mapper.selectById(id);
        mapper.updateById(e);
    }

    @Override
    public void updateStatusBatch(List<Integer> ids, Integer status) {
        List<BookComment> list = mapper.selectBatchIds(ids);
        list.forEach(mapper::updateById);
    }

    @Override
    public Page<BookCommentVO> page(int page, int size) {
        Page<BookCommentVO> pageObj = new Page<>(page, size);

        LambdaQueryWrapper<BookComment> queryWrapper = new LambdaQueryWrapper<>();
        // 可以在这里加筛选条件，比如按书ID、用户ID、时间等

        // 查询BookComment表，返回Page对象
        Page<BookComment> commentPage = mapper.selectPage(new Page<>(page, size), queryWrapper);

        // 如果你要返回VO，可以copy一下
        Page<BookCommentVO> voPage = new Page<>(page, size, commentPage.getTotal());
        List<BookCommentVO> voList = commentPage.getRecords().stream().map(entity -> {
            BookCommentVO vo = new BookCommentVO();
            BeanUtils.copyProperties(entity, vo);
            return vo;
        }).collect(Collectors.toList());
        voPage.setRecords(voList);
        return voPage;
    }

    @Override
    public Page<BookCommentVO> pageWithKeyword(int page, int size, String keyword) {
        Page<BookComment> p = new Page<>(page, size);
        LambdaQueryWrapper<BookComment> wrapper = new LambdaQueryWrapper<>();

        // 当前用户信息
        Long userId = userContext.getUserId();
        User user = userService.getById(userId);

        // 普通用户只能查看自己发表的评论
        if (user.getRole() == 2) {
            wrapper.eq(BookComment::getUserId, userId);
        }

        // 多字段模糊或等值匹配
        if (StringUtils.hasText(keyword)) {
            wrapper.and(w -> {
                w.like(BookComment::getContent, keyword)
                        .or().like(BookComment::getByPerson, keyword);

                // 尝试将 keyword 转成数字后用于精确匹配 bookId 和 userId
                try {
                    Integer number = Integer.parseInt(keyword);
                    w.or().eq(BookComment::getBookId, number)
                            .or().eq(BookComment::getUserId, number);
                } catch (NumberFormatException ignored) {}
            });
        }

        // 时间倒序
        wrapper.orderByDesc(BookComment::getCreateTime);
        this.page(p, wrapper);

        // 转换成 VO 分页
        Page<BookCommentVO> voPage = new Page<>(p.getCurrent(), p.getSize(), p.getTotal());
        voPage.setRecords(p.getRecords().stream().map(entity -> {
            BookCommentVO vo = new BookCommentVO();
            // 先把 entity 的通用属性拷贝过去
            BeanUtils.copyProperties(entity, vo);

            // 再根据 bookId 去查 book，然后把 nameCn 塞到 VO
            Book book = bookService.getById(entity.getBookId());
            if (book != null) {
                vo.setBookName(book.getNameCn());
            } else {
                vo.setBookName("—");  // 或者留空、或者写一个默认值
            }
            return vo;
        }).collect(Collectors.toList()));

        return voPage;
    }
}
