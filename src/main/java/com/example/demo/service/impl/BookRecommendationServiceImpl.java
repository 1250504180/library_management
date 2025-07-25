package com.example.demo.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.demo.commom.Result;
import com.example.demo.commom.UserContext;
import com.example.demo.dto.BookRecommendationDTO;
import com.example.demo.entity.Book;
import com.example.demo.entity.BookRecommendation;
import com.example.demo.entity.User;
import com.example.demo.mapper.BookRecommendationMapper;
import com.example.demo.service.BookRecommendationService;
import com.example.demo.service.BookService;
import com.example.demo.service.UserService;
import com.example.demo.vo.BookRecommendationVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class BookRecommendationServiceImpl extends ServiceImpl<BookRecommendationMapper,BookRecommendation> implements BookRecommendationService {
    @Resource
    private BookRecommendationMapper mapper;
    private static final DateTimeFormatter FMT = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    @Autowired
    private UserContext userContext;
    @Autowired
    private UserService userService;
    @Autowired
    private BookService bookService;

    @Override
    public Result<String> create(BookRecommendationDTO dto) {
        Integer userId = Math.toIntExact(userContext.getUserId());
        User user=userService.getById(userId);
        String userName=user.getUsername();

        BookRecommendation e = new BookRecommendation();
        BeanUtils.copyProperties(dto, e);
        e.setOperatorName(userName);

        Book book = bookService.getByName(dto.getBookName());

        if (book == null) {
            return Result.error("未找到对应图书");
        }
        e.setNameCn(book.getNameCn());
        e.setBookId(book.getId());
        e.setOperatorId(userId);
        mapper.insert(e);
        return Result.success("推荐创建成功");
    }

    @Override
    public void update(BookRecommendationDTO dto) {
        BookRecommendation exists = mapper.selectById(dto.getId());
        if (exists == null) throw new RuntimeException("推荐不存在: " + dto.getId());
        BeanUtils.copyProperties(dto, exists);
        mapper.updateById(exists);
    }

    @Override
    public void delete(Integer id) {
        mapper.deleteById(id);
    }

    @Override
    public void deleteBatch(List<Integer> ids) {
        mapper.deleteBatchIds(ids);
    }

    @Override
    public Page<BookRecommendationVO> page(int page, int size) {
        Page<BookRecommendation> p = mapper.selectPage(new Page<>(page, size), new QueryWrapper<>());

        Page<BookRecommendationVO> voPage = new Page<>(page, size, p.getTotal());
        List<BookRecommendationVO> voList = p.getRecords().stream().map(e -> {
            BookRecommendationVO vo = new BookRecommendationVO();
            BeanUtils.copyProperties(e, vo);
            return vo;
        }).collect(Collectors.toList());
        voPage.setRecords(voList);
        return voPage;
    }


    @Override
    public List<BookRecommendationVO> listByMonth(String month) {
        return mapper.selectByMonth(month).stream().map(this::toVO).collect(Collectors.toList());
    }

    @Override
    public List<BookRecommendationVO> current() {
        return mapper.selectCurrent().stream().map(this::toVO).collect(Collectors.toList());
    }

    @Override
    public List<BookRecommendationVO> listByBookId(Integer bookId) {
        return mapper.selectByBookId(bookId).stream().map(this::toVO).collect(Collectors.toList());
    }

    @Override
    public boolean existsMonth(String month) {
        return mapper.countByMonth(month) > 0;
    }

    @Override
    public List<String> listMonths() {
        return mapper.selectAllMonths();
    }

    @Override
    public void activate(Integer id) {
        mapper.updateById(new BookRecommendation() {{ setId(id); setStatus(1); }});
    }

    @Override
    public void deactivate(Integer id) {
        mapper.updateById(new BookRecommendation() {{ setId(id); setStatus(0); }});
    }

    @Override
    public void updateStatus(Integer id, Integer status) {
        mapper.updateById(new BookRecommendation() {{ setId(id); setStatus(status); }});
    }

    @Override
    public void batchUpdateStatus(List<Integer> ids, Integer status) {
        ids.forEach(id -> updateStatus(id, status));
    }

    @Override
    public BookRecommendationVO detail(Integer id) {
        return toVO(mapper.selectById(id));
    }

    @Override
    public List<BookRecommendationVO> popular(int topN) {
        // 简单示例：取最新的 topN 条启用的推荐
        return mapper.selectList(new QueryWrapper<BookRecommendation>()
                        .eq("status", 1)
                        .orderByDesc("create_time")
                        .last("LIMIT " + topN))
                .stream().map(this::toVO).collect(Collectors.toList());
    }

    @Override
    public Page<BookRecommendationVO> searchRecommendations(String keyword, int page, int size) {

        Integer id = Math.toIntExact(userContext.getUserId());
        User user = userService.getById(id);
        Integer role=user.getRole();

        LambdaQueryWrapper<BookRecommendation> wrapper = new LambdaQueryWrapper<>();

        // keyword 关键字过滤
        if (StringUtils.isNotBlank(keyword)) {
            wrapper.and(w -> {
                w.like(BookRecommendation::getRecommendReason, keyword)
                        .or().like(BookRecommendation::getRecommendMonth, keyword)
                        .or().like(BookRecommendation::getNameCn, keyword); // 添加中文书名搜索

                if (keyword.matches("\\d+")) {
                    w.or().eq(BookRecommendation::getBookId, Integer.valueOf(keyword));
                }
                
                // 通过关联Book表搜索外语书名
                w.or().exists("SELECT 1 FROM book b WHERE b.id = book_recommendation.book_id AND b.name_id LIKE CONCAT('%', '" + keyword + "', '%')");
            });
        }

        // 角色限制逻辑：role 为 2 时，仅查看 status=1 的记录
        if (role == 2) {
            wrapper.eq(BookRecommendation::getStatus, 1);
        }

        // 排序
        wrapper.orderByDesc(BookRecommendation::getId);

        // 分页查询
        Page<BookRecommendation> entityPage = new Page<>(page, size);
        this.page(entityPage, wrapper);

        // 转 VO 并封装分页结果
        Page<BookRecommendationVO> voPage = new Page<>(page, size, entityPage.getTotal());
        voPage.setRecords(entityPage.getRecords().stream()
                .map(this::toVO)
                .collect(Collectors.toList()));

        return voPage;
    }


    private BookRecommendationVO toVO(BookRecommendation e) {
        BookRecommendationVO vo = new BookRecommendationVO();
        BeanUtils.copyProperties(e, vo);
        vo.setCreateTime(e.getCreateTime().format(FMT));
        vo.setUpdateTime(e.getUpdateTime().format(FMT));
        vo.setBookName(e.getNameCn());
        vo.setOperatorName(e.getOperatorName());
        return vo;
    }
}