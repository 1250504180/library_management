package com.example.demo.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data
public class RecDTO {
    @NotNull
    private Long bookId;
    @NotBlank
    private String recommendMonth;
    private String recommendReason;
    @NotNull private Long operatorId;
    private Integer status;
}