package com.example.demo.dto;

import lombok.Data;
import java.time.LocalDate;

@Data
public class SystemStatsDTO {
    private LocalDate statDate;
    private Integer visitCount;
    private Integer newUsers;
    private Integer newBooks;
    private Integer lendCount;
    private Integer returnCount;
    private Integer commentCount;
}

