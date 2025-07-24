package com.example.demo.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 图书推荐表
 */
@Data
@TableName("book_recommendation")
public class BookRecommendation {
    @TableId(type = IdType.AUTO)
    private Integer id;

    private Integer bookId;
    private String recommendMonth;
    private String recommendReason;
    private Integer operatorId;
    private Integer status;
    private String operatorName;
    private String nameCn;
    private String imgUrl;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
}