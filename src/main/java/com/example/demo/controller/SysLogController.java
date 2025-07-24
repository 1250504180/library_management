package com.example.demo.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.example.demo.commom.Result;
import com.example.demo.entity.SysLog;
import com.example.demo.service.SysLogService;
import com.example.demo.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/log")
@RequiredArgsConstructor
public class SysLogController {

    private final SysLogService sysLogService;
    private final UserService userService;

    /**
     * 分页查询日志
     */
    @GetMapping("/searches")
    public Result<IPage<SysLog>> searchLogs(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword
    ) {
        IPage<SysLog> result = sysLogService.searchLogs(page, size, keyword);
        for (SysLog sysLog : result.getRecords()) {
            Integer userId = Integer.valueOf(sysLog.getUsername());
            sysLog.setUsername(userService.getById(userId).getUsername());
        }
        return Result.success(result);
    }

    /**
     * 批量删除
     */
    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody Map<String, List<Long>> payload) {
        List<Long> ids = payload.get("ids");
        if (ids != null && !ids.isEmpty()) {
            sysLogService.removeByIds(ids);
        }
        return Result.success();
    }

    /**
     * 删除单条日志
     */
    @DeleteMapping("/{id}")
    public Result<?> deleteById(@PathVariable Long id) {
        sysLogService.removeById(id);
        return Result.success();
    }
}