package com.example.demo.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;


@Data
public class LendRecordDTO {
    private Long id;
    private Integer readerId;
    private Integer bookId;
    private String bookName;
    private String bookNumber;
    private String username;
    private String isbn;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime lendTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime dueTime;

    private LocalDateTime returnTime;
    private String status;

    private Integer borrowDays;
    private Integer operatorId;
    private String remark;
    private Integer renewalCount;
}