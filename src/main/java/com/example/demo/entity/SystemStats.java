package com.example.demo.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 系统访问统计表
 */
@Data
@TableName("system_stats")
public class SystemStats {
    @TableId(type = IdType.AUTO)
    private Integer id;

    private LocalDate statDate;
    private Integer visitCount;
    private Integer newUsers;
    private Integer newBooks;
    private Integer lendCount;
    private Integer returnCount;
    private Integer commentCount;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
}