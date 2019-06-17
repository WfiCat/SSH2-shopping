/*
Navicat MySQL Data Transfer

Source Server         : 本地mysql
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : emall

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2019-06-17 10:07:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_bigtype
-- ----------------------------
DROP TABLE IF EXISTS `t_bigtype`;
CREATE TABLE `t_bigtype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '产品大类',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_bigtype
-- ----------------------------
INSERT INTO `t_bigtype` VALUES ('1', '手机', '手机大类');
INSERT INTO `t_bigtype` VALUES ('2', '电脑', '电脑大类');

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cost` float NOT NULL COMMENT '总价',
  `createTime` datetime DEFAULT NULL,
  `orderNo` varchar(255) DEFAULT NULL COMMENT '订单好',
  `status` int(11) NOT NULL COMMENT '订单状态\r\n1待审核\r\n2审核通过\r\n3卖家已发货\r\n4交易已完成',
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_kh19wisaki6acmrs36vcmboj3` (`userId`) USING BTREE,
  CONSTRAINT `t_order_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES ('2', '7700', '2019-06-13 19:19:36', '20190613071936', '1', '1');
INSERT INTO `t_order` VALUES ('3', '10000', '2019-06-14 19:57:04', '20190614075704', '1', '6');
INSERT INTO `t_order` VALUES ('6', '6000', '2019-06-16 21:31:27', '20190616093127', '1', '1');
INSERT INTO `t_order` VALUES ('8', '13455', '2019-06-17 08:05:49', '20190617080549', '1', '8');

-- ----------------------------
-- Table structure for t_order_product
-- ----------------------------
DROP TABLE IF EXISTS `t_order_product`;
CREATE TABLE `t_order_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num` int(11) NOT NULL,
  `orderId` int(11) DEFAULT NULL,
  `productId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_323px8t5nllt9l3v8rof6yxjj` (`orderId`) USING BTREE,
  KEY `FK_kwtg2jr0df9hmph9fkodtp4oe` (`productId`) USING BTREE,
  CONSTRAINT `t_order_product_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `t_order` (`id`),
  CONSTRAINT `t_order_product_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `t_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_order_product
-- ----------------------------
INSERT INTO `t_order_product` VALUES ('1', '1', null, null);
INSERT INTO `t_order_product` VALUES ('2', '1', '2', '27');
INSERT INTO `t_order_product` VALUES ('3', '2', '3', '6');
INSERT INTO `t_order_product` VALUES ('4', '1', null, '15');
INSERT INTO `t_order_product` VALUES ('5', '2', null, null);
INSERT INTO `t_order_product` VALUES ('6', '1', '6', '10');
INSERT INTO `t_order_product` VALUES ('7', '4', null, '10');
INSERT INTO `t_order_product` VALUES ('8', '2', '8', null);
INSERT INTO `t_order_product` VALUES ('9', '1', '8', null);

-- ----------------------------
-- Table structure for t_product
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL COMMENT '产品描述信息',
  `name` varchar(255) DEFAULT NULL,
  `price` int(11) NOT NULL,
  `proPic` varchar(255) NOT NULL COMMENT '产品图片',
  `stock` int(11) NOT NULL COMMENT '库存量',
  `smallTypeId` int(11) DEFAULT NULL,
  `bigTypeId` int(11) DEFAULT NULL,
  `hot` int(11) NOT NULL DEFAULT '0' COMMENT '热卖',
  `hotTime` datetime DEFAULT NULL,
  `specialPrice` int(11) NOT NULL DEFAULT '0' COMMENT '是否特价',
  `specialPriceTime` datetime DEFAULT NULL,
  `lowPrice` int(11) NOT NULL DEFAULT '0',
  `topPrice` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_qexns4el8esjqbdrqfys82ih8` (`smallTypeId`) USING BTREE,
  KEY `FK_2vciohqujaeij91ujm5va2xs4` (`bigTypeId`) USING BTREE,
  CONSTRAINT `t_product_ibfk_1` FOREIGN KEY (`smallTypeId`) REFERENCES `t_smalltype` (`id`),
  CONSTRAINT `t_product_ibfk_2` FOREIGN KEY (`bigTypeId`) REFERENCES `t_bigtype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_product
-- ----------------------------
INSERT INTO `t_product` VALUES ('2', 'HUAWEI P20 Pro 全面屏徕卡三摄游戏手机 6GB+128GB 亮黑色 全网通移动联通电信4G手机 双卡双待', '华为 1', '3000', 'images/product/2.jpg', '90', '2', '1', '1', '2019-06-13 00:00:00', '1', '2019-06-13 00:00:00', '0', '0');
INSERT INTO `t_product` VALUES ('3', 'HUAWEI P20 Pro 全面屏徕卡三摄游戏手机 6GB+128GB 亮黑色 全网通移动联通电信4G手机 双卡双待', '华为 2', '6000', 'images/product/3.jpg', '45', '2', '1', '1', '2019-06-13 15:02:39', '0', null, '0', '0');
INSERT INTO `t_product` VALUES ('4', 'HUAWEI P20 Pro 全面屏徕卡三摄游戏手机 6GB+128GB 亮黑色 全网通移动联通电信4G手机 双卡双待', '华为3', '5999', 'images/product/4.jpg', '34', '2', '1', '1', '2019-06-13 15:02:39', '0', null, '0', '0');
INSERT INTO `t_product` VALUES ('5', 'HUAWEI P20 Pro 全面屏徕卡三摄游戏手机 6GB+128GB 亮黑色 全网通移动联通电信4G手机 双卡双待', '华为 HUAWEI P20 Pro', '6000', 'images/product/5.jpg', '34', '2', '1', '1', '2019-06-13 15:02:39', '1', '2019-06-13 15:03:02', '0', '0');
INSERT INTO `t_product` VALUES ('6', 'HUAWEI P20 Pro 全面屏徕卡三摄游戏手机 6GB+128GB 亮黑色 全网通移动联通电信4G手机 双卡双待', '华为 HUAWEI P20 Pro', '5089', 'images/product/6.jpg', '45', '2', '1', '1', '2019-06-13 15:02:39', '1', '2019-06-13 15:17:27', '0', '0');
INSERT INTO `t_product` VALUES ('7', 'HUAWEI P20 Pro 全面屏徕卡三摄游戏手机 6GB+128GB 亮黑色 全网通移动联通电信4G手机 双卡双待', '华为 HUAWEI P20 Pro', '5789', 'images/product/7.jpg', '90', '2', '1', '1', '2019-06-13 15:02:39', '0', null, '0', '0');
INSERT INTO `t_product` VALUES ('8', 'HUAWEI P20 Pro 全面屏徕卡三摄游戏手机 6GB+128GB 亮黑色 全网通移动联通电信4G手机 双卡双待', '华为 HUAWEI P30 Pro', '6000', 'images/product/8.jpg', '45', '2', '1', '1', '2019-06-13 15:02:39', '1', '2019-06-13 15:17:27', '0', '0');
INSERT INTO `t_product` VALUES ('9', 'HUAWEI P20 Pro 全面屏徕卡三摄游戏手机 6GB+128GB 亮黑色 全网通移动联通电信4G手机 双卡双待', '华为 HUAWEI P20 Pro', '5999', 'images/product/9.jpg', '34', '2', '1', '1', '2019-06-13 15:02:39', '1', '2019-06-13 15:17:27', '0', '0');
INSERT INTO `t_product` VALUES ('10', 'HUAWEI P20 Pro 全面屏徕卡三摄游戏手机 6GB+128GB 亮黑色 全网通移动联通电信4G手机 双卡双待', '华为 HUAWEI P20 Pro', '6000', 'images/product/10.jpg', '34', '2', '1', '1', '2019-06-13 15:02:39', '1', '2019-06-13 15:17:27', '0', '0');
INSERT INTO `t_product` VALUES ('11', '小米为发烧而生', '小米1', '400', 'images/product/31.jpg', '45', '1', '1', '0', null, '0', null, '0', '0');
INSERT INTO `t_product` VALUES ('12', '小米为发烧而生', '小米2', '4050', 'images/product/32.jpg', '45', '1', '1', '1', '2019-06-13 15:02:56', '0', null, '0', '0');
INSERT INTO `t_product` VALUES ('13', '小米为发烧而生', '小米3', '4600', 'images/product/33.jpg', '45', '1', '1', '1', '2019-06-13 15:02:56', '0', null, '0', '0');
INSERT INTO `t_product` VALUES ('14', '小米为发烧而生', '小米4', '4600', 'images/product/34.jpg', '45', '1', '1', '1', '2019-06-13 15:02:56', '0', null, '0', '0');
INSERT INTO `t_product` VALUES ('15', '小米为发烧而生', '小米5', '4060', 'images/product/35.jpg', '45', '1', '1', '1', '2019-06-13 15:02:56', '0', null, '0', '0');
INSERT INTO `t_product` VALUES ('16', '小米为发烧而生', '小米6', '4060', 'images/product/36.jpg', '45', '1', '1', '1', '2019-06-13 15:02:56', '0', null, '0', '0');
INSERT INTO `t_product` VALUES ('17', '小米为发烧而生', '小米7', '4060', 'images/product/37.jpg', '45', '1', '1', '0', null, '0', null, '0', '0');
INSERT INTO `t_product` VALUES ('18', '小米为发烧而生', '小米8', '4050', 'images/product/38.jpg', '45', '1', '1', '0', null, '0', null, '0', '0');
INSERT INTO `t_product` VALUES ('19', '小米为发烧而生', '小米9', '4060', 'images/product/39.jpg', '45', '1', '1', '0', null, '0', null, '0', '0');
INSERT INTO `t_product` VALUES ('20', '小米为发烧而生', '小米1', '4050', 'images/product/40.jpg', '45', '1', '1', '0', null, '0', null, '0', '0');
INSERT INTO `t_product` VALUES ('21', '·Apple Macbook Pro 13.3【带触控栏】Core i5 8G 256G SSD 银色 苹果笔记本电脑 轻薄本 MR9U2CH/A', '苹果', '7700', 'images/product/21.jpg', '45', '4', '2', '0', null, '0', null, '0', '0');
INSERT INTO `t_product` VALUES ('22', '·Apple Macbook Pro 13.3【带触控栏】Core i5 8G 256G SSD 银色 苹果笔记本电脑 轻薄本 MR9U2CH/A', '苹果', '7700', 'images/product/22.jpg', '45', '4', '2', '0', null, '0', null, '0', '0');
INSERT INTO `t_product` VALUES ('23', '·Apple Macbook Pro 13.3【带触控栏】Core i5 8G 256G SSD 银色 苹果笔记本电脑 轻薄本 MR9U2CH/A', '苹果', '7700', 'images/product/23.jpg', '45', '4', '2', '0', null, '0', null, '0', '0');
INSERT INTO `t_product` VALUES ('24', '·Apple Macbook Pro 13.3【带触控栏】Core i5 8G 256G SSD 银色 苹果笔记本电脑 轻薄本 MR9U2CH/A', '苹果', '7700', 'images/product/24.jpg', '45', '4', '2', '0', null, '1', '2019-06-13 15:17:27', '0', '0');
INSERT INTO `t_product` VALUES ('25', '·Apple Macbook Pro 13.3【带触控栏】Core i5 8G 256G SSD 银色 苹果笔记本电脑 轻薄本 MR9U2CH/A', '苹果', '7700', 'images/product/25.jpg', '45', '4', '2', '0', null, '1', '2019-06-13 15:17:27', '0', '0');
INSERT INTO `t_product` VALUES ('26', '·Apple Macbook Pro 13.3【带触控栏】Core i5 8G 256G SSD 银色 苹果笔记本电脑 轻薄本 MR9U2CH/A', '苹果', '7700', 'images/product/26.jpg', '45', '4', '2', '0', null, '1', '2019-06-13 15:17:27', '0', '0');
INSERT INTO `t_product` VALUES ('27', '·Apple Macbook Pro 13.3【带触控栏】Core i5 8G 256G SSD 银色 苹果笔记本电脑 轻薄本 MR9U2CH/A', '苹果', '7700', 'images/product/27.jpg', '45', '4', '2', '0', null, '1', '2019-06-13 15:17:27', '0', '0');
INSERT INTO `t_product` VALUES ('28', '·Apple Macbook Pro 13.3【带触控栏】Core i5 8G 256G SSD 银色 苹果笔记本电脑 轻薄本 MR9U2CH/A', '苹果', '7700', 'images/product/28.jpg', '45', '4', '2', '0', null, '1', '2019-06-13 15:17:27', '0', '0');
INSERT INTO `t_product` VALUES ('29', '·Apple Macbook Pro 13.3【带触控栏】Core i5 8G 256G SSD 银色 苹果笔记本电脑 轻薄本 MR9U2CH/A', '苹果', '7700', 'images/product/29.jpg', '45', '4', '2', '0', null, '1', '2019-06-13 15:17:27', '0', '0');
INSERT INTO `t_product` VALUES ('30', '·Apple Macbook Pro 13.3【带触控栏】Core i5 8G 256G SSD 银色 苹果笔记本电脑 轻薄本 MR9U2CH/A', '苹果', '7700', 'images/product/30.jpg', '45', '4', '2', '0', null, '1', '2019-06-13 15:17:27', '0', '0');
INSERT INTO `t_product` VALUES ('31', 'HP/惠普 暗影 光影', '惠普', '4000', 'images/product/11.jpg', '45', '3', '2', '0', null, '1', '2019-06-13 15:17:27', '0', '0');
INSERT INTO `t_product` VALUES ('32', 'HP/惠普 暗影 光影', '惠普', '4000', 'images/product/12.jpg', '45', '3', '2', '1', '2019-06-13 15:02:05', '0', null, '0', '0');
INSERT INTO `t_product` VALUES ('33', 'HP/惠普 暗影 光影', '惠普', '4000', 'images/product/13.jpg', '45', '3', '2', '1', '2019-06-13 15:02:05', '1', '2019-06-13 15:02:12', '0', '0');
INSERT INTO `t_product` VALUES ('34', 'HP/惠普 暗影 光影', '惠普', '4000', 'images/product/14.jpg', '45', '3', '2', '0', null, '1', '2019-06-13 15:02:12', '0', '0');

-- ----------------------------
-- Table structure for t_smalltype
-- ----------------------------
DROP TABLE IF EXISTS `t_smalltype`;
CREATE TABLE `t_smalltype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `bigTypeId` int(11) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_a9rcrieyoywpcgb1luxsbir8s` (`bigTypeId`) USING BTREE,
  CONSTRAINT `t_smalltype_ibfk_1` FOREIGN KEY (`bigTypeId`) REFERENCES `t_bigtype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_smalltype
-- ----------------------------
INSERT INTO `t_smalltype` VALUES ('1', '小米', '1', '手机');
INSERT INTO `t_smalltype` VALUES ('2', '华为', '1', '手机');
INSERT INTO `t_smalltype` VALUES ('3', '惠普', '2', '电脑');
INSERT INTO `t_smalltype` VALUES ('4', '苹果', '2', '电脑');

-- ----------------------------
-- Table structure for t_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_tag
-- ----------------------------

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trueName` varchar(20) DEFAULT NULL,
  `userName` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '用户级别',
  `dentityCode` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', '张三1', 'root', 'root', '2011-11-11 19:57:25', '男', '15171005024', '1343614311@qq.com', '湖北工程学院', '2', null);
INSERT INTO `t_user` VALUES ('3', '张帅', 'zss', '123', '2019-06-02 00:00:00', '男', '15171005024', '1343614311@qq.com', '西区19栋', '1', null);
INSERT INTO `t_user` VALUES ('4', '张帅', 'zc', '123', '2016-03-08 00:00:00', '男', '15171005024', '1343614311@qq.com', '湖北工程 ', '1', null);
INSERT INTO `t_user` VALUES ('6', '张大帅', 'as', '123', '2016-03-08 00:00:00', '男', '15171005024', '1343614311@qq.com', '西区19栋', '1', null);
INSERT INTO `t_user` VALUES ('8', '张帅3', 'zd', '123', '2015-06-10 00:00:00', '男', '15171005024', '1343614311@qq.com', '湖北工程学院', '1', null);
