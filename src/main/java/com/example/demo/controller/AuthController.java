package com.example.demo.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.demo.annotation.LogExecution;
import com.example.demo.commom.Result;
import com.example.demo.dto.LoginDto;
import com.example.demo.entity.User;
import com.example.demo.mapper.UserMapper;
import com.example.demo.utils.JwtTokenUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UserMapper userMapper;

    /**
     *
     * @param dto
     * @return
     */
    @LogExecution
    @PostMapping("/login")
    public Result<String> login(@RequestBody LoginDto dto) {
        User user = userMapper.selectOne(new QueryWrapper<User>()
                .eq("username", dto.getUsername()));
        if (user == null) {
            return Result.error("用户名不存在");
        }
        // 2. 校验密码
        String password = DigestUtils.md5DigestAsHex(dto.getPassword().getBytes());
        if (!password.equalsIgnoreCase(user.getPassword())) {
            return Result.error("密码错误");
        }
        if (user.getStatus() != 1) {
            return Result.error("账号已禁用");
        }
        String token=JwtTokenUtil.generateToken(user.getId().longValue(), user.getUsername(), (user.getRole().longValue()));
        return Result.success(token);
    }
}
