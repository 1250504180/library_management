package com.example.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.demo.entity.SysLog;
import com.example.demo.vo.TrendPoint;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface SysLogMapper extends BaseMapper<SysLog> {
    @Select("SELECT DATE_FORMAT(create_time, '%Y-%m-%d') AS date, COUNT(*) AS count " +
            "FROM sys_log " +
            "WHERE create_time >= DATE_SUB(CURDATE(), INTERVAL #{days} DAY) " +
            "GROUP BY DATE_FORMAT(create_time, '%Y-%m-%d') " +
            "ORDER BY date")
    List<TrendPoint> countVisitsByDay(@Param("days") int days);

    @Select("SELECT DATE(create_time) AS date, COUNT(DISTINCT username) AS count " +
            "FROM sys_log " +
            "WHERE method_name = 'login' " +
            "AND create_time >= CURDATE() - INTERVAL 6 DAY " +
            "GROUP BY DATE(create_time) " +
            "ORDER BY date")
    List<TrendPoint> countUniqueLoginsByDay();
}
