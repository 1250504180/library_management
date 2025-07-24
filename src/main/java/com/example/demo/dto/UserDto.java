package com.example.demo.dto;

import lombok.Data;

@Data
public class UserDto {
    private Integer id;
    private String username;
    private String nickname;
    private String password;
    private String sex;
    private String address;
    private String phone;
    private Integer role;
}
