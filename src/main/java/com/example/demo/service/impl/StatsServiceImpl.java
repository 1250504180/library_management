package com.example.demo.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.demo.entity.LendRecord;
import com.example.demo.mapper.BookMapper;
import com.example.demo.mapper.LendRecordMapper;
import com.example.demo.mapper.SysLogMapper;
import com.example.demo.mapper.UserMapper;
import com.example.demo.service.StatsService;
import com.example.demo.vo.TrendPoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class StatsServiceImpl implements StatsService {

    @Autowired
    private LendRecordMapper lendRecordMapper;
    @Autowired private SysLogMapper sysLogMapper;
    @Autowired private UserMapper userMapper;
    @Autowired private BookMapper bookMapper;

    @Override
    public List<Map<String, Object>> getBorrowTrend(int days) {
        LocalDateTime startDate = LocalDate.now().minusDays(days - 1).atStartOfDay();
        LocalDateTime endDate = LocalDate.now().plusDays(1).atStartOfDay();

        QueryWrapper<LendRecord> wrapper = new QueryWrapper<>();
        wrapper.ge("lend_time", startDate);
        wrapper.lt("lend_time", endDate);

        List<LendRecord> records = lendRecordMapper.selectList(wrapper);

        Map<String, Long> counts = records.stream()
                .collect(Collectors.groupingBy(
                        r -> r.getLendTime().toLocalDate().format(DateTimeFormatter.ISO_DATE),
                        LinkedHashMap::new,
                        Collectors.counting()
                ));

        return counts.entrySet().stream().map(e -> {
            Map<String, Object> map = new LinkedHashMap<>();
            map.put("date", e.getKey());
            map.put("count", e.getValue());
            return map;
        }).collect(Collectors.toList());
    }

    @Override
    public List<TrendPoint> getUserTrend() {
        return userMapper.countNewUsersByDay(7);
    }

    @Override
    public List<TrendPoint> getBookTrend() {
        return bookMapper.countNewBooksByDay(7);
    }

    @Override
    public List<TrendPoint> getBorrowTrend() {
        return lendRecordMapper.countBorrowsByDay(7);
    }

    @Override
    public List<TrendPoint> getVisitTrend() {

        return sysLogMapper.countUniqueLoginsByDay();
    }
}
