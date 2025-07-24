package com.example.demo.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.demo.commom.Result;
import com.example.demo.commom.UserContext;
import com.example.demo.entity.Book;
import com.example.demo.entity.User;
import com.example.demo.mapper.BookMapper;
import com.example.demo.mapper.UserMapper;
import com.example.demo.service.BookService;
import com.example.demo.service.UserService;
import com.example.demo.vo.LendRecordVO;
import com.example.demo.dto.LendRecordDTO;
import com.example.demo.entity.LendRecord;
import com.example.demo.mapper.LendRecordMapper;
import com.example.demo.service.LendRecordService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class LendRecordServiceImpl extends ServiceImpl<LendRecordMapper, LendRecord> implements LendRecordService {

    @Autowired
    private LendRecordMapper mapper;

    @Autowired
    private BookService bookService;

    @Autowired
    private LendRecordMapper lendRecordMapper;
    @Autowired
    private BookMapper bookMapper;
    @Autowired
    private UserContext userContext;
    @Autowired
    private UserService userService;


    public Page<LendRecordVO> page(int page, int size) {
        // 1. 分页查询实体
        Page<LendRecord> p = mapper.selectPage(new Page<>(page, size), Wrappers.emptyWrapper());

        // 2. 构造 VO 分页对象
        Page<LendRecordVO> voPage = new Page<>(p.getCurrent(), p.getSize(), p.getTotal());

        // 3. 转换 record 列表，用 collect(Collectors.toList())
        voPage.setRecords(
                p.getRecords().stream()
                        .map(entity -> {
                            LendRecordVO vo = new LendRecordVO();
                            BeanUtils.copyProperties(entity, vo);
                            
                            // 获取图书图片URL
                            if (entity.getBookId() != null) {
                                Book book = bookService.getById(entity.getBookId());
                                if (book != null) {
                                    vo.setBookImageUrl(book.getCoverImage());
                                }
                            }
                            
                            return vo;
                        })
                        .collect(Collectors.toList())
        );

        return voPage;
    }

    @Override
    public Result<String> create(LendRecordDTO dto) {
        LendRecord entity = new LendRecord();
        BeanUtils.copyProperties(dto, entity);
        entity.setStatus("已借出");

        Book book=bookService.getByISBN(dto.getIsbn());

        if(book==null){
            return Result.error("图书不存在");
        }

        User user=userService.getByName(dto.getUsername());
        if(user==null){
            return Result.error("用户不存在");
        }

        entity.setBookName(book.getNameCn());
        entity.setBookNumber(book.getBookNumber());
        entity.setStatus(String.valueOf(book.getStatus()));
        entity.setUserName(dto.getUsername());
        entity.setReaderId(user.getId());
        entity.setBookId(book.getId());

        bookService.borrowBook(Long.valueOf(book.getId()));

        mapper.insert(entity);
        return Result.success();
    }

    @Override
    public void update(Long id,LendRecordDTO dto) {
        LendRecord entity = new LendRecord();
        BeanUtils.copyProperties(dto, entity);
        entity.setId(Math.toIntExact(id));
        mapper.updateById(entity);
    }

    @Override
    public void returned(Integer id) {
        LendRecord entity = mapper.selectById(id);
        if (entity == null) throw new IllegalArgumentException("记录不存在: " + id);
        entity.setReturnTime(java.time.LocalDateTime.now());
        entity.setStatus("已归还");
        bookService.returnBook(Long.valueOf(entity.getBookId()));

        LocalDateTime lendTime = entity.getLendTime();
        LocalDateTime returnTime =LocalDateTime.now();

        long days = Math.abs(ChronoUnit.DAYS.between(lendTime, returnTime));
        entity.setBorrowDays((int) days);
        mapper.updateById(entity);
    }

    @Override
    public void deleteById(Integer id) {
        mapper.deleteById(id);
    }

    @Override
    public LendRecordVO getById(Integer id) {
        LendRecord entity = mapper.selectById(id);
        if (entity == null) return null;
        LendRecordVO vo = new LendRecordVO();
        BeanUtils.copyProperties(entity, vo);
        
        // 获取图书图片URL
        if (entity.getBookId() != null) {
            Book book = bookService.getById(entity.getBookId());
            if (book != null) {
                vo.setBookImageUrl(book.getCoverImage());
            }
        }
        
        return vo;
    }

    public Page<LendRecordVO> page(int page, int size, String keyword) {
        Integer currentUserId = Math.toIntExact(UserContext.getUserId());
        User currentUser = userService.getById(currentUserId);

        QueryWrapper<LendRecord> wrapper = new QueryWrapper<>();

        // 模糊匹配关键字
        if (StringUtils.isNotBlank(keyword)) {
            wrapper.and(w -> w
                    .like("book_name", keyword)
                    .or().like("book_number", keyword)
                    .or().like("reader_id", keyword)
                    .or().like("remark", keyword)
            );
        }

        // 如果是普通读者，限制只能查自己的记录
        if (currentUser.getRole() != 0) {
            wrapper.eq("reader_id", currentUserId);
        }

        // 分页查询
        Page<LendRecord> entityPage = new Page<>(page, size);
        Page<LendRecord> recordPage = lendRecordMapper.selectPage(entityPage, wrapper);

        // VO 转换
        Page<LendRecordVO> voPage = new Page<>(recordPage.getCurrent(), recordPage.getSize(), recordPage.getTotal());
        voPage.setRecords(recordPage.getRecords().stream().map(e -> {
            LendRecordVO vo = new LendRecordVO();
            BeanUtils.copyProperties(e, vo);
            
            // 获取图书图片URL
            if (e.getBookId() != null) {
                Book book = bookService.getById(e.getBookId());
                if (book != null) {
                    vo.setBookImageUrl(book.getCoverImage());
                }
            }
            
            return vo;
        }).collect(Collectors.toList()));

        return voPage;
    }

    @Override
    public Page<LendRecordVO> search(String keyword, int page, int size) {
        LambdaQueryWrapper<LendRecord> wrapper = new LambdaQueryWrapper<>();

        if (StringUtils.isNotBlank(keyword)) {
            wrapper.and(w -> w
                    .like(LendRecord::getBookId, keyword)
                    .or().like(LendRecord::getReaderId, keyword)
                    .or().like(LendRecord::getStatus, keyword)
            );
        }

        wrapper.orderByDesc(LendRecord::getId);

        Page<LendRecord> entityPage = new Page<>(page, size);
        Page<LendRecord> recordPage = this.page(entityPage, wrapper);
        
        // 转换为VO并添加图书图片URL
        Page<LendRecordVO> voPage = new Page<>(recordPage.getCurrent(), recordPage.getSize(), recordPage.getTotal());
        voPage.setRecords(recordPage.getRecords().stream().map(entity -> {
            LendRecordVO vo = new LendRecordVO();
            BeanUtils.copyProperties(entity, vo);
            
            // 获取图书图片URL
            if (entity.getBookId() != null) {
                Book book = bookService.getById(entity.getBookId());
                if (book != null) {
                    vo.setBookImageUrl(book.getCoverImage());
                }
            }
            
            return vo;
        }).collect(Collectors.toList()));
        
        return voPage;
    }

}
