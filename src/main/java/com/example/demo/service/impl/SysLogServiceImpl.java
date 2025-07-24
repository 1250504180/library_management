package com.example.demo.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.demo.entity.SysLog;
import com.example.demo.mapper.SysLogMapper;
import com.example.demo.mapper.UserMapper;
import com.example.demo.service.SysLogService;
import com.example.demo.service.UserService;
import org.aspectj.lang.annotation.After;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
public class SysLogServiceImpl extends ServiceImpl<SysLogMapper, SysLog> implements SysLogService {
    @Autowired
    private UserService userService;

    @Override
    public IPage<SysLog> searchLogs(int page, int size, String keyword) {
        LambdaQueryWrapper<SysLog> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.isNotBlank(keyword)) {
            wrapper.like(SysLog::getUsername, keyword)
                    .or().like(SysLog::getClassName, keyword)
                    .or().like(SysLog::getMethodName, keyword)
                    .or().like(SysLog::getParams, keyword)
                    .or().like(SysLog::getResult, keyword)
                    .or().like(SysLog::getLogType, keyword)
                    .or().like(SysLog::getException, keyword);
        }
        wrapper.orderByDesc(SysLog::getCreateTime);

        return this.page(new Page<>(page, size), wrapper);
    }
}
