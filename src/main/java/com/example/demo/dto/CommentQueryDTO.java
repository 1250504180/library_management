package com.example.demo.dto;

import lombok.Data;

@Data
public class CommentQueryDTO {
    private Long bookId;
    private Long userId;
    private String byPerson;
}