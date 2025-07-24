package com.example.demo.dto;

import lombok.Data;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Data
public class BookRecommendationDTO {
    private Integer id;
    private Integer bookId;
    @Size(min = 7, max = 7)
    private String recommendMonth;
    @Size(max = 500)
    private String recommendReason;
    private Integer operatorId;
    private Integer status;
    private String bookName;
    private String imgUrl;
}