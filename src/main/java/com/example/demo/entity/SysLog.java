package com.example.demo.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("sys_log")
public class SysLog {
    @TableId(type = IdType.AUTO) private Long   id;
    private Integer userId;
    private String  username;
    private String  className;
    private String  methodName;
    private String  params;
    private String  result;
    private String  logType;      // INFO / ERROR
    private String  exception;    // 异常堆栈

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
}