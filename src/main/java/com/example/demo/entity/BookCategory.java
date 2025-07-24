package com.example.demo.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 图书分类表
 */
@Data
@TableName("book_category")
public class BookCategory {
    @TableId(type = IdType.AUTO)
    private Integer id;

    private String categoryName;
    private String categoryCode;
    private String description;
    private Integer sortOrder;
    private Integer status;
    private Integer ParentId;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
}