package com.example.demo.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.demo.vo.TrendPoint;

import java.util.List;
import java.util.Map;

public interface StatsService{
    List<Map<String, Object>> getBorrowTrend(int days);
    List<TrendPoint> getVisitTrend();
    List<TrendPoint> getUserTrend();
    List<TrendPoint> getBookTrend();
    List<TrendPoint> getBorrowTrend();
}
