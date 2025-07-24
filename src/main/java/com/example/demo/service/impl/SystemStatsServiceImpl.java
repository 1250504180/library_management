package com.example.demo.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.demo.dto.SystemStatsDTO;
import com.example.demo.entity.SystemStats;
import com.example.demo.mapper.SystemStatsMapper;
import com.example.demo.service.SystemStatsService;
import com.example.demo.vo.SystemStatsVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class SystemStatsServiceImpl extends ServiceImpl<SystemStatsMapper,SystemStats> implements SystemStatsService {

    @Autowired
    private SystemStatsMapper mapper;


    private SystemStatsVO toVO(SystemStats e) {
        SystemStatsVO vo = new SystemStatsVO();
        BeanUtils.copyProperties(e, vo);
        return vo;
    }

    @Override
    public Page<SystemStatsVO> page(int page, int size) {
        Page<SystemStats> p = mapper.selectPage(
                new Page<>(page, size),
                new QueryWrapper<>()
        );
        Page<SystemStatsVO> voPage = new Page<>(p.getCurrent(), p.getSize(), p.getTotal());
        voPage.setRecords(p.getRecords().stream().map(this::toVO).collect(Collectors.toList()));
        return voPage;
    }

    @Override
    public List<SystemStatsVO> listAll() {
        return mapper.selectList(new QueryWrapper<>())
                .stream()
                .map(this::toVO)
                .collect(Collectors.toList());
    }

    @Override
    public SystemStatsVO getById(Integer id) {
        SystemStats e = mapper.selectById(id);
        return e == null ? null : toVO(e);
    }

    @Override
    public SystemStatsVO getByDate(LocalDate date) {
        SystemStats e = mapper.selectOne(
                new QueryWrapper<SystemStats>()
                        .eq("stat_date", date)
        );
        return e == null ? null : toVO(e);
    }

    @Override
    public List<SystemStatsVO> listByRange(LocalDate from, LocalDate to) {
        return mapper.selectList(
                new QueryWrapper<SystemStats>()
                        .ge("stat_date", from)
                        .le("stat_date", to)
        ).stream().map(this::toVO).collect(Collectors.toList());
    }

    @Override
    public SystemStatsVO getToday() {
        return getByDate(LocalDate.now());
    }

    @Override
    public List<SystemStatsVO> getRecent(int days) {
        LocalDate end = LocalDate.now();
        LocalDate start = end.minusDays(days - 1);
        return listByRange(start, end);
    }

    @Override
    public void initForDate(LocalDate date) {
        SystemStats exists = mapper.selectOne(
                new QueryWrapper<SystemStats>().eq("stat_date", date)
        );
        if (exists == null) {
            SystemStats e = new SystemStats();
            e.setStatDate(date);
            e.setVisitCount(0);
            e.setNewUsers(0);
            e.setNewBooks(0);
            e.setLendCount(0);
            e.setReturnCount(0);
            e.setCommentCount(0);
            e.setCreateTime(LocalDateTime.now());
            mapper.insert(e);
        }
    }

    private SystemStats ensureStats(LocalDate date) {
        initForDate(date);
        return mapper.selectOne(
                new QueryWrapper<SystemStats>().eq("stat_date", date)
        );
    }

    @Override
    public void addNewUser(LocalDate date, int count) {
        SystemStats e = ensureStats(date);
        e.setNewUsers(e.getNewUsers() + count);
        e.setUpdateTime(LocalDateTime.now());
        mapper.updateById(e);
    }

    @Override
    public void addNewBook(LocalDate date, int count) {
        SystemStats e = ensureStats(date);
        e.setNewBooks(e.getNewBooks() + count);
        e.setUpdateTime(LocalDateTime.now());
        mapper.updateById(e);
    }

    @Override
    public void addBorrow(LocalDate date, int count) {
        SystemStats e = ensureStats(date);
        e.setLendCount(e.getLendCount() + count);
        e.setUpdateTime(LocalDateTime.now());
        mapper.updateById(e);
    }

    @Override
    public void addReturn(LocalDate date, int count) {
        SystemStats e = ensureStats(date);
        e.setReturnCount(e.getReturnCount() + count);
        e.setUpdateTime(LocalDateTime.now());
        mapper.updateById(e);
    }

    @Override
    public void addVisit(LocalDate date, int count) {
        SystemStats e = ensureStats(date);
        e.setVisitCount(e.getVisitCount() + count);
        e.setUpdateTime(LocalDateTime.now());
        mapper.updateById(e);
    }

    @Override
    public void addComment(LocalDate date, int count) {
        SystemStats e = ensureStats(date);
        e.setCommentCount(e.getCommentCount() + count);
        e.setUpdateTime(LocalDateTime.now());
        mapper.updateById(e);
    }

    @Override
    public void updateStats(Integer id, SystemStatsDTO dto) {
        SystemStats e = mapper.selectById(id);
        if (e == null) {
            throw new IllegalArgumentException("统计记录不存在: " + id);
        }
        BeanUtils.copyProperties(dto, e);
        e.setUpdateTime(LocalDateTime.now());
        mapper.updateById(e);
    }

    @Override
    public void cleanupBefore(LocalDate date) {
        mapper.delete(
                new QueryWrapper<SystemStats>()
                        .lt("stat_date", date)
        );
    }
}