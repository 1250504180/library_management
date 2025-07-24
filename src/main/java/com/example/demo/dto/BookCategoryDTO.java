package com.example.demo.dto;

import lombok.Data;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data
public class BookCategoryDTO {
    @NotBlank private String categoryName;
    @NotBlank private String categoryCode;
    private String description;
    private Integer sortOrder;
    private Integer status;
    private Integer parentId;
}