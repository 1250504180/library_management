package com.example.demo.dto;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class BookSearchCriteria {
    private Integer id;
    private String bookNumber;
    private String isbn;
    private String nameCn;
    private String nameId;
    private String language;
    private String author;
    private String translator;
    private String publisher;
    private Integer status;
    private Integer categoryId;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate publishDateStart;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate publishDateEnd;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTimeStart;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTimeEnd;
}
