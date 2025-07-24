package com.example.demo.dto;

import lombok.Data;

@Data
public class RecQueryDTO {
    private Long bookId;
    private String recommendMonth;
    private Long operatorId;
}