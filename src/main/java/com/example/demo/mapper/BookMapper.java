package com.example.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.demo.entity.Book;
import com.example.demo.vo.TrendPoint;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface BookMapper extends BaseMapper<Book> {

    @Select("SELECT DATE_FORMAT(create_time, '%Y-%m-%d') AS date, COUNT(*) AS count " +
            "FROM book " +
            "WHERE create_time >= DATE_SUB(CURDATE(), INTERVAL #{days} DAY) " +
            "GROUP BY DATE_FORMAT(create_time, '%Y-%m-%d') " +
            "ORDER BY date")
    List<TrendPoint> countNewBooksByDay(@Param("days") int days);

    @Select("SELECT DISTINCT language FROM book")
    List<String> selectDistinctLanguages();

    /** 计算某书的平均评分 */
    @Select("SELECT AVG(rating) FROM book_comment WHERE book_id = #{bookId}")
    Double selectAvgRatingByBookId(@Param("bookId") Long bookId);

    @Select("SELECT COUNT(*) FROM book WHERE category_id = #{categoryId}")
    int countByCategory(@Param("categoryId") Integer categoryId);

    @Select("<script>" +
            "SELECT * FROM book WHERE 1=1" +
            "<if test='nameCn != null and nameCn != \"\"'> AND name_cn LIKE CONCAT('%', #{nameCn}, '%')</if>" +
            "<if test='author != null and author != \"\"'> AND author LIKE CONCAT('%', #{author}, '%')</if>" +
            "<if test='isbn != null and isbn != \"\"'> AND isbn LIKE CONCAT('%', #{isbn}, '%')</if>" +
            "</script>")
    List<Book> selectByFilters(@Param("nameCn") String nameCn,
                               @Param("author") String author,
                               @Param("isbn") String isbn);
}
