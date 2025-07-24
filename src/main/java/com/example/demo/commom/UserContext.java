package com.example.demo.commom;

import org.springframework.stereotype.Component;

@Component
public class UserContext {
    // 每个线程有自己的一份 userId
    private static final ThreadLocal<Long> userId = new ThreadLocal<>();
    private static final ThreadLocal<Long> UserRole = new ThreadLocal<>();

    /** 设置当前线程的用户ID */
    public static void setUserId(Long Id) {
        userId.set(Id);
    }

    /** 获取当前线程的用户ID */
    public static Long getUserId() {
        return userId.get();
    }

    /** 设置当前线程的用户ID */
    public static void setUserRole(Long Role) {
        UserRole.set(Role);
    }

    /** 获取当前线程的用户ID */
    public static Long getUserRole() {
        return UserRole.get();
    }

    /** 清理，防止内存泄漏 */
    public static void clear() {
        userId.remove();
        UserRole.remove();
    }
}