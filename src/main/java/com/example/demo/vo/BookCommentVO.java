package com.example.demo.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class BookCommentVO {
    private Integer id;
    private Integer bookId;
    private Integer userId;
    private String byPerson;
    private String content;
    private Integer rating;
    private String bookName;
    private String userName;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}