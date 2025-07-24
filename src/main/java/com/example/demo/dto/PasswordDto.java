package com.example.demo.dto;

import lombok.Data;

@Data
public class PasswordDto {
    private Integer userId;
    private String oldPassword;
    private String newPassword;
}