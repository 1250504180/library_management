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
INSERT INTO `book` VALUES (1, 'BK20240001', '9787302523103', '人工智能导论', 'Introduction to AI', '中文', '李开复', NULL, '清华大学出版社', '2021-05-20', 88.00, 11, 'A-101', 10, 5, 36, 1, '全面介绍人工智能基础与应用。', '/uploads/ai_intro.jpg', 4.39, 'CNY', '2024-01-01 10:00:00', '2025-07-16 17:41:07');
INSERT INTO `book` VALUES (2, 'BK20240002', '9787505715660', '时间简史', 'A Brief History of Time', '英文', 'Stephen Hawking', '许明贤', '中国社会科学出版社', '2001-09-01', 49.00, 2, 'B-202', 12, 12, 18, 1, '著名物理学家霍金的宇宙探索名作。', '/uploads/time_brief.jpg', 4.75, 'CNY', '2024-01-02 11:00:00', '2024-01-02 11:00:00');
INSERT INTO `book` VALUES (3, 'BK20240003', '9787108030406', '史记', NULL, '中文', '司马迁', NULL, '中华书局', '2010-03-15', 66.00, 3, 'C-310', 8, 5, 12, 1, '中国第一部纪传体通史，描绘西汉以前历史。', '/uploads/shiji.jpg', 4.80, 'CNY', '2025-07-15 12:00:00', '2025-07-16 18:09:20');
INSERT INTO `book` VALUES (4, 'BK20240004', '9787569911815', '算法图解', 'Grokking Algorithms', '中英', 'Aditya Bhargava', '王海鹏', '人民邮电出版社', '2018-04-01', 79.00, 11, 'CS-201', 15, 10, 40, 1, '通俗易懂的算法入门图书。', '/uploads/algorithms.jpg', 4.70, 'CNY', '2024-01-04 13:00:00', '2025-07-16 13:00:00');
INSERT INTO `book` VALUES (5, 'BK20240005', '9787115470984', '深入理解计算机系统', 'CSAPP', '中英', 'Randal E. Bryant', '潘爱民', '机械工业出版社', '2017-08-01', 108.00, 11, 'CS-301', 6, 5, 21, 1, '计算机系统底层原理详解。', '/uploads/csapp.jpg', 4.50, 'CNY', '2025-07-14 14:00:00', '2025-07-16 18:09:25');
INSERT INTO `book` VALUES (6, 'BK20240006', '9787508697925', '经济学原理', 'Principles of Economics', '中英', 'N. Gregory Mankiw', '梁小民', '中国人民大学出版社', '2015-01-01', 88.00, 5, 'E-101', 10, 10, 11, 1, '最流行的经济学入门教材之一。', '/uploads/economics.jpg', 4.20, 'CNY', '2024-01-06 15:00:00', '2025-07-13 15:00:00');
INSERT INTO `book` VALUES (7, 'BK20240007', '9787559618854', '活着', NULL, '中文', '余华', NULL, '北京十月文艺出版社', '2017-06-01', 45.00, 1, 'L-102', 5, 5, 9, 1, '一部感人至深的人性小说。', '/uploads/huozhe.jpg', 4.90, 'CNY', '2025-07-15 16:00:00', '2025-07-16 18:09:30');
INSERT INTO `book` VALUES (8, 'BK20240008', '9780140449266', '理想国', 'The Republic', '英文', '柏拉图', '郭斌和', 'Penguin Classics', '2003-09-01', 62.00, 4, 'P-101', 7, 6, 17, 1, '哲学经典，对正义与社会秩序的探讨。', '/uploads/republic.jpg', 4.60, 'USD', '2024-01-08 17:00:00', '2025-07-11 17:00:00');
INSERT INTO `book` VALUES (9, 'BK20240009', '9787115351161', '图解心理学', NULL, '中文', '小林哲', NULL, '人民邮电出版社', '2019-05-01', 55.00, 10, 'PS-101', 6, 6, 5, 1, '以图文并茂方式介绍心理学知识。', '/uploads/psychology.jpg', 4.30, 'CNY', '2024-01-09 09:00:00', '2024-01-09 09:00:00');
INSERT INTO `book` VALUES (11, 'BK20240011', '9787532149179', '围城', '', '中文', '钱钟书', '', '人民文学出版社', '2005-08-01', 36.00, 1, 'L-205', 8, 7, 19, 1, '讽刺小说经典，描述知识分子的生活状态。', '/uploads/1752658806408_login.png', 4.70, 'CNY', '2024-01-11 11:00:00', '2025-07-16 17:40:07');

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
INSERT INTO `book_category` VALUES (1, '文学', 'LIT', '各类文学作品，包括小说、诗歌等', NULL, 1, 1, '2024-01-01 10:00:00', '2024-01-01 10:00:00');
INSERT INTO `book_category` VALUES (2, '科技', 'SCI', '自然科学、工程技术等方面的书籍', NULL, 2, 1, '2024-01-02 10:00:00', '2024-01-02 10:00:00');
INSERT INTO `book_category` VALUES (3, '历史', 'HIS', '历史类书籍，包括古代、现代、各国历史', NULL, 3, 1, '2024-01-03 10:00:00', '2024-01-03 10:00:00');
INSERT INTO `book_category` VALUES (4, '哲学', 'PHI', '哲学理论、思想流派等', NULL, 4, 1, '2024-01-04 10:00:00', '2024-01-04 10:00:00');
INSERT INTO `book_category` VALUES (5, '经济', 'ECO', '经济学、金融、会计等方面书籍', NULL, 5, 1, '2024-01-05 10:00:00', '2024-01-05 10:00:00');
INSERT INTO `book_category` VALUES (6, '教育', 'EDU', '教育学、教育实践、教学设计等', NULL, 6, 1, '2024-01-06 10:00:00', '2024-01-06 10:00:00');
INSERT INTO `book_category` VALUES (7, '法律', 'LAW', '法律法规、案例解析等', NULL, 7, 1, '2024-01-07 10:00:00', '2024-01-07 10:00:00');
INSERT INTO `book_category` VALUES (8, '艺术', 'ART', '美术、音乐、戏剧等艺术类书籍', NULL, 8, 1, '2024-01-08 10:00:00', '2024-01-08 10:00:00');
INSERT INTO `book_category` VALUES (9, '医学', 'MED', '临床医学、中医、护理等', NULL, 9, 1, '2024-01-09 10:00:00', '2024-01-09 10:00:00');
INSERT INTO `book_category` VALUES (10, '心理学', 'PSY', '心理学理论、心理治疗等', NULL, 10, 1, '2024-01-10 10:00:00', '2024-01-10 10:00:00');
INSERT INTO `book_category` VALUES (11, '计算机', 'CS', '编程语言、算法、人工智能等', NULL, 11, 1, '2024-01-11 10:00:00', '2024-01-11 10:00:00');
INSERT INTO `book_category` VALUES (12, '语言学', 'LING', '语言结构、语言学习、翻译研究等', NULL, 12, 1, '2024-01-12 10:00:00', '2024-01-12 10:00:00');

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
INSERT INTO `book_comment` VALUES (1, '系统管理员', '深入浅出，很适合初学者了解AI。', 5, '2024-01-05 08:30:00', '2025-07-18 10:59:54', '理想国', 'John Doe', 3, NULL);
INSERT INTO `book_comment` VALUES (2, '系统管理员', '科学性强，读起来略有难度，但值得一读。', 4, '2024-01-06 09:00:00', '2025-07-18 11:00:27', '围城', 'Li Wang', 6, NULL);
INSERT INTO `book_comment` VALUES (4, '系统管理员', '图文并茂，很适合初学算法者。', 5, '2024-01-08 11:00:00', '2025-07-18 11:00:21', '围城', 'Nana', 4, NULL);
INSERT INTO `book_comment` VALUES (5, '系统管理员', 'CS入门的神书，值得精读。', 5, '2024-01-09 12:00:00', '2025-07-18 11:00:38', '经济学原理', 'Irfan Maulana', 3, NULL);
INSERT INTO `book_comment` VALUES (6, '系统管理员', '逻辑清晰，适合经济学初学者。', 4, '2024-01-10 13:00:00', '2025-07-18 11:00:42', '围城', 'Alisa Zhang', 6, NULL);
INSERT INTO `book_comment` VALUES (7, '系统管理员', '情感真挚，语言质朴。', 5, '2024-01-11 14:00:00', '2025-07-18 11:00:53', '理想国', 'Andrew Lee', 4, NULL);
INSERT INTO `book_comment` VALUES (8, '系统管理员', '哲学深邃，需多读几遍才能体会。', 4, '2024-01-12 15:00:00', '2025-07-18 11:00:57', '经济学原理', 'Anita Dewi', 4, NULL);
INSERT INTO `book_comment` VALUES (9, '系统管理员', '系统管理员', 3, '2025-07-18 11:01:33', '2025-07-18 11:01:40', '系统管理员', 'join', 3, null);
INSERT INTO `book_comment` VALUES (10, '系统管理员', '适合有编程基础的同学阅读。', 4, '2024-01-14 17:00:00', '2025-07-18 11:02:25', '算法图解', 'Clara Tang', 5, NULL);
INSERT INTO `book_comment` VALUES (11, '系统管理员', '非常幽默又深刻，经典作品。', 5, '2024-01-15 18:00:00', '2025-07-18 11:02:27', '时间简史', 'Tony Shi', 2, NULL);
INSERT INTO `book_comment` VALUES (12, '系统管理员', '机器学习初学者必看。', 5, '2024-01-16 19:00:00', '2025-07-18 11:02:29', '时间简史', 'jdoe', 6, NULL);

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
INSERT INTO `book_recommendation` VALUES (2, 4, '算法图解', '2025-01', '中国文学经典，文笔细腻。', 1, 'admin', NULL, '2025-07-16 17:14:06', '2025-07-16 17:36:14');
INSERT INTO `book_recommendation` VALUES (3, 6, '经济学原理', '2025-02', '介绍现代经济的入门书。', 1, 'admin', NULL, '2025-07-16 17:14:06', '2025-07-16 17:35:31');
INSERT INTO `book_recommendation` VALUES (4, 1, '人工智能导论', '2025-01', '提升英语阅读能力的经典读物。', 2, 'admin', NULL, '2025-07-16 17:14:06', '2025-07-16 17:35:44');
INSERT INTO `book_recommendation` VALUES (5, 5, '深入理解计算机系统', '2025-06', '中国文学经典，文笔细腻。', 2, 'admin', NULL, '2025-07-16 17:14:06', '2025-07-16 17:35:57');
INSERT INTO `book_recommendation` VALUES (6, 4, '算法图解', '2025-01', '适合IT从业者入门与进阶。', 3, 'admin', NULL, '2025-07-16 17:14:06', '2025-07-16 17:36:15');
INSERT INTO `book_recommendation` VALUES (7, 3, '史记', '2025-06', '适合IT从业者入门与进阶。', 2, 'admin', NULL, '2025-07-16 17:14:06', '2025-07-16 17:36:27');
INSERT INTO `book_recommendation` VALUES (8, 5, '深入理解计算机系统', '2025-05', '适合IT从业者入门与进阶。', 2, 'admin', NULL, '2025-07-16 17:14:06', '2025-07-16 17:35:59');
INSERT INTO `book_recommendation` VALUES (9, 1, '人工智能导论', '2025-05', '内容紧凑，适合学生阅读。', 2, 'admin', NULL, '2025-07-16 17:14:06', '2025-07-16 17:35:45');
INSERT INTO `book_recommendation` VALUES (10, 6, '经济学原理', '2025-03', '中国文学经典，文笔细腻。', 2, 'admin', NULL, '2025-07-16 17:14:06', '2025-07-16 17:35:32');
INSERT INTO `book_recommendation` VALUES (11, 1, '人工智能导论', '2025-01', '提升英语阅读能力的经典读物。', 3, 'admin', NULL, '2025-07-16 17:14:06', '2025-07-16 17:35:46');
INSERT INTO `book_recommendation` VALUES (12, 5, '深入理解计算机系统', '2025-05', '内容紧凑，适合学生阅读。', 3, 'admin', NULL, '2025-07-16 17:14:06', '2025-07-16 17:44:08');

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
INSERT INTO `lend_record` VALUES (1, 5, 'nana', 5, '活着', 'BK2025005', '2025-03-10 00:53:45', '2025-04-09 00:53:45', '2025-07-18 10:29:41', '已归还', 130, 1, NULL, 2, '2025-07-16 17:14:14', '2025-07-16 17:48:03');
INSERT INTO `lend_record` VALUES (2, 6, 'irfan', 3, '1984', 'BK2025003', '2025-06-19 06:44:33', '2025-07-19 06:44:33', NULL, '已借出', 30, 1, NULL, 1, '2025-07-16 17:14:14', '2025-07-16 17:47:53');
INSERT INTO `lend_record` VALUES (3, 5, 'nana', 4, '时间简史', 'BK2025004', '2025-05-05 16:28:47', '2025-06-04 16:28:47', NULL, '已借出', 30, 1, NULL, 1, '2025-07-16 17:14:14', '2025-07-16 17:48:05');
INSERT INTO `lend_record` VALUES (4, 6, 'irfan', 6, '人类简史', 'BK2025006', '2025-04-22 22:23:04', '2025-05-22 22:23:04', '2025-05-22 22:23:04', '逾期', 30, 1, NULL, 0, '2025-07-10 17:14:14', '2025-07-16 18:02:48');
INSERT INTO `lend_record` VALUES (5, 6, 'irfan', 1, '时间简史', 'BK2025001', '2025-04-09 00:31:40', '2025-05-09 00:31:40', NULL, '已借出', 30, 1, NULL, 1, '2025-07-16 17:14:14', '2025-07-15 17:47:51');
INSERT INTO `lend_record` VALUES (6, 3, 'lwang', 6, '追风筝的人', 'BK2025006', '2025-06-16 09:55:53', '2025-07-29 09:55:53', NULL, '已借出', 30, 1, NULL, 0, '2025-07-16 17:14:14', '2025-07-16 18:08:03');
INSERT INTO `lend_record` VALUES (7, 5, 'nana', 5, '人类简史', 'BK2025005', '2025-06-21 16:07:13', '2025-07-21 16:07:13', NULL, '已借出', 30, 1, NULL, 1, '2025-07-16 17:14:14', '2025-07-14 17:48:07');
INSERT INTO `lend_record` VALUES (8, 4, 'hsim', 3, '人类简史', 'BK2025003', '2025-07-15 05:50:29', '2025-08-07 05:50:29', NULL, '已借出', 30, 1, NULL, 2, '2025-07-15 17:14:14', '2025-07-16 18:08:51');
INSERT INTO `lend_record` VALUES (9, 4, 'hsim', 6, '1984', 'BK2025006', '2025-07-14 16:24:04', '2025-05-31 16:24:04', '2025-07-18 09:56:55', '已归还', 3, 1, NULL, 2, '2025-07-12 17:14:14', '2025-07-16 18:09:05');
INSERT INTO `lend_record` VALUES (10, 6, 'irfan', 1, '1984', 'BK2025001', '2025-07-15 01:32:03', '2025-03-16 01:32:03', '2025-07-18 09:19:45', '已归还', 3, 1, NULL, 2, '2025-07-14 17:14:14', '2025-07-16 18:09:00');
INSERT INTO `lend_record` VALUES (11, 4, 'hsim', 4, '解忧杂货店', 'BK2025004', '2025-04-24 08:20:48', '2025-05-24 08:20:48', '2025-05-31 08:20:48', '逾期', 30, 1, NULL, 1, '2025-07-16 17:14:14', '2025-07-15 17:48:18');
INSERT INTO `lend_record` VALUES (12, 6, 'irfan', 4, '人类简史', 'BK2025004', '2025-04-05 15:44:12', '2025-05-05 15:44:12', '2025-05-09 15:44:12', '逾期', 30, 1, NULL, 0, '2025-07-16 17:14:14', '2025-07-16 17:47:48');
INSERT INTO `lend_record` VALUES (13, 2, 'jdoe', 1, '人工智能导论', 'BK20240001', '2025-07-10 00:00:00', '2025-07-27 00:00:00', '2025-07-16 17:49:22', '已归还', 8, NULL, NULL, 0, '2025-07-16 17:48:42', '2025-07-16 18:07:54');

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
INSERT INTO `sys_log` VALUES (1, 3, 'login', 'com.example.demo.service.BookService', 'loing', '{}', '{\"code\":0,\"msg\":\"成功\"}', 'ERROR', 'java.lang.Exception: 模拟异常', '2025-07-14 17:15:53');
INSERT INTO `sys_log` VALUES (2, 1, 'admin', 'com.example.demo.controller.UserController', 'deleteBook', '{}', '{\"code\":0,\"msg\":\"成功\"}', 'ERROR', 'java.lang.Exception: 模拟异常', '2025-07-16 17:15:53');
INSERT INTO `sys_log` VALUES (3, 1, 'admin', 'com.example.demo.controller.UserController', 'addBook', '{}', '{\"code\":0,\"msg\":\"成功\"}', 'ERROR', 'java.lang.Exception: 模拟异常', '2025-07-16 17:15:53');
INSERT INTO `sys_log` VALUES (4, 3, 'lisi', 'com.example.demo.controller.UserController', 'deleteBook', '{}', '{\"code\":0,\"msg\":\"成功\"}', 'INFO', NULL, '2025-07-16 17:15:53');
INSERT INTO `sys_log` VALUES (5, 5, 'wangwu', 'com.example.demo.service.BookService', 'deleteBook', '{}', '{\"code\":0,\"msg\":\"成功\"}', 'INFO', NULL, '2025-07-16 17:15:53');
INSERT INTO `sys_log` VALUES (6, 2, 'admin', 'com.example.demo.service.BookService', 'updateUser', '{}', '{\"code\":0,\"msg\":\"成功\"}', 'INFO', NULL, '2025-07-16 17:15:53');
INSERT INTO `sys_log` VALUES (7, 4, 'admin2', 'com.example.demo.controller.BookController', 'deleteBook', '{}', '{\"code\":0,\"msg\":\"成功\"}', 'ERROR', 'java.lang.Exception: 模拟异常', '2025-07-16 17:15:53');
INSERT INTO `sys_log` VALUES (8, 3, 'wangwu', 'com.example.demo.controller.UserController', 'addBook', '{}', '{\"code\":0,\"msg\":\"成功\"}', 'ERROR', 'java.lang.Exception: 模拟异常', '2025-07-16 17:15:53');
INSERT INTO `sys_log` VALUES (9, 3, 'admin2', 'com.example.demo.controller.BookController', 'addBook', '{}', '{\"code\":0,\"msg\":\"成功\"}', 'ERROR', 'java.lang.Exception: 模拟异常', '2025-07-16 17:15:53');
INSERT INTO `sys_log` VALUES (10, 3, 'admin2', 'com.example.demo.controller.UserController', 'updateUser', '{}', '{\"code\":0,\"msg\":\"成功\"}', 'ERROR', 'java.lang.Exception: 模拟异常', '2025-07-16 17:15:53');
INSERT INTO `sys_log` VALUES (11, 4, 'lisi', 'com.example.demo.controller.BookController', 'updateUser', '{}', '{\"code\":0,\"msg\":\"成功\"}', 'ERROR', 'java.lang.Exception: 模拟异常', '2025-07-16 17:15:53');
INSERT INTO `sys_log` VALUES (12, 1, 'zhangsan', 'com.example.demo.controller.UserController', 'login', '{}', '{\"code\":0,\"msg\":\"成功\"}', 'ERROR', 'java.lang.Exception: 模拟异常', '2025-07-16 17:15:53');
INSERT INTO `sys_log` VALUES (13, NULL, 'login', 'AuthController', 'login', '[{\"username\":\"admin\",\"password\":\"123456\"}]', NULL, 'INFO', NULL, '2025-07-16 17:26:45');
INSERT INTO `sys_log` VALUES (14, NULL, 'login', 'AuthController', 'login', '[{\"username\":\"admin\",\"password\":\"123456\"}]', NULL, 'INFO', NULL, '2025-07-15 17:26:49');
INSERT INTO `sys_log` VALUES (15, NULL, 'login', 'AuthController', 'login', '[{\"username\":\"admin\",\"password\":\"123456\"}]', NULL, 'INFO', NULL, '2025-07-16 17:26:57');
INSERT INTO `sys_log` VALUES (16, NULL, '2', 'BookController', 'searchBooks', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:27:07');
INSERT INTO `sys_log` VALUES (17, NULL, '2', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'ERROR', 'BadSqlGrammarException: \r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'\r\n### The error may exist in com/example/demo/mapper/BookRecommendationMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT  id,book_id,recommend_month,recommend_reason,operator_id,status,operator_name,name_cn,create_time,update_time  FROM book_recommendation     WHERE (status = ?) ORDER BY id DESC LIMIT ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'', '2025-07-16 17:27:12');
INSERT INTO `sys_log` VALUES (18, NULL, '2', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'ERROR', 'BadSqlGrammarException: \r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'\r\n### The error may exist in com/example/demo/mapper/BookRecommendationMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT  id,book_id,recommend_month,recommend_reason,operator_id,status,operator_name,name_cn,create_time,update_time  FROM book_recommendation     WHERE (status = ?) ORDER BY id DESC LIMIT ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'', '2025-07-16 17:27:14');
INSERT INTO `sys_log` VALUES (19, NULL, '2', 'BookController', 'searchBooks', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:27:17');
INSERT INTO `sys_log` VALUES (20, NULL, '2', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'ERROR', 'BadSqlGrammarException: \r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'\r\n### The error may exist in com/example/demo/mapper/BookRecommendationMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT  id,book_id,recommend_month,recommend_reason,operator_id,status,operator_name,name_cn,create_time,update_time  FROM book_recommendation     WHERE (status = ?) ORDER BY id DESC LIMIT ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'', '2025-07-16 17:27:18');
INSERT INTO `sys_log` VALUES (21, NULL, '2', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-16 17:27:19');
INSERT INTO `sys_log` VALUES (22, NULL, '2', 'LendRecordController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:27:22');
INSERT INTO `sys_log` VALUES (23, NULL, '2', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:27:26');
INSERT INTO `sys_log` VALUES (24, NULL, '2', 'LendRecordController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:27:27');
INSERT INTO `sys_log` VALUES (25, NULL, '2', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-16 17:27:29');
INSERT INTO `sys_log` VALUES (26, NULL, '2', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'ERROR', 'BadSqlGrammarException: \r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'\r\n### The error may exist in com/example/demo/mapper/BookRecommendationMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT  id,book_id,recommend_month,recommend_reason,operator_id,status,operator_name,name_cn,create_time,update_time  FROM book_recommendation     WHERE (status = ?) ORDER BY id DESC LIMIT ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'', '2025-07-16 17:27:31');
INSERT INTO `sys_log` VALUES (27, NULL, '2', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'ERROR', 'BadSqlGrammarException: \r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'\r\n### The error may exist in com/example/demo/mapper/BookRecommendationMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT  id,book_id,recommend_month,recommend_reason,operator_id,status,operator_name,name_cn,create_time,update_time  FROM book_recommendation     WHERE (status = ?) ORDER BY id DESC LIMIT ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'', '2025-07-16 17:27:37');
INSERT INTO `sys_log` VALUES (28, NULL, '2', 'AuthController', 'login', '[{\"username\":\"admin\",\"password\":\"123456\"}]', NULL, 'INFO', NULL, '2025-07-16 17:27:46');
INSERT INTO `sys_log` VALUES (29, NULL, 'login', 'AuthController', 'login', '[{\"username\":\"admin\",\"password\":\"123456\"}]', NULL, 'INFO', NULL, '2025-07-16 17:27:52');
INSERT INTO `sys_log` VALUES (30, NULL, '2', 'AuthController', 'login', '[{\"username\":\"admin\",\"password\":\"123456\"}]', NULL, 'INFO', NULL, '2025-07-16 17:28:23');
INSERT INTO `sys_log` VALUES (31, NULL, '2', 'AuthController', 'login', '[{\"username\":\"admin\",\"password\":\"123456\"}]', NULL, 'INFO', NULL, '2025-07-16 17:29:05');
INSERT INTO `sys_log` VALUES (32, NULL, '1', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-16 17:29:07');
INSERT INTO `sys_log` VALUES (33, NULL, '1', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'ERROR', 'BadSqlGrammarException: \r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'\r\n### The error may exist in com/example/demo/mapper/BookRecommendationMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT  id,book_id,recommend_month,recommend_reason,operator_id,status,operator_name,name_cn,create_time,update_time  FROM book_recommendation           ORDER BY id DESC LIMIT ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'', '2025-07-16 17:29:07');
INSERT INTO `sys_log` VALUES (34, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:29:11');
INSERT INTO `sys_log` VALUES (35, NULL, '1', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'ERROR', 'BadSqlGrammarException: \r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'\r\n### The error may exist in com/example/demo/mapper/BookRecommendationMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT  id,book_id,recommend_month,recommend_reason,operator_id,status,operator_name,name_cn,create_time,update_time  FROM book_recommendation           ORDER BY id DESC LIMIT ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'', '2025-07-16 17:29:13');
INSERT INTO `sys_log` VALUES (36, NULL, '1', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-16 17:29:19');
INSERT INTO `sys_log` VALUES (37, NULL, '1', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'ERROR', 'BadSqlGrammarException: \r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'\r\n### The error may exist in com/example/demo/mapper/BookRecommendationMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT  id,book_id,recommend_month,recommend_reason,operator_id,status,operator_name,name_cn,create_time,update_time  FROM book_recommendation           ORDER BY id DESC LIMIT ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'', '2025-07-16 17:29:19');
INSERT INTO `sys_log` VALUES (38, NULL, '1', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'ERROR', 'BadSqlGrammarException: \r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'\r\n### The error may exist in com/example/demo/mapper/BookRecommendationMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT  id,book_id,recommend_month,recommend_reason,operator_id,status,operator_name,name_cn,create_time,update_time  FROM book_recommendation           ORDER BY id DESC LIMIT ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'operator_name\' in \'field list\'', '2025-07-16 17:29:41');
INSERT INTO `sys_log` VALUES (39, NULL, '1', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'ERROR', 'BadSqlGrammarException: \r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'name_cn\' in \'field list\'\r\n### The error may exist in com/example/demo/mapper/BookRecommendationMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT  id,book_id,recommend_month,recommend_reason,operator_id,status,operator_name,name_cn,create_time,update_time  FROM book_recommendation           ORDER BY id DESC LIMIT ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'name_cn\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'name_cn\' in \'field list\'', '2025-07-16 17:32:26');
INSERT INTO `sys_log` VALUES (40, NULL, '1', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 17:36:32');
INSERT INTO `sys_log` VALUES (41, NULL, '2', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 17:36:39');
INSERT INTO `sys_log` VALUES (42, NULL, '1', 'BookRecommendationController', 'search', '[null,2,10]', NULL, 'INFO', NULL, '2025-07-16 17:36:52');
INSERT INTO `sys_log` VALUES (43, NULL, '2', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 17:37:02');
INSERT INTO `sys_log` VALUES (44, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:37:06');
INSERT INTO `sys_log` VALUES (45, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:38:21');
INSERT INTO `sys_log` VALUES (46, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:38:23');
INSERT INTO `sys_log` VALUES (47, NULL, '1', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-16 17:38:30');
INSERT INTO `sys_log` VALUES (48, NULL, '1', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 17:38:30');
INSERT INTO `sys_log` VALUES (49, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:38:32');
INSERT INTO `sys_log` VALUES (50, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:39:09');
INSERT INTO `sys_log` VALUES (51, NULL, '1', 'BookController', 'searchBooks', '[2,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:39:12');
INSERT INTO `sys_log` VALUES (52, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:39:14');
INSERT INTO `sys_log` VALUES (53, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:39:38');
INSERT INTO `sys_log` VALUES (54, NULL, '1', 'BookController', 'searchBooks', '[2,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:39:47');
INSERT INTO `sys_log` VALUES (55, NULL, '1', 'BookController', 'deleteBooks', '[{\"ids\":[12]}]', NULL, 'INFO', NULL, '2025-07-16 17:39:51');
INSERT INTO `sys_log` VALUES (56, NULL, '1', 'BookController', 'searchBooks', '[2,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:39:51');
INSERT INTO `sys_log` VALUES (57, NULL, '1', 'BookController', 'updateBook', '[{\"id\":11,\"bookNumber\":\"BK20240011\",\"isbn\":\"9787532149179\",\"nameCn\":\"围城\",\"nameId\":\"\",\"language\":\"中文\",\"author\":\"钱钟书\",\"translator\":\"\",\"publisher\":\"人民文学出版社\",\"publishDate\":{\"year\":2005,\"month\":\"AUGUST\",\"monthValue\":8,\"dayOfMonth\":1,\"leapYear\":false,\"dayOfWeek\":\"MONDAY\",\"dayOfYear\":213,\"era\":\"CE\",\"chronology\":{\"id\":\"ISO\",\"calendarType\":\"iso8601\",\"isoBased\":true}},\"price\":36,\"categoryId\":1,\"location\":\"L-205\",\"totalQuantity\":8,\"availableQuantity\":7,\"borrowCount\":19,\"status\":1,\"description\":\"讽刺小说经典，描述知识分子的生活状态。\",\"coverImage\":\"/uploads/1752658806408_login.png\",\"ratingAvg\":4.7,\"translationunit\":\"CNY\",\"createTime\":null,\"updateTime\":null}]', NULL, 'INFO', NULL, '2025-07-16 17:40:07');
INSERT INTO `sys_log` VALUES (58, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:40:07');
INSERT INTO `sys_log` VALUES (59, NULL, '1', 'BookController', 'searchBooks', '[2,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:40:10');
INSERT INTO `sys_log` VALUES (60, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:40:15');
INSERT INTO `sys_log` VALUES (61, NULL, '1', 'BookController', 'deleteBook', '[10]', NULL, 'INFO', NULL, '2025-07-16 17:40:26');
INSERT INTO `sys_log` VALUES (62, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:40:26');
INSERT INTO `sys_log` VALUES (63, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"人工智能导论\"]', NULL, 'INFO', NULL, '2025-07-16 17:40:33');
INSERT INTO `sys_log` VALUES (64, NULL, '1', 'BookController', 'exportExcel', '[null,null,null]', NULL, 'INFO', NULL, '2025-07-16 17:40:37');
INSERT INTO `sys_log` VALUES (65, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:40:54');
INSERT INTO `sys_log` VALUES (66, NULL, '1', 'BookController', 'batchUpdateStatus', '[{\"status\":0,\"ids\":[1]}]', NULL, 'INFO', NULL, '2025-07-16 17:40:58');
INSERT INTO `sys_log` VALUES (67, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:40:58');
INSERT INTO `sys_log` VALUES (68, NULL, '2', 'BookController', 'searchBooks', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:41:01');
INSERT INTO `sys_log` VALUES (69, NULL, '1', 'BookController', 'batchUpdateStatus', '[{\"status\":1,\"ids\":[1]}]', NULL, 'INFO', NULL, '2025-07-16 17:41:07');
INSERT INTO `sys_log` VALUES (70, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:41:07');
INSERT INTO `sys_log` VALUES (71, NULL, '2', 'BookController', 'searchBooks', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:41:10');
INSERT INTO `sys_log` VALUES (72, NULL, '2', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 17:41:11');
INSERT INTO `sys_log` VALUES (73, NULL, '2', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-16 17:41:20');
INSERT INTO `sys_log` VALUES (74, NULL, '2', 'UserServiceImpl', 'updateUser', '[{\"id\":2,\"username\":\"jdoe\",\"nickName\":\"John Doe\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"sex\":\"女\",\"address\":\"文学部\",\"phone\":\"13800000002\",\"role\":null,\"createTime\":null,\"updateTime\":null,\"status\":null}]', NULL, 'INFO', NULL, '2025-07-16 17:41:24');
INSERT INTO `sys_log` VALUES (75, NULL, '2', 'UserController', 'update', '[{\"id\":2,\"username\":\"jdoe\",\"nickName\":\"John Doe\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"sex\":\"女\",\"address\":\"文学部\",\"phone\":\"13800000002\",\"role\":null,\"createTime\":null,\"updateTime\":null,\"status\":null}]', NULL, 'INFO', NULL, '2025-07-16 17:41:24');
INSERT INTO `sys_log` VALUES (76, NULL, '2', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-16 17:41:25');
INSERT INTO `sys_log` VALUES (77, NULL, '2', 'LendRecordController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:41:32');
INSERT INTO `sys_log` VALUES (78, NULL, '1', 'AuthController', 'login', '[{\"username\":\"jdoe\",\"password\":\"123456\"}]', NULL, 'INFO', NULL, '2025-07-16 17:42:04');
INSERT INTO `sys_log` VALUES (79, NULL, '2', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-16 17:42:04');
INSERT INTO `sys_log` VALUES (80, NULL, '2', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 17:42:04');
INSERT INTO `sys_log` VALUES (81, NULL, '2', 'LendRecordController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:42:09');
INSERT INTO `sys_log` VALUES (82, NULL, '1', 'BookController', 'CreateBook', '[{\"id\":null,\"bookNumber\":\"1234\",\"isbn\":\"123\",\"language\":\"中文\",\"nameCn\":\"123\",\"nameId\":\"123\",\"author\":\"21\",\"translator\":\"123\",\"publisher\":\"12\",\"description\":\"2ew\",\"coverImage\":\"/uploads/1752658968538_book.png\",\"publishDate\":{\"year\":2025,\"month\":\"JULY\",\"monthValue\":7,\"dayOfMonth\":19,\"leapYear\":false,\"dayOfWeek\":\"SATURDAY\",\"dayOfYear\":200,\"era\":\"CE\",\"chronology\":{\"id\":\"ISO\",\"calendarType\":\"iso8601\",\"isoBased\":true}},\"price\":null,\"categoryId\":null,\"location\":\"2锇\",\"totalQuantity\":12,\"availableQuantity\":4,\"status\":1,\"translationunit\":\"CNY\"}]', NULL, 'INFO', NULL, '2025-07-16 17:42:52');
INSERT INTO `sys_log` VALUES (83, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:42:52');
INSERT INTO `sys_log` VALUES (84, NULL, '1', 'BookController', 'searchBooks', '[2,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:42:55');
INSERT INTO `sys_log` VALUES (85, NULL, '1', 'BookController', 'deleteBook', '[13]', NULL, 'INFO', NULL, '2025-07-16 17:43:00');
INSERT INTO `sys_log` VALUES (86, NULL, '1', 'BookController', 'searchBooks', '[2,10,\"\"]', NULL, 'INFO', NULL, '2025-07-16 17:43:00');
INSERT INTO `sys_log` VALUES (87, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:43:01');
INSERT INTO `sys_log` VALUES (88, NULL, '1', 'BookCommentController', 'deleteBatch', '[[3]]', NULL, 'INFO', NULL, '2025-07-16 17:43:11');
INSERT INTO `sys_log` VALUES (89, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:43:11');
INSERT INTO `sys_log` VALUES (90, NULL, '1', 'BookCommentController', 'page', '[2,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:43:13');
INSERT INTO `sys_log` VALUES (91, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:43:14');
INSERT INTO `sys_log` VALUES (92, NULL, '1', 'BookRecommendationController', 'search', '[\"\",1,10]', NULL, 'INFO', NULL, '2025-07-16 17:43:16');
INSERT INTO `sys_log` VALUES (93, NULL, '1', 'BookRecommendationController', 'search', '[\"\",2,10]', NULL, 'INFO', NULL, '2025-07-16 17:43:19');
INSERT INTO `sys_log` VALUES (94, NULL, '1', 'BookRecommendationController', 'delete', '[1]', NULL, 'INFO', NULL, '2025-07-16 17:43:22');
INSERT INTO `sys_log` VALUES (95, NULL, '1', 'BookRecommendationController', 'search', '[\"\",2,10]', NULL, 'INFO', NULL, '2025-07-16 17:43:22');
INSERT INTO `sys_log` VALUES (96, NULL, '1', 'BookRecommendationController', 'search', '[\"\",1,10]', NULL, 'INFO', NULL, '2025-07-16 17:43:23');
INSERT INTO `sys_log` VALUES (97, NULL, '1', 'BookRecommendationController', 'create', '[{\"id\":null,\"bookId\":null,\"recommendMonth\":\"2025-07\",\"recommendReason\":\"123\",\"operatorId\":null,\"status\":1,\"bookName\":\"人工智能导论\"}]', NULL, 'INFO', NULL, '2025-07-16 17:43:42');
INSERT INTO `sys_log` VALUES (98, NULL, '1', 'BookRecommendationController', 'search', '[\"\",1,10]', NULL, 'INFO', NULL, '2025-07-16 17:43:44');
INSERT INTO `sys_log` VALUES (99, NULL, '1', 'BookRecommendationController', 'search', '[\"\",1,10]', NULL, 'INFO', NULL, '2025-07-16 17:43:44');
INSERT INTO `sys_log` VALUES (100, NULL, '1', 'BookRecommendationController', 'delete', '[13]', NULL, 'INFO', NULL, '2025-07-16 17:43:51');
INSERT INTO `sys_log` VALUES (101, NULL, '1', 'BookRecommendationController', 'search', '[\"\",1,10]', NULL, 'INFO', NULL, '2025-07-16 17:43:51');
INSERT INTO `sys_log` VALUES (102, NULL, '1', 'BookRecommendationController', 'batchUpdateStatus', '[[12],0]', NULL, 'INFO', NULL, '2025-07-16 17:43:55');
INSERT INTO `sys_log` VALUES (103, NULL, '1', 'BookRecommendationController', 'search', '[\"\",1,10]', NULL, 'INFO', NULL, '2025-07-16 17:43:55');
INSERT INTO `sys_log` VALUES (104, NULL, '2', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 17:44:00');
INSERT INTO `sys_log` VALUES (105, NULL, '2', 'BookController', 'searchBooks', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:44:01');
INSERT INTO `sys_log` VALUES (106, NULL, '2', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 17:44:02');
INSERT INTO `sys_log` VALUES (107, NULL, '1', 'BookRecommendationController', 'batchUpdateStatus', '[[12],1]', NULL, 'INFO', NULL, '2025-07-16 17:44:08');
INSERT INTO `sys_log` VALUES (108, NULL, '1', 'BookRecommendationController', 'search', '[\"\",1,10]', NULL, 'INFO', NULL, '2025-07-16 17:44:08');
INSERT INTO `sys_log` VALUES (109, NULL, '2', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 17:44:11');
INSERT INTO `sys_log` VALUES (110, NULL, '1', 'LendRecordController', 'create', '[{\"id\":null,\"readerId\":null,\"bookId\":null,\"bookName\":null,\"bookNumber\":null,\"username\":\"jdoe\",\"isbn\":\"9787302523103\",\"lendTime\":{\"nano\":0,\"year\":2025,\"monthValue\":7,\"dayOfMonth\":25,\"hour\":0,\"minute\":0,\"second\":0,\"month\":\"JULY\",\"dayOfWeek\":\"FRIDAY\",\"dayOfYear\":206,\"chronology\":{\"id\":\"ISO\",\"calendarType\":\"iso8601\",\"isoBased\":true}},\"dueTime\":{\"nano\":0,\"year\":2025,\"monthValue\":7,\"dayOfMonth\":27,\"hour\":0,\"minute\":0,\"second\":0,\"month\":\"JULY\",\"dayOfWeek\":\"SUNDAY\",\"dayOfYear\":208,\"chronology\":{\"id\":\"ISO\",\"calendarType\":\"iso8601\",\"isoBased\":true}},\"returnTime\":null,\"status\":null,\"borrowDays\":null,\"operatorId\":null,\"remark\":null,\"renewalCount\":null}]', NULL, 'ERROR', 'BadSqlGrammarException: \r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'user_name\' in \'field list\'\r\n### The error may exist in com/example/demo/mapper/LendRecordMapper.java (best guess)\r\n### The error may involve com.example.demo.mapper.LendRecordMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO lend_record  ( reader_id, book_id, book_name, book_number, lend_time, due_time,  status,     user_name, create_time, update_time )  VALUES  ( ?, ?, ?, ?, ?, ?,  ?,     ?, ?, ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'user_name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'user_name\' in \'field list\'', '2025-07-16 17:44:45');
INSERT INTO `sys_log` VALUES (111, NULL, '1', 'LendRecordController', 'create', '[{\"id\":null,\"readerId\":null,\"bookId\":null,\"bookName\":null,\"bookNumber\":null,\"username\":\"jdoe\",\"isbn\":\"9787302523103\",\"lendTime\":{\"nano\":0,\"year\":2025,\"monthValue\":7,\"dayOfMonth\":25,\"hour\":0,\"minute\":0,\"second\":0,\"month\":\"JULY\",\"dayOfWeek\":\"FRIDAY\",\"dayOfYear\":206,\"chronology\":{\"id\":\"ISO\",\"calendarType\":\"iso8601\",\"isoBased\":true}},\"dueTime\":{\"nano\":0,\"year\":2025,\"monthValue\":7,\"dayOfMonth\":27,\"hour\":0,\"minute\":0,\"second\":0,\"month\":\"JULY\",\"dayOfWeek\":\"SUNDAY\",\"dayOfYear\":208,\"chronology\":{\"id\":\"ISO\",\"calendarType\":\"iso8601\",\"isoBased\":true}},\"returnTime\":null,\"status\":null,\"borrowDays\":null,\"operatorId\":null,\"remark\":null,\"renewalCount\":null}]', NULL, 'ERROR', 'BadSqlGrammarException: \r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'user_name\' in \'field list\'\r\n### The error may exist in com/example/demo/mapper/LendRecordMapper.java (best guess)\r\n### The error may involve com.example.demo.mapper.LendRecordMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO lend_record  ( reader_id, book_id, book_name, book_number, lend_time, due_time,  status,     user_name, create_time, update_time )  VALUES  ( ?, ?, ?, ?, ?, ?,  ?,     ?, ?, ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'user_name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'user_name\' in \'field list\'', '2025-07-16 17:44:59');
INSERT INTO `sys_log` VALUES (112, NULL, '1', 'LendRecordController', 'create', '[{\"id\":null,\"readerId\":null,\"bookId\":null,\"bookName\":null,\"bookNumber\":null,\"username\":\"jdoe\",\"isbn\":\"9787302523103\",\"lendTime\":{\"nano\":0,\"year\":2025,\"monthValue\":7,\"dayOfMonth\":25,\"hour\":0,\"minute\":0,\"second\":0,\"month\":\"JULY\",\"dayOfWeek\":\"FRIDAY\",\"dayOfYear\":206,\"chronology\":{\"id\":\"ISO\",\"calendarType\":\"iso8601\",\"isoBased\":true}},\"dueTime\":{\"nano\":0,\"year\":2025,\"monthValue\":7,\"dayOfMonth\":27,\"hour\":0,\"minute\":0,\"second\":0,\"month\":\"JULY\",\"dayOfWeek\":\"SUNDAY\",\"dayOfYear\":208,\"chronology\":{\"id\":\"ISO\",\"calendarType\":\"iso8601\",\"isoBased\":true}},\"returnTime\":null,\"status\":null,\"borrowDays\":null,\"operatorId\":null,\"remark\":null,\"renewalCount\":null}]', NULL, 'ERROR', 'BadSqlGrammarException: \r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'user_name\' in \'field list\'\r\n### The error may exist in com/example/demo/mapper/LendRecordMapper.java (best guess)\r\n### The error may involve com.example.demo.mapper.LendRecordMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO lend_record  ( reader_id, book_id, book_name, book_number, lend_time, due_time,  status,     user_name, create_time, update_time )  VALUES  ( ?, ?, ?, ?, ?, ?,  ?,     ?, ?, ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'user_name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'user_name\' in \'field list\'', '2025-07-16 17:45:27');
INSERT INTO `sys_log` VALUES (113, NULL, '1', 'LendRecordController', 'create', '[{\"id\":null,\"readerId\":null,\"bookId\":null,\"bookName\":null,\"bookNumber\":null,\"username\":\"jdoe\",\"isbn\":\"9787302523103\",\"lendTime\":{\"nano\":0,\"year\":2025,\"monthValue\":7,\"dayOfMonth\":25,\"hour\":0,\"minute\":0,\"second\":0,\"month\":\"JULY\",\"dayOfWeek\":\"FRIDAY\",\"dayOfYear\":206,\"chronology\":{\"id\":\"ISO\",\"calendarType\":\"iso8601\",\"isoBased\":true}},\"dueTime\":{\"nano\":0,\"year\":2025,\"monthValue\":7,\"dayOfMonth\":27,\"hour\":0,\"minute\":0,\"second\":0,\"month\":\"JULY\",\"dayOfWeek\":\"SUNDAY\",\"dayOfYear\":208,\"chronology\":{\"id\":\"ISO\",\"calendarType\":\"iso8601\",\"isoBased\":true}},\"returnTime\":null,\"status\":null,\"borrowDays\":null,\"operatorId\":null,\"remark\":null,\"renewalCount\":null}]', NULL, 'INFO', NULL, '2025-07-16 17:48:39');
INSERT INTO `sys_log` VALUES (114, NULL, '1', 'BookController', 'searchBooks', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:48:43');
INSERT INTO `sys_log` VALUES (115, NULL, '2', 'LendRecordController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:48:50');
INSERT INTO `sys_log` VALUES (116, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 17:49:11');
INSERT INTO `sys_log` VALUES (117, NULL, '1', 'LendRecordController', 'search', '[null,2,10]', NULL, 'INFO', NULL, '2025-07-16 17:49:13');
INSERT INTO `sys_log` VALUES (118, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 17:49:17');
INSERT INTO `sys_log` VALUES (119, NULL, '1', 'LendRecordController', 'returned', '[13]', NULL, 'INFO', NULL, '2025-07-16 17:49:22');
INSERT INTO `sys_log` VALUES (120, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 17:49:22');
INSERT INTO `sys_log` VALUES (121, NULL, '2', 'LendRecordController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:49:25');
INSERT INTO `sys_log` VALUES (122, NULL, '2', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:49:31');
INSERT INTO `sys_log` VALUES (123, NULL, '1', 'UserController', 'searchUsers', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 17:49:36');
INSERT INTO `sys_log` VALUES (124, NULL, '1', 'UserController', 'add', '[{\"id\":null,\"username\":\"admin12\",\"nickName\":\"123\",\"password\":\"123456\",\"sex\":\"男\",\"address\":\"31\",\"phone\":\"18810919153\",\"role\":0,\"createTime\":null,\"updateTime\":null,\"status\":0}]', NULL, 'INFO', NULL, '2025-07-16 17:50:11');
INSERT INTO `sys_log` VALUES (125, NULL, '1', 'UserController', 'searchUsers', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 17:50:12');
INSERT INTO `sys_log` VALUES (127, NULL, '1', 'UserController', 'searchUsers', '[null,2,10]', NULL, 'INFO', NULL, '2025-07-16 17:50:15');
INSERT INTO `sys_log` VALUES (128, NULL, '1', 'UserServiceImpl', 'updateUser', '[{\"id\":13,\"username\":\"admin12\",\"nickName\":\"123\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"sex\":\"女\",\"address\":\"31\",\"phone\":\"18810919153\",\"role\":1,\"createTime\":null,\"updateTime\":null,\"status\":0}]', NULL, 'INFO', NULL, '2025-07-16 17:50:29');
INSERT INTO `sys_log` VALUES (129, NULL, '1', 'UserController', 'update', '[{\"id\":13,\"username\":\"admin12\",\"nickName\":\"123\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"sex\":\"女\",\"address\":\"31\",\"phone\":\"18810919153\",\"role\":1,\"createTime\":null,\"updateTime\":null,\"status\":0}]', NULL, 'INFO', NULL, '2025-07-16 17:50:29');
INSERT INTO `sys_log` VALUES (130, NULL, '1', 'UserController', 'searchUsers', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 17:50:30');
INSERT INTO `sys_log` VALUES (131, NULL, '1', 'UserController', 'searchUsers', '[null,2,10]', NULL, 'INFO', NULL, '2025-07-16 17:50:33');
INSERT INTO `sys_log` VALUES (132, NULL, '1', 'UserController', 'delete', '[13]', NULL, 'INFO', NULL, '2025-07-16 17:50:35');
INSERT INTO `sys_log` VALUES (133, NULL, '1', 'UserController', 'searchUsers', '[null,2,10]', NULL, 'INFO', NULL, '2025-07-16 17:50:35');
INSERT INTO `sys_log` VALUES (134, NULL, '1', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-16 17:50:40');
INSERT INTO `sys_log` VALUES (135, NULL, '1', 'UserController', 'searchUsers', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 17:50:45');
INSERT INTO `sys_log` VALUES (136, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:50:55');
INSERT INTO `sys_log` VALUES (137, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:50:55');
INSERT INTO `sys_log` VALUES (138, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:50:55');
INSERT INTO `sys_log` VALUES (139, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:50:55');
INSERT INTO `sys_log` VALUES (140, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:51:45');
INSERT INTO `sys_log` VALUES (141, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:51:45');
INSERT INTO `sys_log` VALUES (142, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:51:45');
INSERT INTO `sys_log` VALUES (143, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:51:45');
INSERT INTO `sys_log` VALUES (144, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:52:07');
INSERT INTO `sys_log` VALUES (145, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:52:07');
INSERT INTO `sys_log` VALUES (146, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:52:07');
INSERT INTO `sys_log` VALUES (147, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:52:07');
INSERT INTO `sys_log` VALUES (148, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:52:08');
INSERT INTO `sys_log` VALUES (149, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:52:08');
INSERT INTO `sys_log` VALUES (150, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:52:08');
INSERT INTO `sys_log` VALUES (151, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:52:08');
INSERT INTO `sys_log` VALUES (152, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:52:41');
INSERT INTO `sys_log` VALUES (153, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:52:41');
INSERT INTO `sys_log` VALUES (154, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:52:41');
INSERT INTO `sys_log` VALUES (155, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:52:41');
INSERT INTO `sys_log` VALUES (156, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:52:41');
INSERT INTO `sys_log` VALUES (157, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:52:41');
INSERT INTO `sys_log` VALUES (158, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:52:41');
INSERT INTO `sys_log` VALUES (159, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:52:41');
INSERT INTO `sys_log` VALUES (160, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:23');
INSERT INTO `sys_log` VALUES (161, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:23');
INSERT INTO `sys_log` VALUES (162, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:23');
INSERT INTO `sys_log` VALUES (163, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:23');
INSERT INTO `sys_log` VALUES (164, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:23');
INSERT INTO `sys_log` VALUES (165, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:23');
INSERT INTO `sys_log` VALUES (166, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:23');
INSERT INTO `sys_log` VALUES (167, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:23');
INSERT INTO `sys_log` VALUES (168, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:35');
INSERT INTO `sys_log` VALUES (169, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:35');
INSERT INTO `sys_log` VALUES (170, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:35');
INSERT INTO `sys_log` VALUES (171, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:35');
INSERT INTO `sys_log` VALUES (172, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:36');
INSERT INTO `sys_log` VALUES (173, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:36');
INSERT INTO `sys_log` VALUES (174, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:36');
INSERT INTO `sys_log` VALUES (175, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:36');
INSERT INTO `sys_log` VALUES (176, NULL, '1', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:45');
INSERT INTO `sys_log` VALUES (177, NULL, '1', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 17:53:45');
INSERT INTO `sys_log` VALUES (178, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:47');
INSERT INTO `sys_log` VALUES (179, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:47');
INSERT INTO `sys_log` VALUES (180, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:47');
INSERT INTO `sys_log` VALUES (181, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:53:47');
INSERT INTO `sys_log` VALUES (182, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:54:17');
INSERT INTO `sys_log` VALUES (183, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:54:17');
INSERT INTO `sys_log` VALUES (184, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:54:17');
INSERT INTO `sys_log` VALUES (185, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:54:17');
INSERT INTO `sys_log` VALUES (186, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:54:41');
INSERT INTO `sys_log` VALUES (187, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:54:41');
INSERT INTO `sys_log` VALUES (188, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:54:41');
INSERT INTO `sys_log` VALUES (189, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:54:41');
INSERT INTO `sys_log` VALUES (190, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:54:44');
INSERT INTO `sys_log` VALUES (191, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:54:44');
INSERT INTO `sys_log` VALUES (192, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:54:44');
INSERT INTO `sys_log` VALUES (193, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:54:44');
INSERT INTO `sys_log` VALUES (194, NULL, '1', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-16 17:54:49');
INSERT INTO `sys_log` VALUES (195, NULL, '1', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 17:54:49');
INSERT INTO `sys_log` VALUES (196, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:54:52');
INSERT INTO `sys_log` VALUES (197, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:54:52');
INSERT INTO `sys_log` VALUES (198, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:54:52');
INSERT INTO `sys_log` VALUES (199, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:54:52');
INSERT INTO `sys_log` VALUES (200, NULL, '1', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-16 17:55:01');
INSERT INTO `sys_log` VALUES (201, NULL, '1', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 17:55:01');
INSERT INTO `sys_log` VALUES (202, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:55:03');
INSERT INTO `sys_log` VALUES (203, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:55:03');
INSERT INTO `sys_log` VALUES (204, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:55:03');
INSERT INTO `sys_log` VALUES (205, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:55:03');
INSERT INTO `sys_log` VALUES (206, NULL, '2', 'LendRecordController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:55:54');
INSERT INTO `sys_log` VALUES (207, NULL, '2', 'LendRecordController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:56:02');
INSERT INTO `sys_log` VALUES (208, NULL, '2', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-16 17:56:03');
INSERT INTO `sys_log` VALUES (209, NULL, '2', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:56:05');
INSERT INTO `sys_log` VALUES (210, NULL, '2', 'BookController', 'searchBooks', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-16 17:56:08');
INSERT INTO `sys_log` VALUES (211, NULL, '2', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 17:56:14');
INSERT INTO `sys_log` VALUES (212, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:56:21');
INSERT INTO `sys_log` VALUES (213, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:56:21');
INSERT INTO `sys_log` VALUES (214, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:56:21');
INSERT INTO `sys_log` VALUES (215, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:56:21');
INSERT INTO `sys_log` VALUES (216, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:57:15');
INSERT INTO `sys_log` VALUES (217, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:57:15');
INSERT INTO `sys_log` VALUES (218, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:57:15');
INSERT INTO `sys_log` VALUES (219, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:57:15');
INSERT INTO `sys_log` VALUES (220, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:57:37');
INSERT INTO `sys_log` VALUES (221, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:57:37');
INSERT INTO `sys_log` VALUES (222, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:57:37');
INSERT INTO `sys_log` VALUES (223, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:57:37');
INSERT INTO `sys_log` VALUES (224, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:58:04');
INSERT INTO `sys_log` VALUES (225, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:58:04');
INSERT INTO `sys_log` VALUES (226, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:58:04');
INSERT INTO `sys_log` VALUES (227, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 17:58:04');
INSERT INTO `sys_log` VALUES (228, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:01:22');
INSERT INTO `sys_log` VALUES (229, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:02:01');
INSERT INTO `sys_log` VALUES (230, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:02:01');
INSERT INTO `sys_log` VALUES (231, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:02:01');
INSERT INTO `sys_log` VALUES (232, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:02:04');
INSERT INTO `sys_log` VALUES (233, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:02:54');
INSERT INTO `sys_log` VALUES (234, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:02:54');
INSERT INTO `sys_log` VALUES (235, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:02:54');
INSERT INTO `sys_log` VALUES (236, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:02:54');
INSERT INTO `sys_log` VALUES (237, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:02:54');
INSERT INTO `sys_log` VALUES (238, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:02:54');
INSERT INTO `sys_log` VALUES (239, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:02:54');
INSERT INTO `sys_log` VALUES (240, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:02:54');
INSERT INTO `sys_log` VALUES (241, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:05:59');
INSERT INTO `sys_log` VALUES (242, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:05:59');
INSERT INTO `sys_log` VALUES (243, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:05:59');
INSERT INTO `sys_log` VALUES (244, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:05:59');
INSERT INTO `sys_log` VALUES (245, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:08:36');
INSERT INTO `sys_log` VALUES (246, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:08:36');
INSERT INTO `sys_log` VALUES (247, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:08:36');
INSERT INTO `sys_log` VALUES (248, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:08:36');
INSERT INTO `sys_log` VALUES (249, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:09:09');
INSERT INTO `sys_log` VALUES (250, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:09:09');
INSERT INTO `sys_log` VALUES (251, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:09:09');
INSERT INTO `sys_log` VALUES (252, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:09:09');
INSERT INTO `sys_log` VALUES (253, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:09:35');
INSERT INTO `sys_log` VALUES (254, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:09:35');
INSERT INTO `sys_log` VALUES (255, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:09:35');
INSERT INTO `sys_log` VALUES (256, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:09:35');
INSERT INTO `sys_log` VALUES (257, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:09:36');
INSERT INTO `sys_log` VALUES (258, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:09:36');
INSERT INTO `sys_log` VALUES (259, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:09:36');
INSERT INTO `sys_log` VALUES (260, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-16 18:09:36');
INSERT INTO `sys_log` VALUES (261, NULL, '1', 'UserController', 'searchUsers', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 18:09:43');
INSERT INTO `sys_log` VALUES (262, NULL, '1', 'UserController', 'searchUsers', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-16 18:13:11');
INSERT INTO `sys_log` VALUES (263, NULL, 'login', 'AuthController', 'login', '[{\"username\":\"admin\",\"password\":\"123456\"}]', NULL, 'INFO', NULL, '2025-07-18 09:15:03');
INSERT INTO `sys_log` VALUES (264, NULL, '1', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-18 09:15:04');
INSERT INTO `sys_log` VALUES (265, NULL, '1', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:15:04');
INSERT INTO `sys_log` VALUES (266, NULL, 'login', 'AuthController', 'login', '[{\"username\":\"jdoe\",\"password\":\"123456\"}]', NULL, 'INFO', NULL, '2025-07-18 09:15:16');
INSERT INTO `sys_log` VALUES (267, NULL, '2', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-18 09:15:16');
INSERT INTO `sys_log` VALUES (268, NULL, '2', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:15:16');
INSERT INTO `sys_log` VALUES (269, NULL, '2', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:15:20');
INSERT INTO `sys_log` VALUES (270, NULL, '2', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:15:24');
INSERT INTO `sys_log` VALUES (271, NULL, '2', 'BookController', 'searchBooks', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 09:15:27');
INSERT INTO `sys_log` VALUES (272, NULL, '2', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:15:38');
INSERT INTO `sys_log` VALUES (273, NULL, '2', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-18 09:15:47');
INSERT INTO `sys_log` VALUES (274, NULL, '2', 'LendRecordController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 09:15:54');
INSERT INTO `sys_log` VALUES (275, NULL, '2', 'LendRecordController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 09:16:00');
INSERT INTO `sys_log` VALUES (276, NULL, '2', 'LendRecordController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 09:16:14');
INSERT INTO `sys_log` VALUES (277, NULL, '2', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 09:17:12');
INSERT INTO `sys_log` VALUES (278, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"\"]', NULL, 'INFO', NULL, '2025-07-18 09:17:23');
INSERT INTO `sys_log` VALUES (279, NULL, '1', 'BookController', 'exportExcel', '[null,null,null]', NULL, 'INFO', NULL, '2025-07-18 09:17:32');
INSERT INTO `sys_log` VALUES (280, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 09:18:44');
INSERT INTO `sys_log` VALUES (281, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:19:35');
INSERT INTO `sys_log` VALUES (282, NULL, '1', 'LendRecordController', 'returned', '[10]', NULL, 'INFO', NULL, '2025-07-18 09:19:45');
INSERT INTO `sys_log` VALUES (283, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:19:45');
INSERT INTO `sys_log` VALUES (284, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 09:20:12');
INSERT INTO `sys_log` VALUES (285, NULL, '1', 'BookRecommendationController', 'search', '[\"\",1,10]', NULL, 'INFO', NULL, '2025-07-18 09:20:26');
INSERT INTO `sys_log` VALUES (286, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 09:20:27');
INSERT INTO `sys_log` VALUES (287, NULL, '1', 'BookRecommendationController', 'search', '[\"\",1,10]', NULL, 'INFO', NULL, '2025-07-18 09:20:27');
INSERT INTO `sys_log` VALUES (288, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:20:43');
INSERT INTO `sys_log` VALUES (289, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:21:24');
INSERT INTO `sys_log` VALUES (290, NULL, '1', 'UserController', 'searchUsers', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:21:41');
INSERT INTO `sys_log` VALUES (291, NULL, '1', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-18 09:24:13');
INSERT INTO `sys_log` VALUES (292, NULL, '1', 'StatsController', 'bookTrend', '[]', NULL, 'INFO', NULL, '2025-07-18 09:24:33');
INSERT INTO `sys_log` VALUES (293, NULL, '1', 'StatsController', 'userTrend', '[]', NULL, 'INFO', NULL, '2025-07-18 09:24:33');
INSERT INTO `sys_log` VALUES (294, NULL, '1', 'StatsController', 'getVisitTrend', '[]', NULL, 'INFO', NULL, '2025-07-18 09:24:33');
INSERT INTO `sys_log` VALUES (295, NULL, '1', 'StatsController', 'borrowTrend', '[]', NULL, 'INFO', NULL, '2025-07-18 09:24:33');
INSERT INTO `sys_log` VALUES (296, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:24:43');
INSERT INTO `sys_log` VALUES (297, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"\"]', NULL, 'INFO', NULL, '2025-07-18 09:25:18');
INSERT INTO `sys_log` VALUES (298, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"\"]', NULL, 'INFO', NULL, '2025-07-18 09:25:21');
INSERT INTO `sys_log` VALUES (299, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"\"]', NULL, 'INFO', NULL, '2025-07-18 09:25:24');
INSERT INTO `sys_log` VALUES (300, NULL, '1', 'BookController', 'searchBooks', '[1,10,\"\"]', NULL, 'INFO', NULL, '2025-07-18 09:25:45');
INSERT INTO `sys_log` VALUES (301, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:25:50');
INSERT INTO `sys_log` VALUES (302, NULL, '1', 'UserController', 'searchUsers', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:26:14');
INSERT INTO `sys_log` VALUES (303, NULL, '1', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-18 09:26:25');
INSERT INTO `sys_log` VALUES (304, NULL, '1', 'UserController', 'searchUsers', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:26:55');
INSERT INTO `sys_log` VALUES (305, NULL, '1', 'UserController', 'searchUsers', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:27:09');
INSERT INTO `sys_log` VALUES (306, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:27:14');
INSERT INTO `sys_log` VALUES (307, NULL, '2', 'LendRecordController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 09:28:17');
INSERT INTO `sys_log` VALUES (308, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:34:07');
INSERT INTO `sys_log` VALUES (309, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:36:20');
INSERT INTO `sys_log` VALUES (310, NULL, '1', 'UserController', 'searchUsers', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:36:37');
INSERT INTO `sys_log` VALUES (311, NULL, '1', 'UserController', 'searchUsers', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:36:39');
INSERT INTO `sys_log` VALUES (312, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:36:51');
INSERT INTO `sys_log` VALUES (313, NULL, '2', 'LendRecordController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 09:48:08');
INSERT INTO `sys_log` VALUES (314, NULL, '2', 'LendRecordController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 09:53:52');
INSERT INTO `sys_log` VALUES (315, NULL, '2', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 09:53:53');
INSERT INTO `sys_log` VALUES (316, NULL, '2', 'LendRecordController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 09:53:55');
INSERT INTO `sys_log` VALUES (317, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:54:45');
INSERT INTO `sys_log` VALUES (318, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:56:44');
INSERT INTO `sys_log` VALUES (319, NULL, '1', 'LendRecordController', 'returned', '[9]', NULL, 'INFO', NULL, '2025-07-18 09:56:55');
INSERT INTO `sys_log` VALUES (320, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:56:55');
INSERT INTO `sys_log` VALUES (321, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:57:03');
INSERT INTO `sys_log` VALUES (322, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:57:04');
INSERT INTO `sys_log` VALUES (323, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:57:06');
INSERT INTO `sys_log` VALUES (324, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:57:09');
INSERT INTO `sys_log` VALUES (325, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:57:11');
INSERT INTO `sys_log` VALUES (326, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 09:57:25');
INSERT INTO `sys_log` VALUES (327, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 10:01:37');
INSERT INTO `sys_log` VALUES (328, NULL, '1', 'CommentServiceImpl', 'createComment', '[{\"bookId\":0,\"userId\":null,\"byPerson\":null,\"content\":\"123\",\"rating\":4}]', NULL, 'ERROR', 'NullPointerException: Cannot invoke \"com.example.demo.entity.Book.getBorrowCount()\" because \"book\" is null', '2025-07-18 10:02:05');
INSERT INTO `sys_log` VALUES (329, NULL, '1', 'BookCommentController', 'create', '[{\"bookId\":0,\"userId\":null,\"byPerson\":null,\"content\":\"123\",\"rating\":4}]', NULL, 'ERROR', 'NullPointerException: Cannot invoke \"com.example.demo.entity.Book.getBorrowCount()\" because \"book\" is null', '2025-07-18 10:02:05');
INSERT INTO `sys_log` VALUES (330, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 10:08:15');
INSERT INTO `sys_log` VALUES (331, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 10:22:29');
INSERT INTO `sys_log` VALUES (332, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 10:27:25');
INSERT INTO `sys_log` VALUES (333, NULL, '1', 'CommentServiceImpl', 'createComment', '[{\"bookId\":0,\"userId\":null,\"bookName\":null,\"userName\":null,\"byPerson\":null,\"content\":\"123\",\"rating\":5,\"operatorName\":null}]', NULL, 'ERROR', 'NullPointerException: Cannot invoke \"com.example.demo.entity.Book.getBorrowCount()\" because \"book\" is null', '2025-07-18 10:27:35');
INSERT INTO `sys_log` VALUES (334, NULL, '1', 'BookCommentController', 'create', '[{\"bookId\":0,\"userId\":null,\"bookName\":null,\"userName\":null,\"byPerson\":null,\"content\":\"123\",\"rating\":5,\"operatorName\":null}]', NULL, 'ERROR', 'NullPointerException: Cannot invoke \"com.example.demo.entity.Book.getBorrowCount()\" because \"book\" is null', '2025-07-18 10:27:35');
INSERT INTO `sys_log` VALUES (335, NULL, '1', 'LendRecordController', 'search', '[null,2,10]', NULL, 'INFO', NULL, '2025-07-18 10:29:38');
INSERT INTO `sys_log` VALUES (336, NULL, '1', 'LendRecordController', 'returned', '[1]', NULL, 'INFO', NULL, '2025-07-18 10:29:41');
INSERT INTO `sys_log` VALUES (337, NULL, '1', 'LendRecordController', 'search', '[null,2,10]', NULL, 'INFO', NULL, '2025-07-18 10:29:41');
INSERT INTO `sys_log` VALUES (338, NULL, '1', 'CommentServiceImpl', 'createComment', '[{\"bookId\":0,\"userId\":null,\"bookName\":null,\"userName\":null,\"byPerson\":null,\"content\":\"321\",\"rating\":5,\"operatorName\":null}]', NULL, 'ERROR', 'NullPointerException: Cannot invoke \"com.example.demo.entity.Book.getBorrowCount()\" because \"book\" is null', '2025-07-18 10:29:57');
INSERT INTO `sys_log` VALUES (339, NULL, '1', 'BookCommentController', 'create', '[{\"bookId\":0,\"userId\":null,\"bookName\":null,\"userName\":null,\"byPerson\":null,\"content\":\"321\",\"rating\":5,\"operatorName\":null}]', NULL, 'ERROR', 'NullPointerException: Cannot invoke \"com.example.demo.entity.Book.getBorrowCount()\" because \"book\" is null', '2025-07-18 10:29:57');
INSERT INTO `sys_log` VALUES (340, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 10:32:17');
INSERT INTO `sys_log` VALUES (341, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 10:33:33');
INSERT INTO `sys_log` VALUES (342, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 10:35:04');
INSERT INTO `sys_log` VALUES (343, NULL, '1', 'CommentServiceImpl', 'createComment', '[{\"bookId\":null,\"userId\":null,\"bookName\":\"人工智能导论\",\"userName\":\"jdoe\",\"byPerson\":null,\"content\":\"321\",\"rating\":4,\"operatorName\":null}]', NULL, 'ERROR', 'NullPointerException: Cannot invoke \"com.example.demo.entity.Book.getBorrowCount()\" because \"book\" is null', '2025-07-18 10:35:09');
INSERT INTO `sys_log` VALUES (344, NULL, '1', 'BookCommentController', 'create', '[{\"bookId\":null,\"userId\":null,\"bookName\":\"人工智能导论\",\"userName\":\"jdoe\",\"byPerson\":null,\"content\":\"321\",\"rating\":4,\"operatorName\":null}]', NULL, 'ERROR', 'NullPointerException: Cannot invoke \"com.example.demo.entity.Book.getBorrowCount()\" because \"book\" is null', '2025-07-18 10:35:09');
INSERT INTO `sys_log` VALUES (345, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 10:38:23');
INSERT INTO `sys_log` VALUES (346, NULL, '1', 'CommentServiceImpl', 'createComment', '[{\"bookId\":null,\"userId\":null,\"bookName\":\"人工智能导论\",\"userName\":\"jdoe\",\"byPerson\":null,\"content\":\"321\",\"rating\":2,\"operatorName\":null}]', NULL, 'INFO', NULL, '2025-07-18 10:38:29');
INSERT INTO `sys_log` VALUES (347, NULL, '1', 'BookCommentController', 'create', '[{\"bookId\":null,\"userId\":null,\"bookName\":\"人工智能导论\",\"userName\":\"jdoe\",\"byPerson\":null,\"content\":\"321\",\"rating\":2,\"operatorName\":null}]', NULL, 'INFO', NULL, '2025-07-18 10:38:29');
INSERT INTO `sys_log` VALUES (348, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 10:43:27');
INSERT INTO `sys_log` VALUES (349, NULL, '1', 'CommentServiceImpl', 'createComment', '[{\"bookId\":null,\"userId\":null,\"bookName\":\"人工智能导论\",\"userName\":\"jdoe\",\"byPerson\":null,\"content\":\"321\",\"rating\":2}]', NULL, 'INFO', NULL, '2025-07-18 10:43:32');
INSERT INTO `sys_log` VALUES (350, NULL, '1', 'BookCommentController', 'create', '[{\"bookId\":null,\"userId\":null,\"bookName\":\"人工智能导论\",\"userName\":\"jdoe\",\"byPerson\":null,\"content\":\"321\",\"rating\":2}]', NULL, 'INFO', NULL, '2025-07-18 10:43:32');
INSERT INTO `sys_log` VALUES (351, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:44:25');
INSERT INTO `sys_log` VALUES (352, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:46:48');
INSERT INTO `sys_log` VALUES (353, NULL, '1', 'BookCommentController', 'page', '[2,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:47:01');
INSERT INTO `sys_log` VALUES (354, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:47:03');
INSERT INTO `sys_log` VALUES (355, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:47:40');
INSERT INTO `sys_log` VALUES (356, NULL, '1', 'BookCommentController', 'page', '[2,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:47:48');
INSERT INTO `sys_log` VALUES (357, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:47:50');
INSERT INTO `sys_log` VALUES (358, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:49:36');
INSERT INTO `sys_log` VALUES (359, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:49:39');
INSERT INTO `sys_log` VALUES (360, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:49:39');
INSERT INTO `sys_log` VALUES (361, NULL, '1', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-18 10:49:45');
INSERT INTO `sys_log` VALUES (362, NULL, '1', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 10:49:45');
INSERT INTO `sys_log` VALUES (363, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:49:50');
INSERT INTO `sys_log` VALUES (364, NULL, '1', 'BookCommentController', 'page', '[2,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:49:52');
INSERT INTO `sys_log` VALUES (365, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:50:26');
INSERT INTO `sys_log` VALUES (366, NULL, '1', 'BookCommentController', 'page', '[2,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:50:28');
INSERT INTO `sys_log` VALUES (367, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:50:30');
INSERT INTO `sys_log` VALUES (368, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:52:16');
INSERT INTO `sys_log` VALUES (369, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:54:20');
INSERT INTO `sys_log` VALUES (370, NULL, '1', 'BookCommentController', 'page', '[2,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:54:43');
INSERT INTO `sys_log` VALUES (371, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:54:46');
INSERT INTO `sys_log` VALUES (372, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:55:31');
INSERT INTO `sys_log` VALUES (373, NULL, '1', 'BookCommentController', 'page', '[2,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:55:33');
INSERT INTO `sys_log` VALUES (374, NULL, '1', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-18 10:55:36');
INSERT INTO `sys_log` VALUES (375, NULL, '1', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 10:55:36');
INSERT INTO `sys_log` VALUES (376, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:55:40');
INSERT INTO `sys_log` VALUES (377, NULL, '1', 'BookCommentController', 'page', '[2,10,null]', NULL, 'INFO', NULL, '2025-07-18 10:55:42');
INSERT INTO `sys_log` VALUES (378, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 11:02:34');
INSERT INTO `sys_log` VALUES (379, NULL, '1', 'BookCommentController', 'page', '[2,10,null]', NULL, 'INFO', NULL, '2025-07-18 11:02:37');
INSERT INTO `sys_log` VALUES (380, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 11:02:38');
INSERT INTO `sys_log` VALUES (381, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 11:02:59');
INSERT INTO `sys_log` VALUES (382, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 11:04:00');
INSERT INTO `sys_log` VALUES (383, NULL, '1', 'UserController', 'currUser', '[]', NULL, 'INFO', NULL, '2025-07-18 13:17:53');
INSERT INTO `sys_log` VALUES (384, NULL, '1', 'BookRecommendationController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 13:17:53');
INSERT INTO `sys_log` VALUES (385, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 13:17:56');
INSERT INTO `sys_log` VALUES (386, NULL, '1', 'BookCommentController', 'deleteBatch', '[[14,13]]', NULL, 'INFO', NULL, '2025-07-18 13:18:15');
INSERT INTO `sys_log` VALUES (387, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 13:18:15');
INSERT INTO `sys_log` VALUES (388, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 13:18:18');
INSERT INTO `sys_log` VALUES (389, NULL, '1', 'BookRecommendationController', 'search', '[\"\",1,10]', NULL, 'INFO', NULL, '2025-07-18 13:18:25');
INSERT INTO `sys_log` VALUES (390, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 13:19:00');
INSERT INTO `sys_log` VALUES (391, NULL, '1', 'CommentServiceImpl', 'createComment', '[{\"bookId\":null,\"userId\":null,\"bookName\":\"人类简史\",\"userName\":\"irfan\",\"byPerson\":null,\"content\":\"321\",\"rating\":4}]', NULL, 'ERROR', 'NullPointerException: Cannot invoke \"com.example.demo.entity.Book.getId()\" because \"book\" is null', '2025-07-18 13:19:13');
INSERT INTO `sys_log` VALUES (392, NULL, '1', 'BookCommentController', 'create', '[{\"bookId\":null,\"userId\":null,\"bookName\":\"人类简史\",\"userName\":\"irfan\",\"byPerson\":null,\"content\":\"321\",\"rating\":4}]', NULL, 'ERROR', 'NullPointerException: Cannot invoke \"com.example.demo.entity.Book.getId()\" because \"book\" is null', '2025-07-18 13:19:13');
INSERT INTO `sys_log` VALUES (393, NULL, '1', 'CommentServiceImpl', 'createComment', '[{\"bookId\":null,\"userId\":null,\"bookName\":\"人类简史\",\"userName\":\"irfan\",\"byPerson\":null,\"content\":\"321\",\"rating\":4}]', NULL, 'ERROR', 'NullPointerException: Cannot invoke \"com.example.demo.entity.Book.getId()\" because \"book\" is null', '2025-07-18 13:19:45');
INSERT INTO `sys_log` VALUES (394, NULL, '1', 'BookCommentController', 'create', '[{\"bookId\":null,\"userId\":null,\"bookName\":\"人类简史\",\"userName\":\"irfan\",\"byPerson\":null,\"content\":\"321\",\"rating\":4}]', NULL, 'ERROR', 'NullPointerException: Cannot invoke \"com.example.demo.entity.Book.getId()\" because \"book\" is null', '2025-07-18 13:19:45');
INSERT INTO `sys_log` VALUES (395, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 13:19:48');
INSERT INTO `sys_log` VALUES (396, NULL, '1', 'CommentServiceImpl', 'createComment', '[{\"bookId\":null,\"userId\":null,\"bookName\":\"时间简史\",\"userName\":\"irfan\",\"byPerson\":null,\"content\":\"321\",\"rating\":2}]', NULL, 'INFO', NULL, '2025-07-18 13:19:54');
INSERT INTO `sys_log` VALUES (397, NULL, '1', 'BookCommentController', 'create', '[{\"bookId\":null,\"userId\":null,\"bookName\":\"时间简史\",\"userName\":\"irfan\",\"byPerson\":null,\"content\":\"321\",\"rating\":2}]', NULL, 'INFO', NULL, '2025-07-18 13:19:54');
INSERT INTO `sys_log` VALUES (398, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 13:19:59');
INSERT INTO `sys_log` VALUES (399, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 13:20:38');
INSERT INTO `sys_log` VALUES (400, NULL, '1', 'CommentServiceImpl', 'createComment', '[{\"bookId\":null,\"userId\":null,\"bookName\":\"人类简史\",\"userName\":\"irfan\",\"byPerson\":null,\"content\":\"321\",\"rating\":3}]', NULL, 'ERROR', 'NullPointerException: Cannot invoke \"com.example.demo.entity.Book.getId()\" because \"book\" is null', '2025-07-18 13:20:45');
INSERT INTO `sys_log` VALUES (401, NULL, '1', 'BookCommentController', 'create', '[{\"bookId\":null,\"userId\":null,\"bookName\":\"人类简史\",\"userName\":\"irfan\",\"byPerson\":null,\"content\":\"321\",\"rating\":3}]', NULL, 'ERROR', 'NullPointerException: Cannot invoke \"com.example.demo.entity.Book.getId()\" because \"book\" is null', '2025-07-18 13:20:45');
INSERT INTO `sys_log` VALUES (402, NULL, '1', 'CommentServiceImpl', 'createComment', '[{\"bookId\":null,\"userId\":null,\"bookName\":\"人类简史\",\"userName\":\"irfan\",\"byPerson\":null,\"content\":\"321\",\"rating\":3}]', NULL, 'ERROR', 'NullPointerException: Cannot invoke \"com.example.demo.entity.Book.getId()\" because \"book\" is null', '2025-07-18 13:21:46');
INSERT INTO `sys_log` VALUES (403, NULL, '1', 'BookCommentController', 'create', '[{\"bookId\":null,\"userId\":null,\"bookName\":\"人类简史\",\"userName\":\"irfan\",\"byPerson\":null,\"content\":\"321\",\"rating\":3}]', NULL, 'ERROR', 'NullPointerException: Cannot invoke \"com.example.demo.entity.Book.getId()\" because \"book\" is null', '2025-07-18 13:21:46');
INSERT INTO `sys_log` VALUES (404, NULL, '1', 'CommentServiceImpl', 'createComment', '[{\"bookId\":null,\"userId\":null,\"bookName\":\"人类简史\",\"userName\":\"irfan\",\"byPerson\":null,\"content\":\"321\",\"rating\":3}]', NULL, 'ERROR', 'NullPointerException: Cannot invoke \"com.example.demo.entity.Book.getId()\" because \"book\" is null', '2025-07-18 13:21:51');
INSERT INTO `sys_log` VALUES (405, NULL, '1', 'BookCommentController', 'create', '[{\"bookId\":null,\"userId\":null,\"bookName\":\"人类简史\",\"userName\":\"irfan\",\"byPerson\":null,\"content\":\"321\",\"rating\":3}]', NULL, 'ERROR', 'NullPointerException: Cannot invoke \"com.example.demo.entity.Book.getId()\" because \"book\" is null', '2025-07-18 13:21:51');
INSERT INTO `sys_log` VALUES (406, NULL, '1', 'LendRecordController', 'search', '[null,1,10]', NULL, 'INFO', NULL, '2025-07-18 13:21:52');
INSERT INTO `sys_log` VALUES (407, NULL, '1', 'CommentServiceImpl', 'createComment', '[{\"bookId\":null,\"userId\":null,\"bookName\":\"人工智能导论\",\"userName\":\"jdoe\",\"byPerson\":null,\"content\":\"321\",\"rating\":2}]', NULL, 'INFO', NULL, '2025-07-18 13:21:58');
INSERT INTO `sys_log` VALUES (408, NULL, '1', 'BookCommentController', 'create', '[{\"bookId\":null,\"userId\":null,\"bookName\":\"人工智能导论\",\"userName\":\"jdoe\",\"byPerson\":null,\"content\":\"321\",\"rating\":2}]', NULL, 'INFO', NULL, '2025-07-18 13:21:58');
INSERT INTO `sys_log` VALUES (409, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 13:22:01');
INSERT INTO `sys_log` VALUES (410, NULL, '1', 'BookCommentController', 'deleteBatch', '[[16,15]]', NULL, 'INFO', NULL, '2025-07-18 13:22:05');
INSERT INTO `sys_log` VALUES (411, NULL, '1', 'BookCommentController', 'page', '[1,10,null]', NULL, 'INFO', NULL, '2025-07-18 13:22:05');

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
INSERT INTO `system_stats` VALUES (1, '2025-01-01', 148, 3, 5, 9, 9, 1, '2025-07-16 17:14:21', '2025-07-16 17:14:21');
INSERT INTO `system_stats` VALUES (2, '2025-01-06', 120, 6, 3, 13, 3, 4, '2025-07-16 17:14:21', '2025-07-16 17:14:21');
INSERT INTO `system_stats` VALUES (3, '2025-01-11', 235, 4, 5, 20, 7, 7, '2025-07-16 17:14:21', '2025-07-16 17:14:21');
INSERT INTO `system_stats` VALUES (4, '2025-01-16', 187, 7, 3, 15, 11, 8, '2025-07-16 17:14:21', '2025-07-16 17:14:21');
INSERT INTO `system_stats` VALUES (5, '2025-01-21', 146, 7, 3, 11, 6, 6, '2025-07-16 17:14:21', '2025-07-16 17:14:21');
INSERT INTO `system_stats` VALUES (6, '2025-01-26', 109, 6, 1, 15, 14, 7, '2025-07-16 17:14:21', '2025-07-16 17:14:21');
INSERT INTO `system_stats` VALUES (7, '2025-01-31', 230, 6, 4, 9, 6, 0, '2025-07-16 17:14:21', '2025-07-16 17:14:21');
INSERT INTO `system_stats` VALUES (8, '2025-02-05', 82, 8, 5, 15, 4, 7, '2025-07-16 17:14:21', '2025-07-16 17:14:21');
INSERT INTO `system_stats` VALUES (9, '2025-02-10', 75, 8, 4, 5, 5, 2, '2025-07-16 17:14:21', '2025-07-16 17:14:21');
INSERT INTO `system_stats` VALUES (10, '2025-02-15', 154, 10, 2, 7, 6, 4, '2025-07-16 17:14:21', '2025-07-16 17:14:21');
INSERT INTO `system_stats` VALUES (11, '2025-02-20', 136, 9, 4, 7, 5, 8, '2025-07-16 17:14:21', '2025-07-16 17:14:21');
INSERT INTO `system_stats` VALUES (12, '2025-02-25', 147, 5, 4, 6, 3, 3, '2025-07-16 17:14:21', '2025-07-16 17:14:21');

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
INSERT INTO `user` VALUES (2, 'jdoe', 'John Doe', 'e10adc3949ba59abbe56e057f20f883e', '女', '文学部', '13800000002', 2, '2024-02-15 10:30:00', '2025-07-16 17:41:24', 1);
INSERT INTO `user` VALUES (3, 'lwang', 'Li Wang', 'e10adc3949ba59abbe56e057f20f883e', '女', '科技部', '13800000003', 2, '2025-07-14 14:20:00', '2025-07-16 18:01:49', 1);
INSERT INTO `user` VALUES (4, 'hsim', 'Han Sim', 'e10adc3949ba59abbe56e057f20f883e', '男', '历史系', '13800000004', 2, '2025-07-14 08:45:00', '2025-07-16 18:01:54', 1);
INSERT INTO `user` VALUES (5, 'nana', 'Nana', 'e10adc3949ba59abbe56e057f20f883e', '女', '图书部', '13800000005', 2, '2024-05-05 11:15:00', '2025-07-16 17:28:49', 1);
INSERT INTO `user` VALUES (6, 'irfan', 'Irfan Maulana', 'e10adc3949ba59abbe56e057f20f883e', '男', '东南亚分部', '13800000006', 2, '2024-06-10 13:00:00', '2025-07-16 17:28:50', 1);
INSERT INTO `user` VALUES (7, 'alisa', 'Alisa Zhang', 'e10adc3949ba59abbe56e057f20f883e', '女', '信息技术部', '13800000007', 2, '2024-07-02 10:00:00', '2025-07-16 17:28:50', 1);
INSERT INTO `user` VALUES (8, 'andrew', 'Andrew Lee', 'e10adc3949ba59abbe56e057f20f883e', '男', '项目部', '13800000008', 2, '2024-07-15 16:00:00', '2025-07-16 17:28:51', 1);
INSERT INTO `user` VALUES (9, 'anita', 'Anita Dewi', 'e10adc3949ba59abbe56e057f20f883e', '女', '数据分析部', '13800000009', 2, '2024-08-01 09:00:00', '2025-07-16 17:28:52', 1);
INSERT INTO `user` VALUES (10, 'farid', 'Farid Hasyim', 'e10adc3949ba59abbe56e057f20f883e', '男', '印尼雅加达办事处', '13800000010', 2, '2024-08-12 10:00:00', '2025-07-16 17:28:53', 1);
INSERT INTO `user` VALUES (11, 'clara', 'Clara Tang', 'e10adc3949ba59abbe56e057f20f883e', '女', '研究中心', '13800000011', 2, '2024-09-01 09:30:00', '2025-07-16 17:28:54', 1);
INSERT INTO `user` VALUES (12, 'tony', 'Tony Shi', 'e10adc3949ba59abbe56e057f20f883e', '男', '后勤部', '13800000012', 2, '2024-10-10 14:00:00', '2025-07-16 17:28:55', 1);

SET FOREIGN_KEY_CHECKS = 1;
