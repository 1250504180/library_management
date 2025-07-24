package com.example.demo.dto;

import lombok.Data;

import java.util.List;

@Data
public class BatchStatusDTO {
    private List<Integer> Ids;
    private Integer status;
}