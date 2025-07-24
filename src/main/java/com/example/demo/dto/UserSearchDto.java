package com.example.demo.dto;

import lombok.Data;

@Data
public class UserSearchDto {
    private Integer id;
    private String nickName;
    private String phone;
    private String address;
}