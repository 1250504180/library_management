package com.example.demo.controller;

import com.example.demo.commom.Result;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

@RestController
@RequestMapping("/api")
public class FileUploadController {

    @Value("${file.upload-path}")
    private String uploadPath;

    @PostMapping("/upload")
    public Result<String> upload(@RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            return Result.error("文件为空");
        }
        try {
            // 确保目录存在
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // 保存文件
            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            File dest = new File(uploadDir, fileName);
            file.transferTo(dest);

            // 返回访问URL（统一用 /uploads/ 前缀）
            return Result.success("/uploads/" + fileName);
        } catch (IOException e) {
            return Result.error("上传失败：" + e.getMessage());
        }
    }

}
