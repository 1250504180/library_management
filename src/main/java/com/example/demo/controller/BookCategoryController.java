package com.example.demo.controller;

import com.example.demo.commom.Result;
import com.example.demo.dto.BookCategoryDTO;
import com.example.demo.vo.BookCategoryVO;
import com.example.demo.service.BookCategoryService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/category")
public class BookCategoryController {
    @Resource private BookCategoryService svc;

    @PostMapping
    public Result<Void> create(@Validated @RequestBody BookCategoryDTO dto) {
        svc.create(dto); return Result.success();
    }

    @PutMapping("/{id}")
    public Result<Void> update(
            @PathVariable Integer id,
            @Validated @RequestBody BookCategoryDTO dto) {
        svc.update(id, dto); return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Integer id) {
        svc.delete(id); return Result.success();
    }

    @PostMapping("/deleteBatch")
    public Result<Void> deleteBatch(@RequestBody List<Integer> ids) {
        svc.deleteBatch(ids); return Result.success();
    }

    @GetMapping("/enabled")
    public Result<List<BookCategoryVO>> enabled() {

        return Result.success(svc.listEnabled());
    }

    @GetMapping("/parent/{parentId}")
    public Result<List<BookCategoryVO>> byParent(@PathVariable Integer parentId) {
        return Result.success(svc.listByParent(parentId));
    }

    @GetMapping("/root")
    public Result<List<BookCategoryVO>> root() {

        return Result.success(svc.listRoot());
    }

    @GetMapping("/tree")
    public Result<List<BookCategoryVO>> tree() {

        return Result.success(svc.tree());
    }

    @GetMapping("/path/{id}")
    public Result<List<Integer>> path(@PathVariable Integer id) {

        return Result.success(svc.path(id));
    }

    @GetMapping("/bookCount/{id}")
    public Result<Integer> bookCount(@PathVariable Integer id) {

        return Result.success(svc.countBooks(id));
    }

    @GetMapping("/checkCode")
    public Result<Boolean> checkCode(@RequestParam String code) {

        return Result.success(!svc.existsCode(code));
    }

    @GetMapping("/checkName")
    public Result<Boolean> checkName(@RequestParam String name) {

        return Result.success(!svc.existsName(name));
    }

    @PostMapping("/move")
    public Result<Void> move(@RequestParam Integer id, @RequestParam Integer newParentId) {
        svc.move(id, newParentId); return Result.success();
    }

    @PostMapping("/sort")
    public Result<Void> sort(@RequestParam Integer id, @RequestParam Integer newOrder) {
        svc.sort(id, newOrder); return Result.success();
    }

    @PostMapping("/batchUpdateStatus")
    public Result<Void> batchUpdateStatus(
            @RequestParam List<Integer> ids,
            @RequestParam Integer status) {
        svc.batchUpdateStatus(ids, status);
        return Result.success();
    }

    @GetMapping("/children/{id}")
    public Result<List<Integer>> children(@PathVariable Integer id) {

        return Result.success(svc.childrenIds(id));
    }

    @GetMapping
    public Result<List<BookCategoryVO>> list(
            @RequestParam(defaultValue="1") int page,
            @RequestParam(defaultValue="10") int size) {
        return Result.success(svc.listAll(page, size));
    }

    @GetMapping("/{id}")
    public Result<BookCategoryVO> get(@PathVariable Integer id) {

        return Result.success(svc.getById(id));
    }
}