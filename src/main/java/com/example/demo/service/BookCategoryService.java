package com.example.demo.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.demo.dto.BookCategoryDTO;
import com.example.demo.entity.BookCategory;
import com.example.demo.vo.BookCategoryVO;
import java.util.List;

public interface BookCategoryService extends IService<BookCategory> {
    Page<BookCategoryVO> page(int page, int size);
    void create(BookCategoryDTO dto);
    void update(Integer id, BookCategoryDTO dto);
    void delete(Integer id);
    void deleteBatch(List<Integer> ids);

    List<BookCategoryVO> listEnabled();
    List<BookCategoryVO> listByParent(Integer parentId);
    List<BookCategoryVO> listRoot();
    List<BookCategoryVO> tree();
    List<Integer> path(Integer categoryId);
    Integer countBooks(Integer categoryId);

    boolean existsCode(String code);
    boolean existsName(String name);

    void move(Integer id, Integer newParentId);
    void sort(Integer id, Integer newOrder);
    void batchUpdateStatus(List<Integer> ids, Integer status);

    List<Integer> childrenIds(Integer categoryId);
    List<BookCategoryVO> listAll(int page, int size);
    BookCategoryVO getById(Integer id);
}