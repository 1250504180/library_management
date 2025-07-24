package com.example.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.demo.entity.User;
import com.example.demo.vo.TrendPoint;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface UserMapper extends BaseMapper<User> {
    @Select("SELECT DATE_FORMAT(create_time, '%Y-%m-%d') AS date, COUNT(*) AS count " +
            "FROM user " +
            "WHERE create_time >= DATE_SUB(CURDATE(), INTERVAL #{days} DAY) " +
            "GROUP BY DATE_FORMAT(create_time, '%Y-%m-%d') " +
            "ORDER BY date")
    List<TrendPoint> countNewUsersByDay(@Param("days") int days);
}
