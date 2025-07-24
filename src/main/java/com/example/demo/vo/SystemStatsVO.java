package com.example.demo.vo;

import lombok.Data;
import java.time.LocalDate;

@Data
public class SystemStatsVO {
    private Integer id;
    private LocalDate statDate;
    private Integer visitCount;
    private Integer newUsers;
    private Integer newBooks;
    private Integer lendCount;
    private Integer returnCount;
    private Integer commentCount;
}
