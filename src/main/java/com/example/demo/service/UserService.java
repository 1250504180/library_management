package com.example.demo.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.demo.commom.Result;
import com.example.demo.dto.*;
import com.example.demo.entity.Book;
import com.example.demo.entity.User;

import java.util.List;

public interface UserService extends IService<User> {
    Result<String> register(User user);
    Page<User> pageUsers(int page, int size);
    void addUser(User user);
    void updateUser(User user);
    void changePassword(PasswordDto dto);
    void deleteUser(Integer id);
    void deleteBatch(String[] ids);
    Page<User> searchUsers(UserSearchCriteria criteria, int page, int size);

    void batchUpdateStatus(List<Integer> ids, Integer status);

    User getByName(String username);
}