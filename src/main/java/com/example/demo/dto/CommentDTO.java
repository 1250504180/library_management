package com.example.demo.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data
public class CommentDTO {
    @NotNull
    private Long bookId;

    @NotBlank
    private String content;

    private Integer rating;
    private Long userId;
    private String byPerson;
}