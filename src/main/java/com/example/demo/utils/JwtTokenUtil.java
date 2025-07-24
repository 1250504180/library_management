package com.example.demo.utils;

import io.jsonwebtoken.*;
import org.springframework.stereotype.Component;
import java.util.Date;

/**
 * JWT 工具，生成与解析 Token
 */
@Component
public class JwtTokenUtil {
    private static final String SECRET_KEY = "fafwedwadwuvdgawvduvwdaibdwoddiwaybdhiawidwaawviyvdakjwdabdiaudboawdbouabdabdwafwegerrrqefwgegwefgfegewg";
    private static final long EXPIRATION = 1000 * 60 * 60 * 24; // 1 天

    /**
     * 生成 token，传入用户 id 和用户名
     */
    public static String generateToken(Long userId, String username,Long role) {
        return Jwts.builder()
                .setSubject(username)
                .claim("userId", userId)
                .claim("role", role)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION))
                .signWith(SignatureAlgorithm.HS256, SECRET_KEY)
                .compact();
    }

    /**
     * 校验 token 是否合法、是否过期
     */
    public static boolean validateToken(String token) {
        try {
            if (token == null || token.isEmpty()) return false;
            Jwts.parser().setSigningKey(SECRET_KEY).parseClaimsJws(token);
            return true;
        } catch (JwtException e) {
            return false;
        }
    }

    /**
     * 从 token 中获取用户 ID
     */
    public static Long getUserIdFromToken(String token) {
        Claims claims = Jwts.parser()
                .setSigningKey(SECRET_KEY)
                .parseClaimsJws(token)
                .getBody();
        return claims.get("userId", Long.class);
    }

    public static Long getRoleFromToken(String token) {
        Claims claims = Jwts.parser()
                .setSigningKey(SECRET_KEY)
                .parseClaimsJws(token)
                .getBody();
        return claims.get("Role", Long.class);
    }

    /**
     * 从 token 中获取用户名
     */
    public static String getUsernameFromToken(String token) {
        Claims claims = Jwts.parser()
                .setSigningKey(SECRET_KEY)
                .parseClaimsJws(token)
                .getBody();
        return claims.getSubject();
    }
}