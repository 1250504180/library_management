# 图书管理系统 - 需求文档与设计文档

## 项目概述

本项目是一个基于Spring Boot + Vue.js的前后端分离图书管理系统，主要用于图书馆或个人图书的管理，包括用户管理、图书管理、借阅管理等核心功能。

## 一、需求文档

### 1.1 功能需求

#### 1.1.1 用户管理模块
- ~~**用户添加**：由管理员添加新用户~~
- **用户登录**：用户通过用户名和密码登录，系统生成JWT Token进行身份认证
- ~~**用户信息管理**：支持用户信息的增删改查操作~~
- ~~**密码管理**：支持用户密码修改功能~~
- ~~**用户搜索**：支持按ID、昵称、电话、地址等条件搜索用户~~

#### 1.1.2 图书管理模块
- **图书信息管理**：支持图书的增删改查操作，包括编号、书名-中文、书名-外语、作者、译者、出版社、出版日期、库存数量、价格、图书位置、分类标签。
- **多语言支持**：支持中文、印尼语、英文、西班牙语等多种语言的图书管理
- **图书搜索**：支持按编号、书名、作者、分类、语言等条件搜索图书
- **批量删除**：支持批量删除图书功能
- **图书状态管理**：管理图书的可借阅状态
- **图书评论系统**：用户可以对图书进行评论和评分（1-5星）
- **图书推荐系统**：管理员可以按月设置推荐图书，包含推荐理由
- **图书评分统计**：自动计算图书平均评分
- **批量导入和导出数据**：使用excel批量导入数据，使用sql和excel批量导出数据
#### 1.1.3 借阅管理模块
- **借阅记录管理**：记录用户借阅图书的详细信息
- **借阅操作**：管理员处理图书借出操作，说明借阅人，借阅时间，预计归还时间等
- **归还操作**：管理员处理图书归还操作，记录实际归还时间
- **借阅状态跟踪**：跟踪图书的借阅状态（已借出、已归还等）

#### 1.1.4 数据统计模块
- **访问统计**：统计系统访问次数
- **用户统计**：统计系统用户总数
- **图书统计**：统计图书总数
- **借阅统计**：统计借阅记录总数



### 1.2 非功能需求

#### 1.2.1 性能需求
- 系统响应时间不超过3秒
- 支持并发用户数不少于100人
- 数据库查询优化，支持分页查询

#### 1.2.2 安全需求
- 使用JWT Token进行用户身份认证
- 密码加密存储
- 防止SQL注入攻击
- 跨域请求控制

#### 1.2.3 可用性需求
- 系统可用性达到99%以上
- 提供友好的用户界面
- 支持多种浏览器访问

## 二、设计文档

### 2.1 系统架构设计

#### 2.1.1 整体架构
```
前端层 (Vue.js)
    ↓
API网关层 (Spring Boot Controller)
    ↓
业务逻辑层 (Service)
    ↓
数据访问层 (MyBatis Plus)
    ↓
数据存储层 (MySQL)
```

#### 2.1.2 技术栈
- **后端框架**：Spring Boot 2.6.1
- **数据库**：MySQL
- **ORM框架**：MyBatis Plus 3.4.3.1
- **身份认证**：JWT (java-jwt 3.18.2)
- **工具库**：Hutool 5.7.16
- **前端框架**：Vue.js
- **构建工具**：Maven

### 2.2 数据库设计

#### 2.2.1 用户表 (user)
| 字段名 | 类型 | 长度 | 说明 | 约束 | 备注 |
|--------|------|------|------|------|------|
| id | INT | - | 用户ID | 主键，自增 | 唯一标识用户 |
| username | VARCHAR | 50 | 用户名 | 唯一，非空 | 登录账号 |
| nick_name | VARCHAR | 50 | 昵称 | 可空 | 显示名称 |
| password | VARCHAR | 100 | 密码 | 非空 | 加密存储 |
| sex | VARCHAR | 10 | 性别 | 可空 | 男/女/其他 |
| address | VARCHAR | 200 | 地址/部门 | 可空 | 联系地址或所属部门 |
| phone | VARCHAR | 20 | 联系电话 | 可空 | 手机号码 |
| role | INT | - | 角色 | 非空，默认2 | 1-管理员，2-普通用户 |
| create_time | DATETIME | - | 创建时间 | 默认当前时间 | 账号创建时间 |
| update_time | DATETIME | - | 更新时间 | 默认当前时间 | 最后修改时间 |
| status | TINYINT | - | 账号状态 | 默认1 | 1-正常，0-禁用 |

