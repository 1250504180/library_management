package com.example.demo.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 图书信息表
 */
@Data
@TableName("book")
public class Book {
    @TableId(type = IdType.AUTO)
    private Integer id;

    private String bookNumber;
    private String isbn;
    private String nameCn;
    private String nameId;
    private String language;
    private String author;
    private String translator;
    private String publisher;
    private LocalDate publishDate;
    private BigDecimal price;
    private Integer categoryId;
    private String location;
    private Integer totalQuantity;
    private Integer availableQuantity;
    private Integer borrowCount;
    private Integer status;
    private String description;
    private String coverImage;
    private BigDecimal ratingAvg;
    private String translationunit;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
}