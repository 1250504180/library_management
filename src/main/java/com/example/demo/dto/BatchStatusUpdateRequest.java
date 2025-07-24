package com.example.demo.dto;

import lombok.Data;

import java.util.List;

@Data
public class BatchStatusUpdateRequest {
    private List<Integer> ids;
    private Integer status;
}