**建表SQL:**
```sql
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `nick_name` varchar(50) DEFAULT NULL COMMENT '昵称',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `sex` varchar(10) DEFAULT NULL COMMENT '性别',
  `address` varchar(200) DEFAULT NULL COMMENT '地址/部门',
  `phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `role` int NOT NULL DEFAULT '2' COMMENT '角色：1-管理员，2-普通用户',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` tinyint DEFAULT '1' COMMENT '账号状态：1-正常，0-禁用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';
```

#### 2.2.2 图书分类表 (book_category)
| 字段名 | 类型 | 长度 | 说明 | 约束 | 备注 |
|--------|------|------|------|------|------|
| id | INT | - | 分类ID | 主键，自增 | 唯一标识分类 |
| category_name | VARCHAR | 50 | 分类名称 | 非空，唯一 | 如：文学、科技、历史等 |
| category_code | VARCHAR | 20 | 分类编码 | 非空，唯一 | 分类的唯一编码 |
| description | TEXT | - | 分类描述 | 可空 | 分类详细说明 |
| parent_id | INT | - | 父分类ID | 可空 | 支持多级分类 |
| sort_order | INT | - | 排序序号 | 默认0 | 用于分类排序 |
| status | TINYINT | - | 状态 | 默认1 | 1-启用，0-禁用 |
| create_time | DATETIME | - | 创建时间 | 默认当前时间 | |
| update_time | DATETIME | - | 更新时间 | 默认当前时间 | |

