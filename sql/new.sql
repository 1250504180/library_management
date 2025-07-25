/*
 Navicat Premium Dump SQL

 Source Server         : oa
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3306
 Source Schema         : library_management_new

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 18/07/2025 13:22:20
*/
use library_management_new;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '图书ID',
  `book_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图书编号',
  `isbn` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'ISBN号',
  `name_cn` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '中文书名',
  `name_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '外语书名',
  `language` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '书的语言',
  `author` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作者',
  `translator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '译者',
  `publisher` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '出版社',
  `publish_date` date NULL DEFAULT NULL COMMENT '出版日期',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `category_id` int NULL DEFAULT NULL COMMENT '分类ID',
  `location` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图书位置',
  `total_quantity` int NULL DEFAULT 1 COMMENT '总数量',
  `available_quantity` int NULL DEFAULT 1 COMMENT '可借数量',
  `borrow_count` int NULL DEFAULT 0 COMMENT '借阅次数',
  `status` tinyint NULL DEFAULT 1 COMMENT '图书状态（1-正常，0-下架）',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '图书简介',
  `cover_image` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面图片',
  `rating_avg` decimal(3, 2) NULL DEFAULT 0.00 COMMENT '平均评分',
  `translationunit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '币种单位',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `book_number`(`book_number` ASC) USING BTREE,
  UNIQUE INDEX `isbn`(`isbn` ASC) USING BTREE,
  INDEX `idx_category_id`(`category_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '图书信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
-- INSERT INTO `book` VALUES (1, 'BK20240001', '9787302523103', '人工智能导论', 'Introduction to AI', '中文', '李开复', NULL, '清华大学出版社', '2021-05-20', 88.00, 11, 'A-101', 10, 5, 36, 1, '全面介绍人工智能基础与应用。', '/uploads/ai_intro.jpg', 4.39, 'CNY', '2024-01-01 10:00:00', '2025-07-16 17:41:07');
-- INSERT INTO `book` VALUES (2, 'BK20240002', '9787505715660', '时间简史', 'A Brief History of Time', '英文', 'Stephen Hawking', '许明贤', '中国社会科学出版社', '2001-09-01', 49.00, 2, 'B-202', 12, 12, 18, 1, '著名物理学家霍金的宇宙探索名作。', '/uploads/time_brief.jpg', 4.75, 'CNY', '2024-01-02 11:00:00', '2024-01-02 11:00:00');
-- INSERT INTO `book` VALUES (3, 'BK20240003', '9787108030406', '史记', NULL, '中文', '司马迁', NULL, '中华书局', '2010-03-15', 66.00, 3, 'C-310', 8, 5, 12, 1, '中国第一部纪传体通史，描绘西汉以前历史。', '/uploads/shiji.jpg', 4.80, 'CNY', '2025-07-15 12:00:00', '2025-07-16 18:09:20');
-- INSERT INTO `book` VALUES (4, 'BK20240004', '9787569911815', '算法图解', 'Grokking Algorithms', '中英', 'Aditya Bhargava', '王海鹏', '人民邮电出版社', '2018-04-01', 79.00, 11, 'CS-201', 15, 10, 40, 1, '通俗易懂的算法入门图书。', '/uploads/algorithms.jpg', 4.70, 'CNY', '2024-01-04 13:00:00', '2025-07-16 13:00:00');
-- INSERT INTO `book` VALUES (5, 'BK20240005', '9787115470984', '深入理解计算机系统', 'CSAPP', '中英', 'Randal E. Bryant', '潘爱民', '机械工业出版社', '2017-08-01', 108.00, 11, 'CS-301', 6, 5, 21, 1, '计算机系统底层原理详解。', '/uploads/csapp.jpg', 4.50, 'CNY', '2025-07-14 14:00:00', '2025-07-16 18:09:25');
-- INSERT INTO `book` VALUES (6, 'BK20240006', '9787508697925', '经济学原理', 'Principles of Economics', '中英', 'N. Gregory Mankiw', '梁小民', '中国人民大学出版社', '2015-01-01', 88.00, 5, 'E-101', 10, 10, 11, 1, '最流行的经济学入门教材之一。', '/uploads/economics.jpg', 4.20, 'CNY', '2024-01-06 15:00:00', '2025-07-13 15:00:00');
-- INSERT INTO `book` VALUES (7, 'BK20240007', '9787559618854', '活着', NULL, '中文', '余华', NULL, '北京十月文艺出版社', '2017-06-01', 45.00, 1, 'L-102', 5, 5, 9, 1, '一部感人至深的人性小说。', '/uploads/huozhe.jpg', 4.90, 'CNY', '2025-07-15 16:00:00', '2025-07-16 18:09:30');
-- INSERT INTO `book` VALUES (8, 'BK20240008', '9780140449266', '理想国', 'The Republic', '英文', '柏拉图', '郭斌和', 'Penguin Classics', '2003-09-01', 62.00, 4, 'P-101', 7, 6, 17, 1, '哲学经典，对正义与社会秩序的探讨。', '/uploads/republic.jpg', 4.60, 'USD', '2024-01-08 17:00:00', '2025-07-11 17:00:00');
-- INSERT INTO `book` VALUES (9, 'BK20240009', '9787115351161', '图解心理学', NULL, '中文', '小林哲', NULL, '人民邮电出版社', '2019-05-01', 55.00, 10, 'PS-101', 6, 6, 5, 1, '以图文并茂方式介绍心理学知识。', '/uploads/psychology.jpg', 4.30, 'CNY', '2024-01-09 09:00:00', '2024-01-09 09:00:00');
-- INSERT INTO `book` VALUES (11, 'BK20240011', '9787532149179', '围城', '', '中文', '钱钟书', '', '人民文学出版社', '2005-08-01', 36.00, 1, 'L-205', 8, 7, 19, 1, '讽刺小说经典，描述知识分子的生活状态。', '/uploads/1752658806408_login.png', 4.70, 'CNY', '2024-01-11 11:00:00', '2025-07-16 17:40:07');

-- ----------------------------
-- Table structure for book_category
-- ----------------------------
DROP TABLE IF EXISTS `book_category`;
CREATE TABLE `book_category`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `category_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `category_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类编码',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '分类描述',
  `parent_id` int NULL DEFAULT NULL COMMENT '父分类ID',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序序号',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态（1-启用，0-禁用）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_category_name`(`category_name` ASC) USING BTREE,
  UNIQUE INDEX `uk_category_code`(`category_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '图书分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book_category
-- ----------------------------
INSERT INTO `book_category` VALUES (1, '经济/商业', '000', '经济学、金融、会计等方面书籍', NULL, 1, 1, '2024-01-05 10:00:00', '2024-01-05 10:00:00');
INSERT INTO `book_category` VALUES (2, '农业', '100', '农业方面书籍', NULL, 2, 1, '2024-01-05 10:00:00', '2024-01-05 10:00:00');
INSERT INTO `book_category` VALUES (3, '棕榈油', '200', '棕榈油方面书籍', NULL, 3, 1, '2024-01-05 10:00:00', '2024-01-05 10:00:00');
INSERT INTO `book_category` VALUES (4, '技术，科学，化学', '300', '技术、科学、化学方面书籍', NULL, 4, 1, '2024-01-05 10:00:00', '2024-01-05 10:00:00');
INSERT INTO `book_category` VALUES (5, '启发', '400', '启发、激励方面书籍', NULL, 5, 1, '2024-01-05 10:00:00', '2024-01-05 10:00:00');
INSERT INTO `book_category` VALUES (6, '语言', '500', '语言学习方面书籍', NULL, 6, 1, '2024-01-05 10:00:00', '2024-01-05 10:00:00');
INSERT INTO `book_category` VALUES (7, '常识', '600', '常识、百科知识方面书籍', NULL, 7, 1, '2024-01-05 10:00:00', '2024-01-05 10:00:00');
INSERT INTO `book_category` VALUES (8, '自我发展', '700', '自我发展、个人成长方面书籍', NULL, 8, 1, '2024-01-05 10:00:00', '2024-01-05 10:00:00');
INSERT INTO `book_category` VALUES (9, '工业', '800', '工业技术方面书籍', NULL, 9, 1, '2024-01-05 10:00:00', '2024-01-05 10:00:00');
INSERT INTO `book_category` VALUES (10, '历史', '900', '历史方面书籍', NULL, 10, 1, '2024-01-05 10:00:00', '2024-01-05 10:00:00');
INSERT INTO `book_category` VALUES (11, '传记、自传、回忆录', '1000', '传记、自传、回忆录方面书籍', NULL, 11, 1, '2024-01-05 10:00:00', '2024-01-05 10:00:00');
INSERT INTO `book_category` VALUES (12, '文学', '1100', '文学作品方面书籍', NULL, 12, 1, '2024-01-05 10:00:00', '2024-01-05 10:00:00');
INSERT INTO `book_category` VALUES (13, '生存', '1200', '生存技能方面书籍', NULL, 13, 1, '2024-01-05 10:00:00', '2024-01-05 10:00:00');
INSERT INTO `book_category` VALUES (14, '政治', '1300', '政治学方面书籍', NULL, 14, 1, '2024-01-05 10:00:00', '2024-01-05 10:00:00');
INSERT INTO `book_category` VALUES (15, '心理学', '1400', '心理学方面书籍', NULL, 15, 1, '2024-01-05 10:00:00', '2024-01-05 10:00:00');
INSERT INTO `book_category` VALUES (16, '管理理论', '1500', '管理理论方面书籍', NULL, 16, 1, '2024-01-05 10:00:00', '2024-01-05 10:00:00');
-- ----------------------------
-- Table structure for book_comment
-- ----------------------------
DROP TABLE IF EXISTS `book_comment`;
CREATE TABLE `book_comment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `by_person` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '评论人',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '评论内容',
  `rating` tinyint NULL DEFAULT NULL COMMENT '评分：1-5星',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `book_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图书名称',
  `user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名称',
  `book_id`  int DEFAULT NULL COMMENT '图书id',
  `user_id`   int DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '图书评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book_comment
-- ----------------------------

-- ----------------------------
-- Table structure for book_recommendation
-- ----------------------------
DROP TABLE IF EXISTS `book_recommendation`;
CREATE TABLE `book_recommendation`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '推荐ID',
  `book_id` int NOT NULL COMMENT '图书ID',
  `name_cn` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图书中文名称',
  `recommend_month` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '推荐月份（YYYY-MM格式）',
  `recommend_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '推荐理由',
  `operator_id` int NOT NULL COMMENT '操作员ID',
  `operator_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作员姓名',
  `img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '推荐图片的URL',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：1-启用，0-禁用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_recommend_month`(`recommend_month` ASC) USING BTREE,
  INDEX `idx_book_id`(`book_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '图书推荐表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book_recommendation
-- ----------------------------

-- ----------------------------
-- Table structure for lend_record
-- ----------------------------
DROP TABLE IF EXISTS `lend_record`;
CREATE TABLE `lend_record`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `reader_id` int NOT NULL COMMENT '读者ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '读者姓名',
  `book_id` int NOT NULL COMMENT '图书ID',
  `book_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '书名',
  `book_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图书编号（系统内部编号）',
  `lend_time` datetime NOT NULL COMMENT '借阅时间',
  `due_time` datetime NOT NULL COMMENT '应还时间',
  `return_time` datetime NULL DEFAULT NULL COMMENT '实际归还时间',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '已借出' COMMENT '借阅状态：已借出/已归还/逾期/丢失',
  `borrow_days` int NULL DEFAULT 30 COMMENT '借阅天数',
  `operator_id` int NULL DEFAULT NULL COMMENT '操作员ID',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `renewal_count` int NULL DEFAULT 0 COMMENT '续借次数',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_reader_id`(`reader_id` ASC) USING BTREE,
  INDEX `idx_book_id`(`book_id` ASC) USING BTREE,
  INDEX `idx_book_number`(`book_number` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_lend_time`(`lend_time` ASC) USING BTREE,
  INDEX `idx_due_time`(`due_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '借阅记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lend_record
-- ----------------------------

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名',
  `class_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类名',
  `method_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '方法名',
  `params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '请求参数',
  `result` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '返回结果',
  `log_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'INFO' COMMENT '日志类型：INFO / ERROR',
  `exception` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '异常堆栈',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 412 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------

-- ----------------------------
-- Table structure for system_stats
-- ----------------------------
DROP TABLE IF EXISTS `system_stats`;
CREATE TABLE `system_stats`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '统计ID',
  `stat_date` date NOT NULL COMMENT '统计日期',
  `visit_count` int NULL DEFAULT 0 COMMENT '访问次数',
  `new_users` int NULL DEFAULT 0 COMMENT '新增用户数',
  `new_books` int NULL DEFAULT 0 COMMENT '新增图书数',
  `lend_count` int NULL DEFAULT 0 COMMENT '借阅次数',
  `return_count` int NULL DEFAULT 0 COMMENT '归还次数',
  `comment_count` int NULL DEFAULT 0 COMMENT '新增评论数',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_stat_date`(`stat_date` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问统计表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_stats
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `nick_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `sex` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址/部门',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `role` int NOT NULL DEFAULT 2 COMMENT '角色（1-管理员，2-普通用户）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `status` tinyint NULL DEFAULT 1 COMMENT '账号状态（1-正常，0-禁用）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '系统管理员', 'e10adc3949ba59abbe56e057f20f883e', '男', '图书信息中心', '13800000001', 1, '2025-07-13 09:00:00', '2025-07-16 18:01:42', 1);

SET FOREIGN_KEY_CHECKS = 1;
