FROM openjdk:8-jre-alpine

# 设置工作目录
WORKDIR /app

# 复制jar文件
COPY ./target/library_management_system-1.0-SNAPSHOT.jar app.jar

# 创建上传目录
RUN mkdir -p /app/uploads

# 暴露端口
EXPOSE 8080

# 启动命令
ENTRYPOINT ["java", "-jar", "/app/app.jar"]