package com.example.demo.vo;

import lombok.Data;

@Data
public class BookRecommendationVO {
    private Integer id;
    private Integer bookId;
    private String recommendMonth;
    private String recommendReason;
    private Integer operatorId;
    private Integer status;
    private String bookName;
    private String operatorName;
    private String imgUrl;
    private String createTime;
    private String updateTime;
}