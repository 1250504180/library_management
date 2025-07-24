package com.example.demo.commom;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * 业务异常，用于在 Service 层校验失败时抛出
 */
@ResponseStatus(HttpStatus.BAD_REQUEST)
public class BusinessException extends RuntimeException {

    public BusinessException() {
        super();
    }

    public BusinessException(String message) {
        super(message);
    }

    public BusinessException(String message, Throwable cause) {
        super(message, cause);
    }

    public BusinessException(Throwable cause) {
        super(cause);
    }
}
