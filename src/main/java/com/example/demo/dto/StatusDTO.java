package com.example.demo.dto;

import lombok.Data;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

@Data
public class StatusDTO {
    @NotEmpty
    private List<Long> ids;
    @NotNull
    private Integer status;
}