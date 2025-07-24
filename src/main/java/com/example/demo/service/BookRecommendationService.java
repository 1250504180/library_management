package com.example.demo.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.demo.commom.Result;
import com.example.demo.dto.BookRecommendationDTO;
import com.example.demo.entity.BookRecommendation;
import com.example.demo.vo.BookRecommendationVO;

import java.util.List;

public interface BookRecommendationService extends IService<BookRecommendation> {
    Result<String> create(BookRecommendationDTO dto);
    void update(BookRecommendationDTO dto);
    void delete(Integer id);
    void deleteBatch(List<Integer> ids);

    Page<BookRecommendationVO> page(int page, int size);
    List<BookRecommendationVO> listByMonth(String month);
    List<BookRecommendationVO> current();
    List<BookRecommendationVO> listByBookId(Integer bookId);
    boolean existsMonth(String month);
    List<String> listMonths();

    void activate(Integer id);
    void deactivate(Integer id);
    void updateStatus(Integer id, Integer status);
    void batchUpdateStatus(List<Integer> ids, Integer status);

    BookRecommendationVO detail(Integer id);
    List<BookRecommendationVO> popular(int topN);

    Page<BookRecommendationVO> searchRecommendations(String keyword, int page, int size);
}