package com.example.demo.service.impl;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.demo.annotation.LogExecution;
import com.example.demo.commom.Result;
import com.example.demo.dto.*;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;
import com.example.demo.mapper.UserMapper;
import com.example.demo.entity.User;
import com.example.demo.service.UserService;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserService userService;
    @Override
    public Result<String> register(User user) {

        if(user.getUsername()==null||user.getPassword()==null){
            return Result.error("注册信息不全");
        }

        User exist = baseMapper.selectOne(
                new LambdaQueryWrapper<User>()
                        .eq(User::getUsername, user.getUsername())
        );
        if (exist != null) {
            return Result.error("用户名已存在");
        }

        User u = new User();
        BeanUtils.copyProperties(user, u);
        u.setRole(2);
        u.setPassword(DigestUtils.md5DigestAsHex(user.getPassword().getBytes()));

        this.save(u);
        return Result.success("注册成功");
    }

    @Override
    public Page<User> pageUsers(int page, int size) {
        Page<User> p = this.page(new Page<>(page, size));
        Page<User> rePage = new Page<>(p.getCurrent(), p.getSize(), p.getTotal());
        rePage.setRecords(p.getRecords().stream().map(entity -> {
            User vo = new User();
            BeanUtils.copyProperties(entity, vo);
            // TODO: 查询并设置 deptName
            return vo;
        }).collect(Collectors.toList()));
        return rePage;
    }


    @Override
    public void addUser(User user) {
        User u = new User();
        BeanUtils.copyProperties(user, u);
        if (user.getPassword() == null) {
            u.setPassword(DigestUtils.md5DigestAsHex("123456".getBytes()));
        } else {
            u.setPassword(DigestUtils.md5DigestAsHex(user.getPassword().getBytes()));
        }
        System.out.println("即将入库的加密密码：" + u.getPassword());
        save(u);
    }

    /**
     *
     * @param user
     */
    @LogExecution
    @Override
    public void updateUser(User user) {
        User u = new User();
        BeanUtils.copyProperties(user, u);
        User tmp_user=userService.getById(user.getId());

        String inputPassword = user.getPassword();

        String oldPassword = tmp_user.getPassword();

        String encryptedInputPassword = DigestUtils.md5DigestAsHex(inputPassword.getBytes());

        if (!oldPassword.equals(encryptedInputPassword)&&!oldPassword.equals(inputPassword)) {
            // 说明密码已被修改，重新加密后保存
            u.setPassword(encryptedInputPassword);
        } else {
            // 说明密码未变，保持原加密密码
            u.setPassword(oldPassword);
        }

        updateById(u);
    }

    @Override
    public void changePassword(PasswordDto dto) {
        User u = getById(dto.getUserId());
        if (u == null || !u.getPassword().equals(DigestUtils.md5DigestAsHex(dto.getOldPassword().getBytes()))) {
            throw new RuntimeException("原密码不正确");
        }
        u.setPassword(DigestUtils.md5DigestAsHex(dto.getNewPassword().getBytes()));
        updateById(u);
    }

    @Override
    public void deleteUser(Integer id) {
        removeById(id);
    }

    @Override
    public void deleteBatch(String[] ids) {
        removeByIds(java.util.Arrays.asList(ids));
    }

    @Override
    public Page<User> searchUsers(UserSearchCriteria criteria, int page, int size) {
        Page<User> pageInfo = new Page<>(page, size);
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();

        // 支持昵称/用户名模糊查，关键代码
        if (StringUtils.isNotBlank(criteria.getNickName())) {
            queryWrapper.and(q -> q.like(User::getNickName, criteria.getNickName())
                    .or().like(User::getUsername, criteria.getNickName()));
        }

        return userMapper.selectPage(pageInfo, queryWrapper);
    }

    @Override
    public void batchUpdateStatus(List<Integer> ids, Integer status) {
        if (ids == null || ids.isEmpty() || status == null) return;
        UpdateWrapper<User> update = new UpdateWrapper<>();
        update.in("id", ids).set("status", status);
        this.update(update);
    }

    @Override
    public User getByName(String username) {
        return this.getOne(
                new LambdaQueryWrapper<User>()
                        .eq(User::getUsername, username)
        );
    }
}