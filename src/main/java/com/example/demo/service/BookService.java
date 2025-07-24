package com.example.demo.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.demo.commom.Result;
import com.example.demo.dto.BookSearchCriteria;
import com.example.demo.vo.BookVO;
import com.example.demo.dto.BookDto;
import com.example.demo.entity.Book;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public interface BookService extends IService<Book> {
    Page<BookVO> pageBooks(int page, int size);
    void createBook(BookDto dto);
    void updateBook(Book dto);
    void deleteBooks(List<Integer> ids);
    void deleteBook(Integer id);
    Book getByBookNumber(String bookNumber);
    Page<BookVO> pageByCategory(Integer categoryId, int page, int size);
    Page<BookVO> pageByLanguage(String language, int page, int size);
    void borrowBook(Long id);
    void returnBook(Long id);
    List<String> listAllLanguages();
    boolean existsByBookNumber(String bookNumber);
    void batchUpdateStatus(List<Integer> ids, Integer status);
    BookVO getDetail(Long id);
    Page<BookVO> searchBooks(String keyword, int page, int size);
    Result<?> importFromExcel(MultipartFile file);

    void exportToExcel(HttpServletResponse response, String nameCn, String author, String isbn) throws IOException;
//    void recalculateRating(Long id);
    Book getByName(String name);

    Book getByISBN(String isbn);
}