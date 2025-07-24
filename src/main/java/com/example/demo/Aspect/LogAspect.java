package com.example.demo.Aspect;

import com.example.demo.commom.UserContext;
import com.example.demo.entity.SysLog;
import com.example.demo.mapper.SysLogMapper;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.slf4j.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import java.time.LocalDateTime;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.aspectj.lang.reflect.MethodSignature;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;
import java.util.Arrays;


@Aspect
@Component
@Slf4j
public class LogAspect {

    @Autowired
    private UserContext userContext;
    @Autowired
    private SysLogMapper sysLogMapper;

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Around("@annotation(com.example.demo.annotation.LogExecution)")
    public Object logAround(ProceedingJoinPoint pjp) throws Throwable {
        SysLog record = new SysLog();

        // 获取当前用户
        Long userId = userContext.getUserId();
        record.setUsername(userId != null ? userId.toString() : "login");

        // 获取方法签名
        MethodSignature signature = (MethodSignature) pjp.getSignature();
        Method method = signature.getMethod();
        String className = signature.getDeclaringType().getSimpleName();
        String methodName = method.getName();

        // 记录类名和方法名
        record.setClassName(className);
        record.setMethodName(methodName);

        // 参数序列化（安全处理）
        try {
            Object[] args = Arrays.stream(pjp.getArgs())
                    .filter(arg -> !(arg instanceof HttpServletRequest || arg instanceof HttpServletResponse))
                    .toArray();
            String paramsJson = objectMapper.writeValueAsString(args);
            record.setParams(paramsJson);
        } catch (Exception e) {
            record.setParams("参数序列化失败: " + e.getMessage());
        }

        record.setCreateTime(LocalDateTime.now());

        Object result;
        try {
            result = pjp.proceed();
            record.setLogType("INFO");
        } catch (Throwable ex) {
            record.setLogType("ERROR");
            record.setException(ex.getClass().getSimpleName() + ": " + ex.getMessage());
            throw ex;
        } finally {
            sysLogMapper.insert(record);
        }

        return result;
    }

}
