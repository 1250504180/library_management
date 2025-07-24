package com.example.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.demo.entity.BookComment;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BookCommentMapper extends BaseMapper<BookComment> {
}
