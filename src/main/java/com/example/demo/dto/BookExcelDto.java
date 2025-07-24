package com.example.demo.dto;

import com.alibaba.excel.annotation.ExcelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class BookExcelDto {
    @ExcelProperty("ID")
    private Integer id;

    @ExcelProperty("编号")
    private String bookNumber;

    @ExcelProperty("ISBN")
    private String isbn;

    @ExcelProperty("书名")
    private String nameCn;

    @ExcelProperty("名称ID")
    private String nameId;

    @ExcelProperty("语言")
    private String language;

    @ExcelProperty("作者")
    private String author;

    @ExcelProperty("译者")
    private String translator;

    @ExcelProperty("出版社")
    private String publisher;

    @ExcelProperty("出版日期")
    private LocalDate publishDate;

    @ExcelProperty("定价")
    private BigDecimal price;

    @ExcelProperty("分类ID")
    private Integer categoryId;

    @ExcelProperty("位置")
    private String location;

    @ExcelProperty("库存")
    private Integer totalQuantity;

    @ExcelProperty("可借数")
    private Integer availableQuantity;

    @ExcelProperty("借出次数")
    private Integer borrowCount;

    @ExcelProperty("状态")
    private Integer status;

    @ExcelProperty("描述")
    private String description;

    @ExcelProperty("封面图片")
    private String coverImage;

    @ExcelProperty("平均评分")
    private BigDecimal ratingAvg;

    @ExcelProperty("创建时间")
    private LocalDateTime createTime;

    @ExcelProperty("更新时间")
    private LocalDateTime updateTime;
}
