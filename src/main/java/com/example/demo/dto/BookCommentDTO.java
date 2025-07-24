package com.example.demo.dto;

import lombok.Data;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
@Data
public class BookCommentDTO {

    private Integer bookId;

    private Integer userId;
    private String bookName;
    private String userName;
    private String byPerson;
    @NotBlank
    private String content;

    private Integer rating;
}