package com.example.demo.filter;

import com.example.demo.commom.UserContext;
import com.example.demo.utils.JwtTokenUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Set;

/**
 * JWT 认证过滤器，支持从 Authorization 头或 token Cookie 中提取 JWT
 */
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Autowired
    private UserContext userContext;

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain)
            throws ServletException, IOException {

        String uri = request.getRequestURI();
        if (uri.startsWith("/uploads/")) {
            filterChain.doFilter(request, response);
            return;
        }

        // 1. 先从 Authorization 头读取
        String token = null;
        String header = request.getHeader("Authorization");
        if (header != null && header.startsWith("Bearer ")) {
            token = header.substring(7);
        }

        // 2. 如果头里没有，再从 Cookie 中读取
        if (token == null && request.getCookies() != null) {
            for (Cookie c : request.getCookies()) {
                if ("token".equals(c.getName())) {
                    token = c.getValue();
                    break;
                }
            }
        }

        // 3. 校验 Token
        if (token != null && jwtTokenUtil.validateToken(token)) {
            Long userId = jwtTokenUtil.getUserIdFromToken(token);
            Long role   = jwtTokenUtil.getRoleFromToken(token);
            userContext.setUserId(userId);
            filterChain.doFilter(request, response);  // 放行
        } else {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);  // 拦截
        }
    }
}

