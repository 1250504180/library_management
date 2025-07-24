package com.example.demo.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class BookDto {
    private Integer id;
    private String bookNumber, isbn, language;
    private String nameCn, nameId, author, translator, publisher, description, coverImage;
    private LocalDate publishDate;
    private BigDecimal price;
    private Long categoryId;
    private String location;
    private Integer totalQuantity, availableQuantity;
    private Integer status;
    private String translationunit;
}