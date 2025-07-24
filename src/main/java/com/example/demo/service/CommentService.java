package com.example.demo.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.demo.dto.BookCommentDTO;
import com.example.demo.entity.BookComment;
import com.example.demo.vo.BookCommentVO;
import com.example.demo.vo.CommentStatisticsVO;

import java.util.List;

public interface CommentService extends IService<BookComment> {
    void createComment(BookCommentDTO dto);
    void updateComment(Integer id, BookCommentDTO dto);
    void deleteComment(Integer id);
    void deleteCommentsBatch(List<Integer> ids);

    Page<BookCommentVO> pageWithKeyword(int page, int size, String keyword);


    Page<BookCommentVO> pageByBook(Integer bookId, int page, int size);
    Page<BookCommentVO> pageByUser(Integer userId, int page, int size);

    double calcAverageRating(Integer bookId);
    CommentStatisticsVO getStatistics(Integer bookId);
    boolean hasCommented(Integer bookId, Integer userId);

    List<BookCommentVO> latestComments(int limit);
    List<BookCommentVO> highRatedComments(int limit);

    void updateStatus(Integer id, Integer status);
    void updateStatusBatch(List<Integer> ids, Integer status);

    Page<BookCommentVO> page(int page, int size);
}