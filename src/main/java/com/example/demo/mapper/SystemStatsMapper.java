package com.example.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.demo.entity.BookRecommendation;
import com.example.demo.entity.SystemStats;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SystemStatsMapper extends BaseMapper<SystemStats> {
}
