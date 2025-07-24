package com.example.demo.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.dto.SystemStatsDTO;
import com.example.demo.entity.SystemStats;
import com.example.demo.vo.SystemStatsVO;

import java.time.LocalDate;
import java.util.List;

public interface SystemStatsService {
    /** 分页查询所有统计记录 */
    Page<SystemStatsVO> page(int page, int size);

    /** 获取所有（不分页） */
    List<SystemStatsVO> listAll();

    /** 根据 ID 获取一条 */
    SystemStatsVO getById(Integer id);

    /** 根据日期获取统计 */
    SystemStatsVO getByDate(LocalDate date);

    /** 根据范围查询 */
    List<SystemStatsVO> listByRange(LocalDate from, LocalDate to);

    /** 获取今天 */
    SystemStatsVO getToday();

    /** 获取最近 N 天 */
    List<SystemStatsVO> getRecent(int days);

    /** 新增或初始化某日 */
    void initForDate(LocalDate date);

    /** 新增统计各项 */
    void addNewUser(LocalDate date, int count);
    void addNewBook(LocalDate date, int count);
    void addBorrow(LocalDate date, int count);
    void addReturn(LocalDate date, int count);
    void addVisit(LocalDate date, int count);
    void addComment(LocalDate date, int count);

    /** 更新整条记录 */
    void updateStats(Integer id, SystemStatsDTO dto);

    /** 删除过期数据 */
    void cleanupBefore(LocalDate date);
}

