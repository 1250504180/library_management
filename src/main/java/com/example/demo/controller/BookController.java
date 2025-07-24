package com.example.demo.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.annotation.LogExecution;
import com.example.demo.vo.BookVO;
import com.example.demo.commom.Result;
import com.example.demo.dto.*;
import com.example.demo.entity.Book;
import com.example.demo.service.BookService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/book")
public class BookController {

    @Autowired
    private BookService bookService;

    @GetMapping
    public Result<Page<BookVO>> page(@RequestParam int page, @RequestParam int size) {
        return Result.success(bookService.pageBooks(page, size));
    }

    /**
     *
     * @param dto
     * @return
     */
    @LogExecution
    @PostMapping
    public Result<String> CreateBook(@RequestBody BookDto dto) {
        bookService.createBook(dto);
        return Result.success("新增成功");
    }

    /**
     *
     * @param dto
     * @return
     */
    @LogExecution
    @PutMapping()
    public Result<String> updateBook(@RequestBody  Book dto) {
        bookService.updateBook(dto);
        return Result.success("更新成功");
    }

    /**
     *
     * @param id
     * @return
     */
    @LogExecution
    @DeleteMapping("/{id}")
    public Result<String> deleteBook(@PathVariable Integer id) {
        bookService.deleteBook(id);
        return Result.success("删除成功");
    }

    /**
     *
     * @param param
     * @return
     */
    @LogExecution
    @PostMapping("/deleteBatch")
    public Result<String> deleteBooks(@RequestBody Map<String, List<Integer>> param) {
        List<Integer> ids = param.get("ids");
        bookService.deleteBooks(ids);
        return Result.success("批量删除成功");
    }

    @GetMapping("/number/{bookNumber}")
    public Result<BookVO> getByNumber(@PathVariable String bookNumber) {
        Book book = bookService.getByBookNumber(bookNumber);
        if (book == null) {
            return Result.error(404,"未找到编号为 " + bookNumber + " 的图书");
        }
        BookVO vo = new BookVO();
        BeanUtils.copyProperties(book, vo);
        // 如果需要补充其它字段，再在这里查询并 set
        return Result.success(vo);
    }

    /** 按分类查询：分页可选 */
    @GetMapping("/category/{categoryId}")
    public Result<List<BookVO>> getByCategory(
            @PathVariable Integer categoryId,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {

        Page<BookVO> voPage = bookService.pageByCategory(categoryId, page, size);
        return Result.success(voPage.getRecords());
    }

    /** 按语言查询：分页可选 */
    @GetMapping("/language/{language}")
    public Result<List<BookVO>> getByLanguage(
            @PathVariable String language,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {

        Page<BookVO> voPage = bookService.pageByLanguage(language, page, size);
        return Result.success(voPage.getRecords());
    }

    /** 借阅图书：id 为 book.id */
    @PostMapping("/borrow/{id}")
    public Result<Void> borrow(@PathVariable Long id) {
        bookService.borrowBook(id);
        return Result.success();
    }

    /** 归还图书：id 为 book.id */
    @PostMapping("/return/{id}")
    public Result<Void> returnBook(@PathVariable Long id) {
        bookService.returnBook(id);
        return Result.success();
    }

    /** 获取所有支持的语言列表 */
    @GetMapping("/languages")
    public Result<List<String>> languages() {
        return Result.success(bookService.listAllLanguages());
    }

    /** 检查图书编号是否已存在，参数 bookNumber 通过 ?bookNumber=xxx 传入 */
    @GetMapping("/checkNumber")
    public Result<Boolean> checkNumber(@RequestParam String bookNumber) {
        boolean exists = bookService.existsByBookNumber(bookNumber);
        return Result.success(!exists);
    }

    /**
     *
     * @param dto
     * @return
     */
    @LogExecution
    @PostMapping("/batchUpdateStatus")
    public Result<Void> batchUpdateStatus(@RequestBody BatchStatusDTO dto) {
        bookService.batchUpdateStatus(dto.getIds(), dto.getStatus());
        return Result.success();
    }

    /** 获取图书详情 */
    @GetMapping("/detail/{id}")
    public Result<BookVO> detail(@PathVariable Long id) {
        BookVO vo = bookService.getDetail(id);
        return Result.success(vo);
    }

    /**
     *
     * @param page
     * @param size
     * @param keyword
     * @return 对于管理员返回全部图书信息，对于用户只返回可见的图书
     */
    @LogExecution
    @GetMapping("/searches")
    public Result<Page<BookVO>> searchBooks(@RequestParam(defaultValue = "1") int page,
                                            @RequestParam(defaultValue = "10") int size,
                                            @RequestParam(required = false) String keyword) {
        Page<BookVO> result = bookService.searchBooks(keyword, page, size);
        return Result.success(result);
    }

    /**
     *
     * @param file
     * @return
     */
    @LogExecution
    @PostMapping("/import")
    public Result<?> importExcel(@RequestParam("file") MultipartFile file) {
        return bookService.importFromExcel(file);
    }

    /**
     *
     * @param response
     * @param nameCn
     * @param author
     * @param isbn
     * @throws IOException
     */
    @LogExecution
    @GetMapping("/export")
    public void exportExcel(HttpServletResponse response,
                            @RequestParam(required = false) String nameCn,
                            @RequestParam(required = false) String author,
                            @RequestParam(required = false) String isbn) throws IOException {
        bookService.exportToExcel(response, null, null, null);
    }
}
