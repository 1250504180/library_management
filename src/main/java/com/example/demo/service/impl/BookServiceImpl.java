package com.example.demo.service.impl;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import com.example.demo.commom.Result;
import com.example.demo.commom.UserContext;
import com.example.demo.dto.BookExcelDto;

import com.example.demo.entity.User;

import com.example.demo.service.UserService;
import com.example.demo.vo.BookVO;
import com.example.demo.commom.BusinessException;
import com.example.demo.commom.ResourceNotFoundException;
import com.example.demo.dto.BookDto;
import com.example.demo.entity.Book;
import com.example.demo.mapper.BookCommentMapper;
import com.example.demo.mapper.BookMapper;
import com.example.demo.service.BookService;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import com.alibaba.excel.EasyExcel;
import java.io.IOException;
import javax.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class BookServiceImpl extends ServiceImpl<BookMapper, Book> implements BookService {


    @Autowired
    private BookMapper bookMapper;
    @Autowired
    private UserContext userContext;
    @Autowired
    private UserService userService;


    @Override
    public Page<BookVO> pageBooks(int page, int size) {
        // 1. 从数据库查询实体分页
        Page<Book> pe = this.page(new Page<>(page, size));

        // 2. 构造 VO 分页对象，并拷贝分页信息
        Page<BookVO> voPage = new Page<>(
                pe.getCurrent(),
                pe.getSize(),
                pe.getTotal()
        );

        // 3. 把每个实体转换成 VO，再设置到 voPage.records
        List<BookVO> voList = pe.getRecords().stream().map(entity -> {
            BookVO vo = new BookVO();
            BeanUtils.copyProperties(entity, vo);
            // TODO: 如果需要补充分类名、可借数量等额外字段：
            // String catName = categoryService.getById(entity.getCategoryId()).getCategoryName();
            // vo.setCategoryName(catName);
            return vo;
        }).collect(Collectors.toList());
        voPage.setRecords(voList);

        return voPage;
    }

    @Override
    public void createBook(BookDto dto) {
        Book book = new Book();
        BeanUtils.copyProperties(dto, book);
        book.setCreateTime(LocalDateTime.now());
        book.setUpdateTime(LocalDateTime.now());
        save(book);
    }

    @Override
    public void updateBook(Book book) {
        updateById(book);
    }

    @Override
    public void deleteBooks(List<Integer> ids) {
        removeByIds(ids);
    }

    @Override
    public void deleteBook(Integer id) {
        removeById(id);
    }


    @Override
    public Book getByBookNumber(String bookNumber) {
        return lambdaQuery()
                .eq(Book::getBookNumber, bookNumber)
                .one();
    }

    @Override
    public Page<BookVO> pageByCategory(Integer categoryId, int page, int size) {
        // 查询原始实体分页
        Page<Book> pe = lambdaQuery()
                .eq(Book::getCategoryId, categoryId)
                .page(new Page<>(page, size));

        // 转成 VO 并返回
        Page<BookVO> voPage = new Page<>(pe.getCurrent(), pe.getSize(), pe.getTotal());
        voPage.setRecords(pe.getRecords().stream().map(e -> {
            BookVO vo = new BookVO();
            BeanUtils.copyProperties(e, vo);
            // vo.setCategoryName(...) 可选
            return vo;
        }).collect(Collectors.toList()));

        return voPage;
    }

    @Override
    public Page<BookVO> pageByLanguage(String language, int page, int size) {
        Page<Book> pe = lambdaQuery()
                .eq(Book::getLanguage, language)
                .page(new Page<>(page, size));

        Page<BookVO> voPage = new Page<>(pe.getCurrent(), pe.getSize(), pe.getTotal());
        voPage.setRecords(pe.getRecords().stream().map(e -> {
            BookVO vo = new BookVO();
            BeanUtils.copyProperties(e, vo);
            return vo;
        }).collect(Collectors.toList()));

        return voPage;
    }

    @Override
    @Transactional
    public void borrowBook(Long id) {
        Book book = getById(id);
        if (book == null || book.getAvailableQuantity() <= 0) {
            throw new BusinessException("库存不足，无法借阅");
        }
        // 库存-1，借阅次数+1
        book.setAvailableQuantity(book.getAvailableQuantity() - 1);
        book.setBorrowCount(book.getBorrowCount() + 1);
        updateById(book);
    }

    @Override
    @Transactional
    public void returnBook(Long id) {
        Book book = getById(id);
        if (book == null) {
            throw new BusinessException("图书不存在");
        }
        // 库存+1
        book.setAvailableQuantity(book.getAvailableQuantity() + 1);
        updateById(book);
    }

    @Override
    public List<String> listAllLanguages() {
        return baseMapper.selectDistinctLanguages();
    }

    @Override
    public boolean existsByBookNumber(String bookNumber) {
        Integer count = lambdaQuery()
                .eq(Book::getBookNumber, bookNumber)
                .count();
        return count != null && count > 0;
    }

    @Override
    @Transactional
    public void batchUpdateStatus(List<Integer> ids, Integer status) {
        ids.forEach(id -> {
            Book b = new Book();
            b.setId(Math.toIntExact(id));
            b.setStatus(status);
            updateById(b);
        });
    }

    @Override
    public BookVO getDetail(Long id) {
        Book e = getById(id);
        if (e == null) {
            throw new ResourceNotFoundException("图书不存在");
        }
        BookVO vo = new BookVO();
        BeanUtils.copyProperties(e, vo);
        // 可以额外查询分类名称、评论列表等
        return vo;
    }


    @Override
    public Page<BookVO> searchBooks(String keyword, int page, int size) {
        Integer id = Math.toIntExact(userContext.getUserId());
        User user = userService.getById(id);

        QueryWrapper<Book> wrapper = new QueryWrapper<>();

        // 普通读者只能看到 status = 1 的书籍
        if (user.getRole() == 2) {
            wrapper.eq("status", 1);
        }

        if (StringUtils.isNotBlank(keyword)) {
            wrapper.and(w -> w
                    .like("name_cn", keyword)
                    .or().like("isbn", keyword)
                    .or().like("author", keyword)
                    .or().like("publisher", keyword)
            );
        }

        Page<Book> entityPage = new Page<>(page, size);
        Page<Book> bookPage = bookMapper.selectPage(entityPage, wrapper);

        Page<BookVO> voPage = new Page<>(bookPage.getCurrent(), bookPage.getSize(), bookPage.getTotal());
        voPage.setRecords(bookPage.getRecords().stream().map(book -> {
            BookVO vo = new BookVO();
            BeanUtils.copyProperties(book, vo);
            return vo;
        }).collect(Collectors.toList()));

        return voPage;
    }

    @Override
    public Result<?> importFromExcel(MultipartFile file) {
        try {
            List<BookExcelDto> dtos = EasyExcel.read(file.getInputStream(), BookExcelDto.class, null).sheet().doReadSync();
            if (CollectionUtils.isEmpty(dtos)) {
                return Result.error("Excel 无数据");
            }
            List<Book> books = dtos.stream().map(dto -> {
                Book book = new Book();
                BeanUtils.copyProperties(dto, book);
                return book;
            }).collect(Collectors.toList());

            for (Book book : books) {
                bookMapper.insert(book);
            }
            return Result.success();
        } catch (Exception e) {
            return Result.error("导入失败: " + e.getMessage());
        }
    }

    @Override
    public void exportToExcel(HttpServletResponse response, String nameCn, String author, String isbn) throws IOException {
        List<Book> books = bookMapper.selectByFilters(nameCn, author, isbn);
        List<BookExcelDto> dtoList = books.stream().map(book -> {
            BookExcelDto dto = new BookExcelDto();
            BeanUtils.copyProperties(book, dto);
            return dto;
        }).collect(Collectors.toList());

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setCharacterEncoding("utf-8");
        String fileName = URLEncoder.encode("图书信息", "UTF-8").replaceAll("\\+", "%20");
        response.setHeader("Content-disposition", "attachment;filename*=utf-8''" + fileName + ".xlsx");

        EasyExcel.write(response.getOutputStream(), BookExcelDto.class).sheet("图书列表").doWrite(dtoList);
    }

    @Override
    public Book getByName(String name) {
        LambdaQueryWrapper<Book> qw = new LambdaQueryWrapper<Book>()
                .eq(Book::getNameCn, name);
        return baseMapper.selectOne(qw);
    }

    @Override
    public Book getByISBN(String isbn) {
        LambdaQueryWrapper<Book> qw = new LambdaQueryWrapper<Book>()
                .eq(Book::getIsbn, isbn);
        return baseMapper.selectOne(qw);
    }
}