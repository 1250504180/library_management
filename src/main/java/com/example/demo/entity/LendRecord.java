package com.example.demo.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 借阅记录表
 */
@Data
@TableName("lend_record")
public class LendRecord {
    @TableId(type = IdType.AUTO)
    private Integer id;

    private Integer readerId;
    private Integer bookId;
    private String bookName;
    private String bookNumber;
    private LocalDateTime lendTime;
    private LocalDateTime dueTime;
    private LocalDateTime returnTime;
    private String status;
    private Integer borrowDays;
    private Integer operatorId;
    private String remark;
    private Integer renewalCount;
    private String userName;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
}