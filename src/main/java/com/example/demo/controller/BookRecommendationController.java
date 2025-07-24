package com.example.demo.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.annotation.LogExecution;
import com.example.demo.commom.Result;
import com.example.demo.dto.BookRecommendationDTO;
import com.example.demo.service.BookRecommendationService;
import com.example.demo.vo.BookRecommendationVO;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/api/recommendation")
public class BookRecommendationController {
    
    @Resource
    private BookRecommendationService svc;
    /**
     *
     * @param dto
     * @return
     */

    @LogExecution
    @PostMapping
    public Result<String> create(@Validated @RequestBody BookRecommendationDTO dto) {
        return svc.create(dto);
    }

    @PutMapping
    public Result<Void> update(@Validated @RequestBody BookRecommendationDTO dto) {
        svc.update(dto);
        return Result.success();
    }

    /**
     *
     * @param id
     * @return
     */
    @LogExecution
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Integer id) {
        svc.delete(id);
        return Result.success();
    }

    /**
     *
     * @param ids
     * @return
     */
    @LogExecution
    @PostMapping("/deleteBatch")
    public Result<Void> deleteBatch(@RequestBody List<Integer> ids) {
        svc.deleteBatch(ids);
        return Result.success();
    }

    /**
     *
     * @param page
     * @param size
     * @return
     */
    @LogExecution
    @GetMapping("/search")
    public Result<Page<BookRecommendationVO>> search(
            @RequestParam(required = false) String keyword,
            @RequestParam int page,
            @RequestParam int size) {

        Page<BookRecommendationVO> result = svc.searchRecommendations(keyword, page, size);
        return Result.success(result);
    }

    @GetMapping("/month/{m}")
    public Result<List<BookRecommendationVO>> byMonth(@PathVariable("m") String m) {
        return Result.success(svc.listByMonth(m));
    }

    @GetMapping("/current")
    public Result<List<BookRecommendationVO>> current() {
        return Result.success(svc.current());
    }

    @GetMapping("/book/{bookId}")
    public Result<List<BookRecommendationVO>> byBook(@PathVariable Integer bookId) {
        return Result.success(svc.listByBookId(bookId));
    }

    @GetMapping("/checkMonth")
    public Result<Boolean> checkMonth(@RequestParam String month) {
        return Result.success(svc.existsMonth(month));
    }

    @GetMapping("/months")
    public Result<List<String>> months() {
        return Result.success(svc.listMonths());
    }

    @PostMapping("/activate/{id}")
    public Result<Void> activate(@PathVariable Integer id) {
        svc.activate(id);
        return Result.success();
    }

    @PostMapping("/deactivate/{id}")
    public Result<Void> deactivate(@PathVariable Integer id) {
        svc.deactivate(id);
        return Result.success();
    }

    /**
     *
     * @param ids
     * @param status
     * @return
     */
    @LogExecution
    @PostMapping("/batchUpdateStatus")
    public Result<Void> batchUpdateStatus(
            @RequestParam List<Integer> ids,
            @RequestParam Integer status) {
        svc.batchUpdateStatus(ids, status);
        return Result.success();
    }

    @GetMapping("/detail/{id}")
    public Result<BookRecommendationVO> detail(@PathVariable Integer id) {
        return Result.success(svc.detail(id));
    }

    @GetMapping("/popular")
    public Result<List<BookRecommendationVO>> popular(@RequestParam(defaultValue = "5") int topN) {
        return Result.success(svc.popular(topN));
    }
}
