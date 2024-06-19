DROP TABLE IF EXISTS `check_info`;
CREATE TABLE `check_info`
(
    `id`              int          NOT NULL AUTO_INCREMENT,
    `invoice_check`   int          not null default 0 comment '发票检测：1-检测完成 0-未检测',
    `bill_check`      int          not null default 0 comment '提货单检测：1-检测完成 0-未检测',
    `guarantee_check` int          not null default 0 comment '保修证书检测：1-检测完成 0-未检测',
    `check_user_id`   varchar(255) not null default '' comment '检测人id',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;


/*
 Navicat Premium Data Transfer

 Source Server         : my
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : warehouse_test

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 06/06/2024 11:15:17
*/

SET NAMES utf8mb4;
SET
    FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`
(
    `employee_id` int                                                     NOT NULL AUTO_INCREMENT,
    `name`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `password`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `role`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`employee_id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 5
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee`
VALUES (3, 'zhaoyu', '123456', '员工');

-- ----------------------------
-- Table structure for incoming_cargo
-- ----------------------------
DROP TABLE IF EXISTS `incoming_cargo`;
CREATE TABLE `incoming_cargo`
(
    `incoming_cargo_id` int                                                     NOT NULL AUTO_INCREMENT,
    `incoming_task_id`  int                                                     NULL DEFAULT NULL,
    `product_id`        int                                                     NULL DEFAULT NULL,
    `quantity`          varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `production_time`   date                                                    NULL DEFAULT NULL,
    PRIMARY KEY (`incoming_cargo_id`) USING BTREE,
    INDEX `FK74dtvp2vpu8tbrgneils7rjng` (`incoming_task_id`) USING BTREE,
    INDEX `FKgkk2s8p84chelaqrot052kawm` (`product_id`) USING BTREE,
    CONSTRAINT `FK74dtvp2vpu8tbrgneils7rjng` FOREIGN KEY (`incoming_task_id`) REFERENCES `incoming_task` (`incoming_task_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `FKgkk2s8p84chelaqrot052kawm` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of incoming_cargo
-- ----------------------------

-- ----------------------------
-- Table structure for incoming_task
-- ----------------------------
DROP TABLE IF EXISTS `incoming_task`;
CREATE TABLE `incoming_task`
(
    `incoming_task_id` int                                                     NOT NULL AUTO_INCREMENT,
    `status`           varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `created_time`     datetime                                                NULL DEFAULT NULL,
    `updated_time`     datetime                                                NULL DEFAULT NULL,
    PRIMARY KEY (`incoming_task_id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of incoming_task
-- ----------------------------
INSERT INTO `incoming_task`
VALUES (3, 'Pending', '2024-06-01 13:32:11', '2024-06-01 13:32:11');
INSERT INTO `incoming_task`
VALUES (4, 'Pending', '2024-06-01 13:33:04', '2024-06-01 13:33:04');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`
(
    `orders_id`    int                                                     NOT NULL AUTO_INCREMENT,
    `customer_id`  int                                                     NULL DEFAULT NULL,
    `status`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `created_time` datetime                                                NULL DEFAULT NULL,
    `update_time`  datetime                                                NULL DEFAULT NULL,
    PRIMARY KEY (`orders_id`) USING BTREE,
    INDEX `FKd5k63q3v5hb1hi6hlhqysepph` (`customer_id`) USING BTREE,
    CONSTRAINT `FKd5k63q3v5hb1hi6hlhqysepph` FOREIGN KEY (`customer_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  AUTO_INCREMENT = 3
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders`
VALUES (1, 1, 'Cancelled', '2024-05-29 09:02:58', '2024-06-01 13:40:24');
INSERT INTO `orders`
VALUES (2, 2, 'Cancelled', '2024-06-01 13:39:11', '2024-06-01 13:40:41');
INSERT INTO `orders`
VALUES (3, 2, 'Pending', '2024-06-01 13:39:31', '2024-06-01 13:39:31');

-- ----------------------------
-- Table structure for orders_exception
-- ----------------------------
DROP TABLE IF EXISTS `orders_exception`;
CREATE TABLE `orders_exception`
(
    `orders_exception_id` int                                                     NOT NULL AUTO_INCREMENT,
    `orders_id`           int                                                     NULL DEFAULT NULL,
    `desc`                varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `created_time`        datetime                                                NULL DEFAULT NULL,
    PRIMARY KEY (`orders_exception_id`) USING BTREE,
    INDEX `FK7ijdcxx6n31c1q1k22phwuri7` (`orders_id`) USING BTREE,
    CONSTRAINT `FK7ijdcxx6n31c1q1k22phwuri7` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`orders_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders_exception
-- ----------------------------
INSERT INTO `orders_exception`
VALUES (3, 1, '123', '2024-05-29 09:45:03');
INSERT INTO `orders_exception`
VALUES (4, 2, '\"hhhhhhhh\"', '2024-06-01 14:00:11');

-- ----------------------------
-- Table structure for orders_item
-- ----------------------------
DROP TABLE IF EXISTS `orders_item`;
CREATE TABLE `orders_item`
(
    `orders_item_id` int                                                     NOT NULL AUTO_INCREMENT,
    `orders_id`      int                                                     NULL DEFAULT NULL,
    `product_id`     int                                                     NULL DEFAULT NULL,
    `quantity`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`orders_item_id`) USING BTREE,
    INDEX `FKlrqyo8q92lfie02g03gp8l89x` (`product_id`) USING BTREE,
    INDEX `FKk58cvrmhry3ibomsp6204wjw` (`orders_id`) USING BTREE,
    CONSTRAINT `FKk58cvrmhry3ibomsp6204wjw` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`orders_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  AUTO_INCREMENT = 5
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders_item
-- ----------------------------
INSERT INTO `orders_item`
VALUES (2, 1, 2, '5');
INSERT INTO `orders_item`
VALUES (3, 1, 1, '10');

-- ----------------------------
-- Table structure for outbound_cargo
-- ----------------------------
DROP TABLE IF EXISTS `outbound_cargo`;
CREATE TABLE `outbound_cargo`
(
    `outbound_cargo_id` int                                                     NOT NULL AUTO_INCREMENT,
    `outbound_task_id`  int                                                     NULL DEFAULT NULL,
    `incoming_cargo_id` int                                                     NULL DEFAULT NULL,
    `quantity`          varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`outbound_cargo_id`) USING BTREE,
    INDEX `FKa8bsl30eef152q69s2j4ncvpo` (`incoming_cargo_id`) USING BTREE,
    INDEX `FKetlius0qkn2k7a32sesblvnpw` (`outbound_task_id`) USING BTREE,
    CONSTRAINT `FKa8bsl30eef152q69s2j4ncvpo` FOREIGN KEY (`incoming_cargo_id`) REFERENCES `incoming_cargo` (`incoming_cargo_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `FKetlius0qkn2k7a32sesblvnpw` FOREIGN KEY (`outbound_task_id`) REFERENCES `outbound_task` (`outbound_task_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of outbound_cargo
-- ----------------------------

-- ----------------------------
-- Table structure for outbound_task
-- ----------------------------
DROP TABLE IF EXISTS `outbound_task`;
CREATE TABLE `outbound_task`
(
    `outbound_task_id` int                                                     NOT NULL AUTO_INCREMENT,
    `orders_id`        int                                                     NULL DEFAULT NULL,
    `status`           varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `created_time`     datetime                                                NULL DEFAULT NULL,
    `update_time`      datetime                                                NULL DEFAULT NULL,
    PRIMARY KEY (`outbound_task_id`) USING BTREE,
    INDEX `FK4pc8yac6wbrt9q9sc1i0bt3lj` (`orders_id`) USING BTREE,
    CONSTRAINT `FK4pc8yac6wbrt9q9sc1i0bt3lj` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`orders_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  AUTO_INCREMENT = 2
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of outbound_task
-- ----------------------------
INSERT INTO `outbound_task`
VALUES (1, 1, 'Pendding', '2024-05-29 10:36:00', '2024-05-29 10:36:44');
INSERT INTO `outbound_task`
VALUES (2, 2, 'Finish', '2024-06-01 14:12:46', '2024-06-01 14:13:18');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`
(
    `product_id`      int                                                     NOT NULL AUTO_INCREMENT,
    `name`            varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `desc`            varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `price`           decimal(10, 2)                                          NULL DEFAULT NULL,
    `production_time` datetime                                                NULL DEFAULT NULL,
    PRIMARY KEY (`product_id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 5
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product`
VALUES (2, '电脑', '笔记本电脑', 12999.00, '2024-05-29 08:56:30');
INSERT INTO `product`
VALUES (3, '冰箱', '格力冰箱', 20000.00, NULL);
INSERT INTO `product`
VALUES (4, '冰箱', '格力冰箱', 20000.00, NULL);

-- ----------------------------
-- Table structure for repertory
-- ----------------------------
DROP TABLE IF EXISTS `repertory`;
CREATE TABLE `repertory`
(
    `repertory_id` int                                                     NOT NULL AUTO_INCREMENT,
    `product_id`   int                                                     NULL DEFAULT NULL,
    `quantity`     varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `update_time`  datetime                                                NOT NULL,
    PRIMARY KEY (`repertory_id`) USING BTREE,
    INDEX `FK1gju02yymug1l4vpjkho5p3ao` (`product_id`) USING BTREE,
    CONSTRAINT `FK1gju02yymug1l4vpjkho5p3ao` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of repertory
-- ----------------------------
INSERT INTO `repertory`
VALUES (1, 3, '6', '2024-05-29 08:58:04');
INSERT INTO `repertory`
VALUES (2, 2, '116', '2024-06-01 14:56:26');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`
(
    `user_id`  int                                                     NOT NULL AUTO_INCREMENT,
    `name`     varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `email`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `phone`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `address`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user`
VALUES (1, 'test1', '123456', '123456@qq.com', NULL, NULL);
INSERT INTO `user`
VALUES (2, 'tes2', '78910', '78910@qq.com', NULL, NULL);
INSERT INTO `user`
VALUES (3, 'test3', '147258', '147258@qq.com', NULL, NULL);
INSERT INTO `user`
VALUES (52, 'Uzi', '241760', 'Uzi@qq.com', '12546521251', '上海市');
INSERT INTO `user`
VALUES (102, 'Jacklove', '241760', 'Jacklove@qq.com', NULL, NULL);
INSERT INTO `user`
VALUES (152, '123', '123', '123@qq.com', NULL, NULL);
INSERT INTO `user`
VALUES (203, '1231', '123', '123@qq.com', NULL, NULL);

-- ----------------------------
-- Table structure for user_seq
-- ----------------------------
DROP TABLE IF EXISTS `user_seq`;
CREATE TABLE `user_seq`
(
    `next_val` bigint NULL DEFAULT NULL
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_seq
-- ----------------------------
INSERT INTO `user_seq`
VALUES (301);

SET
    FOREIGN_KEY_CHECKS = 1;
