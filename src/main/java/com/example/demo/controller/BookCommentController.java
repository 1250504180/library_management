package com.example.demo.controller;


import com.example.demo.annotation.LogExecution;
import com.example.demo.commom.Result;
import com.example.demo.commom.UserContext;
import com.example.demo.dto.BookCommentDTO;
import com.example.demo.entity.User;
import com.example.demo.service.BookService;
import com.example.demo.service.CommentService;
import com.example.demo.service.UserService;
import com.example.demo.vo.BookCommentVO;
import com.example.demo.vo.CommentStatisticsVO;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/bookComment")
public class BookCommentController {

    @Autowired private CommentService svc;
    @Autowired
    private UserContext userContext;
    @Autowired private UserService userService;
    @Autowired private BookService bookService;

    /**
     *
     * @param page
     * @param size
     * @param keyword
     * @return
     */
    @LogExecution
    @GetMapping("/list")
    public Result<Page<BookCommentVO>> page(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword) {
        return Result.success(svc.pageWithKeyword(page, size, keyword));
    }

    /**
     *
     * @param dto
     * @return
     */
    @LogExecution
    @PostMapping
    public Result<Void> create(@RequestBody @Valid BookCommentDTO dto) {
        svc.createComment(dto);
        return Result.success();
    }

    @PutMapping("/{id}")
    public Result<Void> update(
            @PathVariable Integer id,
            @RequestBody @Validated BookCommentDTO dto) {
        svc.updateComment(id, dto);
        return Result.success();
    }

    /**
     *
     * @param id
     * @return
     */
    @LogExecution
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Integer id) {
        svc.deleteComment(id);
        return Result.success();
    }

    /**
     *
     * @param ids
     * @return
     */
    @LogExecution
    @PostMapping("/deleteBatch")
    public Result<Void> deleteBatch(@RequestBody List<Integer> ids) {
        svc.deleteCommentsBatch(ids);
        return Result.success();
    }

    @GetMapping("/book/{bookId}")
    public Result<Page<BookCommentVO>> pageByBook(
            @PathVariable Integer bookId,
            @RequestParam(defaultValue="1") int page,
            @RequestParam(defaultValue="10") int size) {
        return Result.success(svc.pageByBook(bookId, page, size));
    }

    @GetMapping("/user/{userId}")
    public Result<Page<BookCommentVO>> pageByUser(
            @PathVariable Integer userId,
            @RequestParam(defaultValue="1") int page,
            @RequestParam(defaultValue="10") int size) {
        return Result.success(svc.pageByUser(userId, page, size));
    }

    @GetMapping("/rating/{bookId}")
    public Result<Double> avgRating(@PathVariable Integer bookId) {

        return Result.success(svc.calcAverageRating(bookId));
    }

    @GetMapping("/statistics/{bookId}")
    public Result<CommentStatisticsVO> stats(@PathVariable Integer bookId) {
        return Result.success(svc.getStatistics(bookId));
    }

    @GetMapping("/check")
    public Result<Boolean> check(
            @RequestParam Integer bookId,
            @RequestParam Integer userId) {
        return Result.success(svc.hasCommented(bookId, userId));
    }

    @GetMapping("/latest")
    public Result<List<BookCommentVO>> latest(
            @RequestParam(defaultValue="5") int limit) {
        return Result.success(svc.latestComments(limit));
    }

    @GetMapping("/highRated")
    public Result<List<BookCommentVO>> highRated(
            @RequestParam(defaultValue="5") int limit) {
        return Result.success(svc.highRatedComments(limit));
    }

    @PostMapping("/updateStatus")
    public Result<Void> updateStatus(
            @RequestParam Integer id,
            @RequestParam Integer status) {
        svc.updateStatus(id, status);
        return Result.success();
    }

    @PostMapping("/batchUpdateStatus/{status}")
    public Result<Void> batchUpdateStatus(
            @PathVariable Integer status,
            @Validated @RequestBody List<Integer> ids)
    {
        svc.updateStatusBatch(ids, status);
        return Result.success();
    }
}