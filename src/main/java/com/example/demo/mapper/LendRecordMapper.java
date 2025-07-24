package com.example.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.demo.entity.LendRecord;
import com.example.demo.vo.TrendPoint;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface LendRecordMapper extends BaseMapper<LendRecord> {
    @Select("SELECT DATE_FORMAT(lend_time, '%Y-%m-%d') AS date, COUNT(*) AS count " +
            "FROM lend_record " +
            "WHERE lend_time >= DATE_SUB(CURDATE(), INTERVAL #{days} DAY) " +
            "GROUP BY DATE_FORMAT(lend_time, '%Y-%m-%d') " +
            "ORDER BY date")
    List<TrendPoint> countBorrowsByDay(@Param("days") int days);
}
