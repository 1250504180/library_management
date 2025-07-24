package com.example.demo.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 图书评论表
 */
@Data
@TableName("book_comment")
public class BookComment {
    @TableId(type = IdType.AUTO)
    private Integer id;

    private Integer bookId;
    private Integer userId;
    private String byPerson;
    private String content;
    private Integer rating;
    private String bookName;
    private String userName;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
}