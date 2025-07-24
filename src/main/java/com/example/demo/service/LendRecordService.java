package com.example.demo.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.demo.commom.Result;
import com.example.demo.vo.LendRecordVO;
import com.example.demo.dto.LendRecordDTO;
import com.example.demo.entity.LendRecord;

public interface LendRecordService extends IService<LendRecord> {
    Page<LendRecordVO> page(int page, int size);
    Result<String> create(LendRecordDTO dto);
    void update(Long id,LendRecordDTO dto);
    void returned(Integer id);            // 归还图书
    void deleteById(Integer id);
    LendRecordVO getById(Integer id);
    Page<LendRecordVO> search(String keyword, int page, int size);
    Object page(int page, int size, String keyword);
}
