package com.example.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.demo.entity.BookRecommendation;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface BookRecommendationMapper extends BaseMapper<BookRecommendation> {

    @Select("SELECT * FROM book_recommendation WHERE recommend_month = #{month}")
    List<BookRecommendation> selectByMonth(@Param("month") String month);

    @Select("SELECT DISTINCT recommend_month FROM book_recommendation ORDER BY recommend_month")
    List<String> selectAllMonths();

    @Select("SELECT * FROM book_recommendation " +
            "WHERE status = 1 " +
            "  AND recommend_month = DATE_FORMAT(CURDATE(), '%Y-%m')")
    List<BookRecommendation> selectCurrent();

    @Select("SELECT * FROM book_recommendation WHERE book_id = #{bookId}")
    List<BookRecommendation> selectByBookId(@Param("bookId") Integer bookId);

    @Select("SELECT COUNT(*) FROM book_recommendation WHERE recommend_month = #{month}")
    int countByMonth(@Param("month") String month);
}

