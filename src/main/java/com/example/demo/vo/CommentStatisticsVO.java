package com.example.demo.vo;

import lombok.Data;

@Data
public class CommentStatisticsVO {
    private long total;
    private long positiveCount;
    private double positiveRate;
}