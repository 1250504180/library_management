package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * 通用页面跳转控制器，根据模板目录动态返回对应页面
 */
@Controller
public class PageController {

    /**
     * 根路径和登录页
     */
    @GetMapping({"/", "/login"})
    public String login() {

        return "login";  // 渲染 templates/login.html
    }

    /**
     * 显式映射首页
     */
    @GetMapping("/index")
    public String index() {

        return "index";  // 渲染 templates/index.html
    }

    /**
     * 单页映射（排除 api、login、index）
     */
    @GetMapping("/{page:^(?!api$|login$|index$)[\\w\\-]+}")
    public String singlePage(@PathVariable String page) {

        return page;      // 渲染 templates/{page}.html
    }

    /**
     * 模块子页映射，如 /book/list 对应 templates/book/list.html
     */

    @GetMapping("/{module:^(?!api$|login$|index$|uploads$)[\\w\\-]+}/{page}")
    public String modulePage(@PathVariable String module,
                             @PathVariable String page) {
        return module + "/" + page;
    }
}
