package com.example.demo.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.annotation.LogExecution;
import com.example.demo.commom.Result;
import com.example.demo.entity.LendRecord;
import com.example.demo.mapper.LendRecordMapper;
import com.example.demo.service.BookService;
import com.example.demo.vo.LendRecordVO;
import com.example.demo.dto.LendRecordDTO;
import com.example.demo.service.LendRecordService;
import lombok.AllArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/LendRecord")
public class LendRecordController {

    @Autowired
    private  LendRecordService svc;

    @Autowired
    private LendRecordMapper lendRecordMapper;
    @Autowired
    private LendRecordService lendRecordService;

    /**
     *
     * @param dto
     */
    @LogExecution
    @PostMapping
    public Result<String> create(@Valid @RequestBody LendRecordDTO dto) {

        return svc.create(dto);
    }

    @PutMapping("/{id}")
    public void update(@PathVariable Long id,@Valid @RequestBody LendRecordDTO dto) {
        svc.update(id,dto);
    }

    /**
     *
     * @param id
     */
    @LogExecution
    @PutMapping("/return")
    public void returned(@RequestParam Integer id) {
        svc.returned(id);
    }

    /**
     *
     * @param id
     */
    @LogExecution
    @DeleteMapping("/{id}")
    public void delete(@PathVariable Integer id) {
        svc.deleteById(id);
    }

    @GetMapping("/{id}")
    public LendRecordVO getById(@PathVariable Integer id) {
        return svc.getById(id);
    }

    /**
     *
     * @param page
     * @param size
     * @param keyword
     * @return
     */
    @LogExecution
    @GetMapping
    public Result<Page<LendRecordVO>> page(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword
    ) {
        return Result.success((Page<LendRecordVO>) svc.page(page, size,keyword));
    }

    /**
     *
     * @param keyword
     * @param page
     * @param size
     * @return
     */
    @LogExecution
    @GetMapping("/search")
    public Result<Page<LendRecordVO>> search(
            @RequestParam(required = false) String keyword,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size
    ) {
        Page<LendRecordVO> resultPage = lendRecordService.search(keyword, page, size);
        return Result.success(resultPage);
    }
}
