package com.example.demo.config;

import com.example.demo.filter.JwtAuthenticationFilter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Value("${file.upload-path}")
    private String uploadPath;

    @Bean
    public JwtAuthenticationFilter jwtAuthenticationFilter() {
        return new JwtAuthenticationFilter();
    }

    @Bean
    public FilterRegistrationBean<JwtAuthenticationFilter> jwtAuthFilter(JwtAuthenticationFilter filter) {
        FilterRegistrationBean<JwtAuthenticationFilter> reg = new FilterRegistrationBean<>(filter);
        reg.addUrlPatterns(
                "/api/*",
                "/index",
                "/empty",
                "/welcome"
        );
        reg.setOrder(1);
        return reg;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 转换为标准文件路径格式（file:///...）
        String location = "file:" + uploadPath.replace("\\", "/");
        if (!location.endsWith("/")) {
            location += "/";
        }

        registry.addResourceHandler("/uploads/**")
                .addResourceLocations(location)
                .setCachePeriod(3600);
    }
}
