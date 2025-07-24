package com.example.demo.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class UserSearchCriteria {
    private Integer id;
    private String username;
    private String nickName;
    private String sex;
    private String address;
    private String phone;
    private Integer role;
    private Integer status;

    // 时间范围查询
    private LocalDateTime createTimeStart;
    private LocalDateTime createTimeEnd;
    private LocalDateTime updateTimeStart;
    private LocalDateTime updateTimeEnd;
}