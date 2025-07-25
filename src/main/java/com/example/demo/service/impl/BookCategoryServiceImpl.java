package com.example.demo.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.demo.dto.BookCategoryDTO;
import com.example.demo.entity.BookCategory;
import com.example.demo.mapper.BookCategoryMapper;
import com.example.demo.mapper.BookMapper;
import com.example.demo.service.BookCategoryService;
import com.example.demo.service.BookService;
import com.example.demo.vo.BookCategoryVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class BookCategoryServiceImpl extends ServiceImpl<BookCategoryMapper,BookCategory>implements BookCategoryService {
    @Autowired
    private BookCategoryMapper mapper;

    @Autowired
    private BookMapper bookMapper;

    @Override
    public Page<BookCategoryVO> page(int page, int size) {
        Page<BookCategory> p = mapper.selectPage(new Page<>(page, size), new QueryWrapper<>());
        Page<BookCategoryVO> vo = new Page<>(p.getCurrent(), p.getSize(), p.getTotal());
        vo.setRecords(p.getRecords().stream().map(this::toVO).collect(Collectors.toList()));
        return vo;
    }

    @Override
    public void create(BookCategoryDTO dto) {
        BookCategory e = new BookCategory();
        BeanUtils.copyProperties(dto, e);
        mapper.insert(e);
    }

    @Override
    public void update(Integer id, BookCategoryDTO dto) {
        BookCategory e = mapper.selectById(id);
        if (e == null) throw new RuntimeException("分类不存在: " + id);
        BeanUtils.copyProperties(dto, e);
        mapper.updateById(e);
    }

    @Override
    public void delete(Integer id) {
        mapper.deleteById(id);
    }

    @Override
    public void deleteBatch(List<Integer> ids) {
        mapper.deleteBatchIds(ids);
    }

    @Override
    public List<BookCategoryVO> listEnabled() {
        return mapper.selectList(new QueryWrapper<BookCategory>()
                        .eq("status", 1))
                .stream().map(this::toVO).collect(Collectors.toList());
    }

    @Override
    public List<BookCategoryVO> listByParent(Integer parentId) {
        return mapper.selectList(new QueryWrapper<BookCategory>()
                        .eq("parent_id", parentId))
                .stream().map(this::toVO).collect(Collectors.toList());
    }

    @Override
    public List<BookCategoryVO> listRoot() {
        return mapper.selectList(new QueryWrapper<BookCategory>()
                        .isNull("parent_id"))
                .stream().map(this::toVO).collect(Collectors.toList());
    }

    @Override
    public List<BookCategoryVO> tree() {
        List<BookCategoryVO> all = mapper.selectList(new QueryWrapper<>())
                .stream().map(this::toVO).collect(Collectors.toList());
        Map<Integer, BookCategoryVO> map = all.stream()
                .collect(Collectors.toMap(BookCategoryVO::getId, v->v));
        List<BookCategoryVO> roots = new ArrayList<>();
        for (BookCategoryVO vo : all) {
            if (vo.getParentId() == null) {
                roots.add(vo);
            } else {
                BookCategoryVO p = map.get(vo.getParentId());
                if (p != null) p.getChildren().add(vo);
            }
        }
        return roots;
    }

    @Override
    public List<Integer> path(Integer categoryId) {
        List<Integer> path = new ArrayList<>();
        Integer cur = categoryId;
        while (cur != null) {
            path.add(cur);
            BookCategory p = mapper.selectById(cur);
            cur = p.getParentId();
        }
        Collections.reverse(path);
        return path;
    }

    @Override
    public Integer countBooks(Integer categoryId) {
        return bookMapper.countByCategory(categoryId);
    }

    @Override
    public boolean existsCode(String code) {
        return mapper.selectCount(new QueryWrapper<BookCategory>().eq("category_code", code)) > 0;
    }

    @Override
    public boolean existsName(String name) {
        return mapper.selectCount(new QueryWrapper<BookCategory>().eq("category_name", name)) > 0;
    }

    @Override
    public BookCategory getByCode(String code) {
        return mapper.selectOne(new QueryWrapper<BookCategory>().eq("category_code", code));
    }

    @Override
    public void move(Integer id, Integer newParentId) {
        BookCategory e = mapper.selectById(id);
        e.setParentId(newParentId);
        mapper.updateById(e);
    }

    @Override
    public void sort(Integer id, Integer newOrder) {
        BookCategory e = mapper.selectById(id);
        e.setSortOrder(newOrder);
        mapper.updateById(e);
    }

    @Override
    public void batchUpdateStatus(List<Integer> ids, Integer status) {
        if (CollectionUtils.isEmpty(ids)) return;
        ids.forEach(id -> {
            BookCategory e = mapper.selectById(id);
            e.setStatus(status);
            mapper.updateById(e);
        });
    }

    @Override
    public List<Integer> childrenIds(Integer categoryId) {
        // 递归或 SQL CTE 查询，略
        return Collections.singletonList(categoryId);
    }

    @Override
    public List<BookCategoryVO> listAll(int page, int size) {
        return page(page, size).getRecords();
    }

    @Override
    public BookCategoryVO getById(Integer id) {
        return toVO(mapper.selectById(id));
    }

    private BookCategoryVO toVO(BookCategory e) {
        BookCategoryVO v = new BookCategoryVO();
        BeanUtils.copyProperties(e, v);
        return v;
    }
}