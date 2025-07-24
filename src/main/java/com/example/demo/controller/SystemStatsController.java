package com.example.demo.controller;

import com.example.demo.commom.Result;
import com.example.demo.dto.SystemStatsDTO;
import com.example.demo.service.SystemStatsService;
import com.example.demo.vo.SystemStatsVO;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/stats")
public class SystemStatsController {

    @Resource
    private SystemStatsService svc;

    @GetMapping
    public Result<List<SystemStatsVO>> page(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        return Result.success(svc.page(page, size).getRecords());
    }

    @GetMapping("/{id}")
    public Result<SystemStatsVO> getById(@PathVariable Integer id) {
        return Result.success(svc.getById(id));
    }

    @GetMapping("/date")
    public Result<SystemStatsVO> byDate(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date
    ) {
        return Result.success(svc.getByDate(date));
    }

    @GetMapping("/range")
    public Result<List<SystemStatsVO>> byRange(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate from,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate to
    ) {
        return Result.success(svc.listByRange(from, to));
    }

    @GetMapping("/today")
    public Result<SystemStatsVO> today() {
        return Result.success(svc.getToday());
    }

    @GetMapping("/recent")
    public Result<List<SystemStatsVO>> recent(@RequestParam int days) {
        return Result.success(svc.getRecent(days));
    }

    @PostMapping("/initToday")
    public Result<Void> init(@RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        svc.initForDate(date);
        return Result.success();
    }

    @DeleteMapping("/cleanup")
    public Result<Void> cleanup(@RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate before) {
        svc.cleanupBefore(before);
        return Result.success();
    }

    @PostMapping("/newUser")
    public Result<Void> addUser(@RequestParam int count) {
        svc.addNewUser(LocalDate.now(), count);
        return Result.success();
    }

    @PostMapping("/newBook")
    public Result<Void> addBook(@RequestParam int count) {
        svc.addNewBook(LocalDate.now(), count);
        return Result.success();
    }

    @PostMapping("/borrow")
    public Result<Void> addBorrow(@RequestParam int count) {
        svc.addBorrow(LocalDate.now(), count);
        return Result.success();
    }

    @PostMapping("/visit")
    public Result<Void> addVisit(@RequestParam int count) {
        svc.addVisit(LocalDate.now(), count);
        return Result.success();
    }

    @PostMapping("/comment")
    public Result<Void> addComment(@RequestParam int count) {
        svc.addComment(LocalDate.now(), count);
        return Result.success();
    }


    @GetMapping("/summary")
    public Result<SystemStatsVO> summary() {
        // 例如：聚合今天的所有字段返回
        return Result.success(svc.getToday());
    }


    @GetMapping("/userActivity")
    public Result<List<SystemStatsVO>> userActivity(@RequestParam int days) {
        // 这里复用 recent
        return Result.success(svc.getRecent(days));
    }


    @GetMapping("/bookBorrow")
    public Result<List<SystemStatsVO>> bookBorrow(@RequestParam int days) {
        return Result.success(svc.getRecent(days));
    }


    @GetMapping("/systemAccess")
    public Result<List<SystemStatsVO>> systemAccess(@RequestParam int days) {
        return Result.success(svc.getRecent(days));
    }


    @GetMapping("/report")
    public Result<String> report() {
        // TODO: 实现导出逻辑，返回下载链接
        return Result.success("暂未实现");
    }
}