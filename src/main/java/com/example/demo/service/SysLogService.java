package com.example.demo.service;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.demo.entity.SysLog;

public interface SysLogService extends IService<SysLog> {
    IPage<SysLog> searchLogs(int page, int size, String keyword);
}
