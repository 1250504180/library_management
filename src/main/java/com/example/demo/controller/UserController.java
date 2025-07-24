package com.example.demo.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.annotation.LogExecution;
import com.example.demo.commom.Result;
import com.example.demo.commom.UserContext;
import com.example.demo.dto.*;
import com.example.demo.entity.User;
import com.example.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/api/user")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private UserContext userContext;

    @GetMapping("/{id}")
    public Result<User> getUser(@PathVariable Integer id) {
        User user=userService.getById(id);
        return Result.success(user);
    }

    /**
     *
     * @return
     */
    @LogExecution
    @GetMapping("/currUser")
    public Result<User> currUser() {
        Long id = userContext.getUserId();
        User u = userService.getById(id);
        return Result.success(u);
    }

    /**
     *
     * @param user
     * @return
     */
    @LogExecution
    @PostMapping("/register")
    public Result<String> register(@RequestBody User user) {
        return userService.register(user);
    }

    @GetMapping
    public Result<Page<User>> page(@RequestParam int page, @RequestParam int size) {
        return Result.success(userService.pageUsers(page, size));
    }

    /**
     *
     * @param user
     * @return
     */
    @LogExecution
    @PostMapping
    public Result<String> add(@RequestBody User user) {
        userService.addUser(user);
        return Result.success("新增成功");
    }

    /**
     *
     * @param user
     * @return
     */
    @PutMapping
    @LogExecution
    public Result<String> update(@RequestBody User user) {
        userService.updateUser(user);
        return Result.success("更新成功");
    }

    @PutMapping("/password")
    public Result<String> changePwd(@RequestBody PasswordDto dto) {
        userService.changePassword(dto);
        return Result.success("密码修改成功");
    }

    /**
     *
     * @param id
     * @return
     */
    @LogExecution
    @DeleteMapping("/{id}")
    public Result<String> delete(@PathVariable Integer id) {
        userService.deleteUser(id);
        return Result.success("删除成功");
    }

    /**
     *
     * @param ids
     * @return
     */
    @LogExecution
    @PostMapping("/deleteBatch")
    public Result<String> deleteBatch(@RequestBody String[] ids) {
        userService.deleteBatch(ids);
        return Result.success("批量删除成功");
    }

    /**
     *
     * @param req
     * @return
     */
    @LogExecution
    @PostMapping("/batchUpdateStatus")
    public Result<String> batchUpdateStatus(@RequestBody BatchStatusUpdateRequest req) {
        userService.batchUpdateStatus(req.getIds(), req.getStatus());
        return Result.success("批量设置状态成功");
    }

    /**
     *
     * @param nickName
     * @param page
     * @param size
     * @return
     */
    @LogExecution
    @GetMapping("/search")
    public Result<Page<User>> searchUsers(
            @RequestParam(required = false) String nickName,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        UserSearchCriteria criteria = new UserSearchCriteria();
        criteria.setNickName(nickName);
        // 你可以加其它筛选条件（如 phone、role...），这里只做关键字演示
        Page<User> result = userService.searchUsers(criteria, page, size);
        return Result.success(result);
    }
}
