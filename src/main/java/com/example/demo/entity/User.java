package com.example.demo.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.time.LocalDateTime;


/**
 * 用户表
 */
@Data
@TableName("user")
public class User {
    @TableId(type = IdType.AUTO)
    private Integer id;

    @NotBlank private String username;
    private String nickName;
    @NotBlank private String password;
    private String sex;
    private String address;
    private String phone;
    @NotBlank private Integer role;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    private Integer status;
}