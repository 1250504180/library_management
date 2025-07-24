package com.example.demo.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.annotation.LogExecution;
import com.example.demo.commom.Result;
import com.example.demo.entity.LendRecord;
import com.example.demo.mapper.LendRecordMapper;
import com.example.demo.service.StatsService;
import com.example.demo.vo.TrendPoint;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/stats")
@RequiredArgsConstructor
public class StatsController {

    @Autowired
    private StatsService statsService;

    // 原始趋势图（每天的借阅数量）

    /**
     *
     * @param days
     * @return
     */
    @LogExecution
    @GetMapping("/borrowTrendChart")
    public Result<List<Map<String, Object>>> getBorrowTrend(@RequestParam(defaultValue = "7") int days) {
        return Result.success(statsService.getBorrowTrend(days));
    }

    // 统计 Mapper 中聚合出来的借阅趋势

    /**
     *
     * @return
     */
    @LogExecution
    @GetMapping("/borrowTrend")
    public Result<List<TrendPoint>> borrowTrend() {
        return Result.success(statsService.getBorrowTrend());
    }

    /**
     *
     * @return
     */
    @LogExecution
    @GetMapping("/userTrend")
    public Result<List<TrendPoint>> userTrend() {
        return Result.success(statsService.getUserTrend());
    }

    /**
     *
     * @return
     */
    @LogExecution
    @GetMapping("/bookTrend")
    public Result<List<TrendPoint>> bookTrend() {
        return Result.success(statsService.getBookTrend());
    }

    /**
     *
     * @return
     */
    @LogExecution
    @GetMapping("/visitTrend")
    public Result<List<TrendPoint>> getVisitTrend() {
        return Result.success(statsService.getVisitTrend());
    }
}