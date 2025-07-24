package com.example.demo.vo;

import lombok.Data;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
public class BookCategoryVO {
    private Integer id;
    private String categoryName;
    private String categoryCode;
    private String description;
    private Integer sortOrder;
    private Integer status;
    private Integer parentId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private List<BookCategoryVO> children = new ArrayList<>();
}
