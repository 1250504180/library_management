package com.example.demo.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class LendRecordVO {

    private Integer id;
    private Integer readerId;
    private Integer bookId;
    private String bookName;

    private String bookNumber;

    private LocalDateTime lendTime;
    private LocalDateTime dueTime;

    private LocalDateTime returnTime;
    private String status;
    private Integer borrowDays;
    private Integer operatorId;
    private String remark;

    private Integer renewalCount;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    
    // 图书图片URL
    private String bookImageUrl;
}

