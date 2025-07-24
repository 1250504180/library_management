package com.example.demo.dto;

import lombok.Data;

@Data
public class BookQueryDTO {
    private String bookNumber,name,author,language;
    private Long categoryId;
}