**建表SQL:**
```sql
CREATE TABLE `book_category` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `category_name` varchar(50) NOT NULL COMMENT '分类名称',
  `category_code` varchar(20) NOT NULL COMMENT '分类编码',
  `description` text COMMENT '分类描述',
  `parent_id` int DEFAULT NULL COMMENT '父分类ID',
  `sort_order` int DEFAULT '0' COMMENT '排序序号',
  `status` tinyint DEFAULT '1' COMMENT '状态：1-启用，0-禁用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_category_name` (`category_name`),
  UNIQUE KEY `uk_category_code` (`category_code`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='图书分类表';
```
#### 2.2.3 图书信息表 (book) - 增强版
| 字段名 | 类型 | 长度 | 说明 | 约束 | 备注 |
|--------|------|------|------|------|------|
| id | INT | - | 图书ID | 主键，自增 | 唯一标识图书 |
| book_number | VARCHAR | 50 | 图书编号 | 唯一，非空 | 系统内部编号 |
| isbn | VARCHAR | 20 | ISBN号 | 唯一，非空 | 国际标准书号 |
| name_cn | VARCHAR | 200 | 中文书名 | 可空 | 中文图书名称 |
| name_id | VARCHAR | 200 | 外语书名 | 可空 | 外语图书名称 |
| language | VARCHAR | 100 | 书的语言 | 非空 | 中文、印尼语、英文、西班牙语等 |
| author | VARCHAR | 100 | 作者 | 可空 | 图书作者 |
| translator | VARCHAR | 100 | 译者 | 可空 | 图书译者 |
| publisher | VARCHAR | 100 | 出版社 | 可空 | 出版社名称 |
| publish_date | DATE | - | 出版日期 | 可空 | 图书出版时间 |
| price | DECIMAL | 10,2 | 价格 | 可空 | 图书价格 |
| category_id | INT | - | 分类ID | 可空 | 关联图书分类表 |
| location | VARCHAR | 50 | 图书位置 | 可空 | 书架位置编号 |
| total_quantity | INT | - | 总数量 | 默认1 | 该书总册数 |
| available_quantity | INT | - | 可借数量 | 默认1 | 当前可借册数 |
| borrow_count | INT | - | 借阅次数 | 默认0 | 累计借阅次数 |
| status | TINYINT | - | 图书状态 | 默认1 | 1-正常，0-下架 |
| description | TEXT | - | 图书简介 | 可空 | 图书内容简介 |
| cover_image | VARCHAR | 200 | 封面图片 | 可空 | 图书封面图片路径 |
| rating_avg | DECIMAL | 3,2 | 平均评分 | 默认0.00 | 图书平均评分 |
| create_time | DATETIME | - | 创建时间 | 默认当前时间 | 入库时间 |
| update_time | DATETIME | - | 更新时间 | 默认当前时间 | 最后修改时间 |

**建表SQL:**
```sql
CREATE TABLE `book` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '图书ID',
  `book_number` varchar(50) NOT NULL COMMENT '图书编号（系统内部编号）',
  `isbn` varchar(20) NOT NULL COMMENT 'ISBN号',
  `name_cn` varchar(200) DEFAULT NULL COMMENT '中文书名',
  `name_id` varchar(200) DEFAULT NULL COMMENT '外语书名',
  `language` varchar(100) NOT NULL COMMENT '书的语言(中文，印尼语，英文，西班牙语等）',
  `author` varchar(100) DEFAULT NULL COMMENT '作者',
  `translator` varchar(100) DEFAULT NULL COMMENT '译者',
  `publisher` varchar(100) DEFAULT NULL COMMENT '出版社',
  `publish_date` date DEFAULT NULL COMMENT '出版日期',
  `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `category_id` int DEFAULT NULL COMMENT '分类ID',
  `location` varchar(50) DEFAULT NULL COMMENT '图书位置',
  `total_quantity` int DEFAULT '1' COMMENT '总数量',
  `available_quantity` int DEFAULT '1' COMMENT '可借数量',
  `borrow_count` int DEFAULT '0' COMMENT '借阅次数',
  `status` tinyint DEFAULT '1' COMMENT '图书状态：1-正常，0-下架',
  `description` text COMMENT '图书简介',
  `cover_image` varchar(200) DEFAULT NULL COMMENT '封面图片',
  `rating_avg` decimal(3,2) DEFAULT '0.00' COMMENT '平均评分',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_book_number` (`book_number`),
  UNIQUE KEY `uk_isbn` (`isbn`),
  KEY `idx_name_cn` (`name_cn`),
  KEY `idx_name_id` (`name_id`),
  KEY `idx_author` (`author`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_status` (`status`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='图书信息表';
```


#### 2.2.4 图书评论表 (book_comment)
| 字段名 | 类型 | 长度 | 说明 | 约束 | 备注 |
|--------|------|------|------|------|------|
| id | INT | - | 评论ID | 主键，自增 | 唯一标识评论 |
| book_id | INT | - | 图书ID | 非空 | 关联图书表 |
| user_id | INT | - | 用户ID | 非空 | 关联用户表 |
| by_person | VARCHAR | 50 | 评论人 | 可空 | 评论人姓名 |
| content | TEXT | - | 评论内容 | 非空 | 评论详细内容 |
| rating | TINYINT | - | 评分 | 可空 | 1-5星评分 |
| create_time | DATETIME | - | 创建时间 | 默认当前时间 | 评论时间 |
| update_time | DATETIME | - | 更新时间 | 默认当前时间 | 最后修改时间 |

**建表SQL:**
```sql
CREATE TABLE `book_comment` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `book_id` int NOT NULL COMMENT '图书ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `by_person` varchar(50) DEFAULT NULL COMMENT '评论人',
  `content` text NOT NULL COMMENT '评论内容',
  `rating` tinyint DEFAULT NULL COMMENT '评分：1-5星',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_book_id` (`book_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='图书评论表';
```

#### 2.2.5 图书推荐表 (book_recommendation)
| 字段名 | 类型 | 长度 | 说明 | 约束 | 备注 |
|--------|------|------|------|------|------|
| id | INT | - | 推荐ID | 主键，自增 | 唯一标识推荐 |
| book_id | INT | - | 图书ID | 非空 | 关联图书表 |
| recommend_month | VARCHAR | 7 | 推荐月份 | 非空 | YYYY-MM格式 |
| recommend_reason | TEXT | - | 推荐理由 | 可空 | 推荐说明 |
| operator_id | INT | - | 操作员ID | 非空 | 推荐人ID |
| status | TINYINT | - | 状态 | 默认1 | 1-启用，0-禁用 |
| create_time | DATETIME | - | 创建时间 | 默认当前时间 | 推荐时间 |
| update_time | DATETIME | - | 更新时间 | 默认当前时间 | 最后修改时间 |

**建表SQL:**
```sql
CREATE TABLE `book_recommendation` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '推荐ID',
  `book_id` int NOT NULL COMMENT '图书ID',
  `recommend_month` varchar(7) NOT NULL COMMENT '推荐月份（YYYY-MM格式）',
  `recommend_reason` text DEFAULT NULL COMMENT '推荐理由',
  `operator_id` int NOT NULL COMMENT '操作员ID',
  `status` tinyint DEFAULT '1' COMMENT '状态：1-启用，0-禁用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_recommend_month` (`recommend_month`),
  KEY `idx_book_id` (`book_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='图书推荐表';
```

#### 2.2.6 借阅记录表 (lend_record) - 增强版
| 字段名 | 类型 | 长度 | 说明 | 约束 | 备注 |
|--------|------|------|------|------|------|
| id | INT | - | 记录ID | 主键，自增 | 唯一标识借阅记录 |
| reader_id | INT | - | 读者ID | 非空 | 关联用户表 |
| book_id | INT | - | 图书ID | 非空 | 关联图书表 |
| book_name | VARCHAR | 200 | 书名 | 非空 | 图书名称 |
| book_number | VARCHAR | 50 | 图书编号 | 非空 | 系统内部编号 |
| lend_time | DATETIME | - | 借阅时间 | 非空 | 借书时间 |
| due_time | DATETIME | - | 应还时间 | 非空 | 预计归还时间 |
| return_time | DATETIME | - | 实际归还时间 | 可空 | 实际还书时间 |
| status | VARCHAR | 20 | 借阅状态 | 默认'已借出' | 已借出/已归还/逾期/丢失 |
| borrow_days | INT | - | 借阅天数 | 默认30 | 允许借阅的天数 |
| operator_id | INT | - | 操作员ID | 可空 | 办理借还的管理员 |
| remark | VARCHAR | 500 | 备注 | 可空 | 借阅备注信息 |
| renewal_count | INT | - | 续借次数 | 默认0 | 续借次数统计 |
| create_time | DATETIME | - | 创建时间 | 默认当前时间 | 记录创建时间 |
| update_time | DATETIME | - | 更新时间 | 默认当前时间 | 最后修改时间 |

**建表SQL:**
```sql
CREATE TABLE `lend_record` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `reader_id` int NOT NULL COMMENT '读者ID',
  `book_id` int NOT NULL COMMENT '图书ID',
  `book_name` varchar(200) NOT NULL COMMENT '书名',
  `book_number` varchar(50) NOT NULL COMMENT '图书编号（系统内部编号）',
  `lend_time` datetime NOT NULL COMMENT '借阅时间',
  `due_time` datetime NOT NULL COMMENT '应还时间',
  `return_time` datetime DEFAULT NULL COMMENT '实际归还时间',
  `status` varchar(20) DEFAULT '已借出' COMMENT '借阅状态：已借出/已归还/逾期/丢失',
  `borrow_days` int DEFAULT '30' COMMENT '借阅天数',
  `operator_id` int DEFAULT NULL COMMENT '操作员ID',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `renewal_count` int DEFAULT '0' COMMENT '续借次数',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_reader_id` (`reader_id`),
  KEY `idx_book_id` (`book_id`),
  KEY `idx_book_number` (`book_number`),
  KEY `idx_status` (`status`),
  KEY `idx_lend_time` (`lend_time`),
  KEY `idx_due_time` (`due_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='借阅记录表';
```

#### 2.2.7 系统访问统计表 (system_stats) - 增强版
| 字段名 | 类型 | 长度 | 说明 | 约束 | 备注 |
|--------|------|------|------|------|------|
| id | INT | - | 统计ID | 主键，自增 | 唯一标识 |
| stat_date | DATE | - | 统计日期 | 非空，唯一 | 统计的日期 |
| visit_count | INT | - | 访问次数 | 默认0 | 当日访问次数 |
| new_users | INT | - | 新增用户数 | 默认0 | 当日新增用户 |
| new_books | INT | - | 新增图书数 | 默认0 | 当日新增图书 |
| lend_count | INT | - | 借阅次数 | 默认0 | 当日借阅次数 |
| return_count | INT | - | 归还次数 | 默认0 | 当日归还次数 |
| comment_count | INT | - | 新增评论数 | 默认0 | 当日新增评论数 |
| create_time | DATETIME | - | 创建时间 | 默认当前时间 | |
| update_time | DATETIME | - | 更新时间 | 默认当前时间 | |

**建表SQL:**
```sql
CREATE TABLE `system_stats` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '统计ID',
  `stat_date` date NOT NULL COMMENT '统计日期',
  `visit_count` int DEFAULT '0' COMMENT '访问次数',
  `new_users` int DEFAULT '0' COMMENT '新增用户数',
  `new_books` int DEFAULT '0' COMMENT '新增图书数',
  `lend_count` int DEFAULT '0' COMMENT '借阅次数',
  `return_count` int DEFAULT '0' COMMENT '归还次数',
  `comment_count` int DEFAULT '0' COMMENT '新增评论数',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_stat_date` (`stat_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统访问统计表';
```

### 2.3 API接口设计

#### 2.3.1 用户管理接口
- `POST /user/register` - 用户注册
- `POST /api/auth/login` - 用户登录
- `GET /api/user` - 分页查询用户
- `POST /api/user` - 新增用户
- `PUT /api/user` - 更新用户信息
- `PUT /api/user/password` - 修改密码
- `DELETE /api/user/{id}` - 删除用户
- `POST /api/user/deleteBatch` - 批量删除用户
- `GET /api/user/usersearch` - 多条件搜索用户

#### 2.3.2 图书管理接口
- `GET /api/book` - 分页查询图书
- `POST /api/book` - 新增图书
- `PUT /api/book` - 更新图书信息
- `DELETE /api/book/{id}` - 删除图书
- `POST /api/book/deleteBatch` - 批量删除图书
- `GET /api/book/number/{bookNumber}` - 根据图书编号查询
- `GET /api/book/search` - 多条件搜索图书
- `GET /api/book/category/{categoryId}` - 按分类查询图书
- `GET /api/book/language/{language}` - 按语言查询图书,
- `GET /api/book/popular` - 获取热门图书
- `GET /api/book/highRated` - 获取高评分图书
- `POST /api/book/borrow/{id}` - 借阅图书
- `POST /api/book/return/{id}` - 归还图书
- `GET /api/book/languages` - 获取所有语言列表
- `GET /api/book/checkNumber` - 检查图书编号是否存在
- `POST /api/book/batchUpdateStatus` - 批量更新图书状态
- `GET /api/book/detail/{id}` - 获取图书详情
- `PUT /api/book/updateRating/{id}` - 更新图书平均评分

#### 2.3.3 借阅管理接口
- `GET /api/LendRecord` - 查询借阅记录
- `POST /api/LendRecord` - 新增借阅记录
- `PUT /api/LendRecord` - 更新借阅记录
- `PUT /api/LendRecord1` - 归还图书
- `DELETE /api/LendRecord/{id}` - 删除借阅记录

#### 2.3.4 图书评论接口
- `POST /api/comment` - 添加评论
- `PUT /api/comment` - 更新评论
- `DELETE /api/comment/{id}` - 删除评论
- `POST /api/comment/deleteBatch` - 批量删除评论
- `GET /api/comment/book/{bookId}` - 根据图书ID分页查询评论
- `GET /api/comment/user/{userId}` - 根据用户ID分页查询评论
- `GET /api/comment/rating/{bookId}` - 计算图书平均评分
- `GET /api/comment/statistics/{bookId}` - 获取评论统计信息
- `GET /api/comment/check` - 检查用户是否已评论
- `GET /api/comment/latest` - 获取最新评论
- `GET /api/comment/highRated` - 获取高分评论
- `POST /api/comment/updateStatus` - 更新评论状态
- `POST /api/comment/batchUpdateStatus` - 批量更新评论状态

#### 2.3.5 图书推荐接口
- `POST /api/recommendation` - 添加推荐
- `PUT /api/recommendation` - 更新推荐
- `DELETE /api/recommendation/{id}` - 删除推荐
- `POST /api/recommendation/deleteBatch` - 批量删除推荐
- `GET /api/recommendation` - 分页查询推荐图书
- `GET /api/recommendation/month/{month}` - 根据推荐月份查询
- `GET /api/recommendation/current` - 获取当前有效推荐
- `GET /api/recommendation/book/{bookId}` - 根据图书ID查询推荐记录
- `GET /api/recommendation/checkMonth` - 检查指定月份是否已有推荐
- `GET /api/recommendation/months` - 获取所有推荐月份列表
- `POST /api/recommendation/activate/{id}` - 启用推荐
- `POST /api/recommendation/deactivate/{id}` - 停用推荐
- `POST /api/recommendation/updateStatus` - 更新推荐状态
- `POST /api/recommendation/batchUpdateStatus` - 批量更新推荐状态
- `GET /api/recommendation/detail/{id}` - 获取推荐详情
- `GET /api/recommendation/popular` - 获取热门推荐

#### 2.3.6 图书分类接口
- `POST /api/category` - 添加分类
- `PUT /api/category` - 更新分类
- `DELETE /api/category/{id}` - 删除分类
- `POST /api/category/deleteBatch` - 批量删除分类
- `GET /api/category/enabled` - 获取所有启用的分类
- `GET /api/category/parent/{parentId}` - 根据父分类ID查询子分类
- `GET /api/category/root` - 查询根分类（顶级分类）
- `GET /api/category/tree` - 构建分类树
- `GET /api/category/path/{categoryId}` - 获取分类的完整路径
- `GET /api/category/bookCount/{categoryId}` - 查询分类下的图书数量
- `GET /api/category/checkCode` - 检查分类编码是否存在
- `GET /api/category/checkName` - 检查分类名称是否存在
- `POST /api/category/move` - 移动分类到新的父分类下
- `POST /api/category/sort` - 调整分类排序
- `POST /api/category/batchUpdateStatus` - 批量更新分类状态
- `GET /api/category/children/{categoryId}` - 获取分类及其所有子分类的ID列表
- `GET /api/category` - 获取所有分类（分页）
- `GET /api/category/{id}` - 获取分类详情

#### 2.3.7 系统统计接口
- `GET /api/dashboard` - 获取系统统计数据
- `GET /api/stats/today` - 获取今日统计数据
- `GET /api/stats/recent` - 获取最近N天的统计数据
- `GET /api/stats/date` - 根据日期查询统计数据
- `GET /api/stats/range` - 查询日期范围内的统计数据
- `POST /api/stats/newUser` - 增加新用户数
- `POST /api/stats/newBook` - 增加新图书数
- `POST /api/stats/borrow` - 增加借阅数
- `POST /api/stats/return` - 增加归还数
- `POST /api/stats/visit` - 增加访问数
- `POST /api/stats/comment` - 增加评论数
- `GET /api/stats/summary` - 获取统计汇总数据
- `POST /api/stats/initToday` - 初始化今日统计数据
- `PUT /api/stats` - 更新统计数据
- `GET /api/stats/userActivity` - 获取用户活跃度统计
- `GET /api/stats/bookBorrow` - 获取图书借阅统计
- `GET /api/stats/systemAccess` - 获取系统访问统计
- `GET /api/stats/report` - 生成统计报表
- `DELETE /api/stats/cleanup` - 清理过期统计数据
- `POST /api/stats/batchImport` - 批量导入统计数据
- `GET /api/stats` - 获取所有统计数据（分页）
- `GET /api/stats/{id}` - 获取统计数据详情

### 2.4 安全设计

#### 2.4.1 身份认证
- 使用JWT Token进行用户身份认证
- Token有效期为1天
- Token包含用户ID信息
- 使用用户密码作为签名密钥

#### 2.4.2 权限控制
- 基于角色的访问控制(RBAC)
- 管理员角色(role=1)：拥有所有权限
- 普通用户角色(role=2)：只能查看和借阅图书

### 2.5 前端设计

#### 2.5.1 页面结构
- 登录页面
- 用户管理页面
- 图书管理页面
- 借阅管理页面
- 数据统计页面

#### 2.5.2 静态资源配置
- 静态文件存放在 `src/main/resources/static/` 目录
- 支持CSS、JS、图片等静态资源
- 使用Vue.js构建的单页应用(SPA)

### 2.6 配置说明

#### 2.6.1 数据库配置
```properties
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3307/library?useUnicode=true&characterEncoding=utf-8&allowMultiQueries=true&useSSL=false&serverTimezone=GMT%2b8
spring.datasource.username=root
spring.datasource.password=123456
```

#### 2.6.2 MyBatis Plus配置
```properties
mybatis-plus.configuration.map-underscore-to-camel-case=true
```

#### 2.6.3 服务器配置
```properties
server.port=9090
```

## 三、部署说明

### 3.1 环境要求
- JDK 1.8+
- MySQL 5.7+
- Maven 3.6+
- Node.js 14+ (前端开发)

### 3.2 部署步骤
1. 创建MySQL数据库 `library`
2. 执行数据库初始化脚本
3. 修改 `application.properties` 中的数据库连接配置
4. 使用Maven编译打包：`mvn clean package`
5. 运行应用：`java -jar target/demo-0.0.1-SNAPSHOT.jar`
6. 访问系统：http://localhost:9090

### 3.3 数据库初始化

项目提供了三个SQL脚本文件，可根据需要选择使用：

#### 3.3.1 完整初始化（推荐）
使用 `database_complete.sql`：
```bash
# 1. 创建数据库并执行完整脚本
mysql -u root -p < database_complete.sql
```
包含内容：
- 数据库创建
- 完整表结构（含索引、外键、触发器）
- 视图和存储过程
- 丰富的模拟数据（用户、图书、借阅记录等）
- 数据验证查询

#### 3.3.2 仅建表结构
使用 `create_tables.sql`：
```bash
# 1. 创建数据库
mysql -u root -p -e "CREATE DATABASE library_management;"
# 2. 执行建表脚本
mysql -u root -p library_management < create_tables.sql
```
包含内容：
- 基础表结构
- 索引和外键约束
- 视图、存储过程、触发器
- 基础管理员账号和图书分类

#### 3.3.3 单独插入模拟数据
在建表完成后，使用 `insert_sample_data.sql`：
```bash
# 执行模拟数据插入
mysql -u root -p library_management < insert_sample_data.sql
```
包含内容：
- 15个用户账号（含管理员和普通用户）
- 20个图书分类（含子分类）
- 50+本图书（涵盖各个学科）
- 25+条借阅记录（含已归还、借出中、逾期）
- 30天系统统计数据
- 数据验证和统计查询

#### 3.3.4 默认账号信息
- **系统管理员**：admin / 123456
- **图书管理员**：librarian / 123456
- **普通用户示例**：zhangsan / 123456
- 注意：所有密码均为MD5加密存储

### 3.4 开发环境启动
```bash
# 后端启动
cd SpringBoot
mvn spring-boot:run

# 前端启动
cd Vue
npm install
npm run serve
```

### 3.5 生产环境部署

## 四、维护说明

### 4.1 日志管理
- 使用SLF4J进行日志记录
- 重要操作和异常信息会记录到日志中

### 4.2 数据备份
- 定期备份MySQL数据库
- 重要配置文件版本控制

### 4.3 性能监控
- 监控数据库连接池状态
- 监控API响应时间
- 监控系统资源使用情况

---

**项目版本**: 0.0.1-SNAPSHOT  
**最后更新**: 2025-07-01  
**开发团队**: Demo Team