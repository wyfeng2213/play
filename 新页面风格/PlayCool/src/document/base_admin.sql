/*
Navicat MySQL Data Transfer

Source Server         : 101_mysql
Source Server Version : 50623
Source Host           : 10.0.0.101:3306
Source Database       : base_admin

Target Server Type    : MYSQL
Target Server Version : 50623
File Encoding         : 65001

Date: 2015-05-10 20:09:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bis_no
-- ----------------------------
DROP TABLE IF EXISTS `bis_no`;
CREATE TABLE `bis_no` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `main_type` varchar(100) COLLATE utf8_bin NOT NULL,
  `second_type` varchar(100) COLLATE utf8_bin NOT NULL,
  `main_prefix` varchar(100) COLLATE utf8_bin NOT NULL,
  `second_prefix` varchar(100) COLLATE utf8_bin NOT NULL,
  `date_prefix` varchar(100) COLLATE utf8_bin NOT NULL,
  `seq_no` bigint(19) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_bis_no_all` (`main_type`,`second_type`,`main_prefix`,`second_prefix`,`date_prefix`,`seq_no`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of bis_no
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_EXCEPTION_LOG
-- ----------------------------
DROP TABLE IF EXISTS `SYS_EXCEPTION_LOG`;
CREATE TABLE `SYS_EXCEPTION_LOG` (
  `ID` bigint(19) NOT NULL AUTO_INCREMENT,
  `TYPE` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PAGE_ID` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PAGE_NAME` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LONG_METHOD` varchar(400) COLLATE utf8_bin DEFAULT NULL,
  `LONG_EXCEPTION` text COLLATE utf8_bin,
  `CLAZZ` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `METHOD` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARAM_TYPES` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `PARAMS` text COLLATE utf8_bin,
  `EXCEPTION_LOCALE` text COLLATE utf8_bin,
  `DETAIL_EXCEPTION` blob,
  `EXTEND_PROP1` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXTEND_PROP2` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OPERATE_CODE` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_TYPE` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATOR_ID` bigint(19) DEFAULT NULL,
  `CREATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `LAST_OPERATOR_ID` bigint(19) DEFAULT NULL,
  `LAST_OPERATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_OPERATED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=39759 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of SYS_EXCEPTION_LOG
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_MENU_BUTTON
-- ----------------------------
DROP TABLE IF EXISTS `SYS_MENU_BUTTON`;
CREATE TABLE `SYS_MENU_BUTTON` (
  `ID` bigint(19) NOT NULL AUTO_INCREMENT,
  `NODE_ID` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `NAME` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `STATUS` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `ICON_CLS` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `BT_METHOD` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `BT_ORDER` smallint(3) DEFAULT NULL,
  `TYPE` smallint(2) DEFAULT NULL,
  `PAGE_ID` bigint(19) DEFAULT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATOR_ID` bigint(19) DEFAULT NULL,
  `CREATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_TIME` timestamp NULL DEFAULT NULL,
  `LAST_OPERATOR_ID` bigint(19) DEFAULT NULL,
  `LAST_OPERATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_OPERATED_TIME` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2038 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of SYS_MENU_BUTTON
-- ----------------------------
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2000', 'permission_refreshItem', '刷新', 'ENABLED', '', 'tj_query(\'permission\');', '1', '0', '103', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2001', 'permission_querryAllItem', '全部查找', 'ENABLED', '', 'querryAll(\'permission\');', '2', '0', '103', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2004', 'permission_tj_querryItem', '条件查找', 'ENABLED', '', 'simpleSearch(\'permission\');', '3', '0', '103', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2005', '', '分割线', 'ENABLED', '', '', '4', '1', '103', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2008', 'permission_edit_do', '修改权限', 'ENABLED', '', 'editFun(\'permission\',\'修改权限\',430,375);', '5', '0', '103', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2009', 'add', '新建权限', 'ENABLED', '', '	 addFun(\'permission\',\'新建权限\',430,375);', '6', '0', '103', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2010', '', '分割线', 'ENABLED', '', '', '7', '1', '103', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2011', 'permission_bindButton_do', '查看功能按钮', 'ENABLED', '', 'openBindMenu(\'permission\',\'绑定按钮\',900,450,\'permission\');', '8', '0', '103', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2012', '', '刷新', 'ENABLED', '', 'tj_query(\'user\');', '1', '0', '101', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2013', '', '全部查找', 'ENABLED', '', 'querryAll(\'user\');', '2', '0', '101', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2014', '', '条件查找', 'ENABLED', '', 'simpleSearch(\'user\');', '3', '0', '101', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2015', '', '分割线', 'ENABLED', '', '', '4', '1', '101', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2016', '', '新建用户', 'ENABLED', '', 'addFun(\'user\',\'新建用户\',430,375);', '5', '0', '101', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2017', 'user_edit_do', '编辑用户', 'ENABLED', '', 'editFun(\'user\',\'编辑用户\',430,375);', '6', '0', '101', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2018', '', '分割线', 'ENABLED', '', '', '7', '1', '101', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2019', 'user_bindRole_do', '绑定角色', 'ENABLED', '', 'bindRole(\'user\', \'绑定角色\', 1000, 500);', '8', '0', '101', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2020', 'role_refreshItem', '刷新', 'ENABLED', '', 'tj_query(\'role\');', '1', '0', '102', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2021', 'role_querryAllItem', '全部查找', 'ENABLED', '', 'querryAll(\'role\');', '2', '0', '102', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2022', 'role_tj_querryItem', '条件查找', 'ENABLED', '', 'simpleSearch(\'role\');', '3', '0', '102', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2023', '', '分割线', 'ENABLED', '', '', '4', '1', '102', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2024', 'role_add', '新建角色', 'ENABLED', '', 'addFun(\'role\',\'新建角色\',370,220);', '5', '0', '102', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2025', 'role_edit_do', '编辑角色', 'ENABLED', '', 'editFun(\'role\',\'编辑角色\',370,220);', '6', '0', '102', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2026', '', '分割线', 'ENABLED', '', '', '7', '1', '102', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2027', 'role_bindPermission_do', '绑定权限', 'ENABLED', '', 'bindPermission(\'role\', \'绑定权限\', 400, 400);', '8', '0', '102', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2028', 'role_bindUser_do', '绑定用户', 'ENABLED', '', 'bindUser(\'role\', \'绑定用户\', 1000, 500);', '9', '0', '102', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2029', 'sysExceptionLog_refreshItem', '刷新', 'ENABLED', '', 'tj_query(\'sysExceptionLog\');', '1', '0', '104', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2030', 'sysExceptionLog_querryAllItem', '全部查找', 'ENABLED', '', 'querryAll(\'sysExceptionLog\');', '2', '0', '104', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2031', 'sysExceptionLog_tj_querryItem', '条件查找', 'ENABLED', '', 'simpleSearch(\'sysExceptionLog\');', '3', '0', '104', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2032', '', '分割线', 'ENABLED', '', '', '4', '1', '104', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2033', 'sysExceptionLog_detailItem', '异常详情', 'ENABLED', '', 'exceptionDetail(\'exceptionDetail\');', '5', '0', '104', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2034', 'inReceiptForLoan_refreshItem', '刷新', 'ENABLED', '', 'tj_query(\'inReceiptForLoan\');', '1', '0', '2010', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2035', 'inReceiptForLoan_querryAllItem', '全部查询', 'ENABLED', '', 'querryAll(\'inReceiptForLoan\');', '2', '0', '2010', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2036', 'inReceiptForLoan_tj_querryItem', '条件查询', 'ENABLED', '', 'simpleSearch(\'inReceiptForLoan\');', '3', '0', '2010', '', null, null, null, null, null, null);
INSERT INTO `SYS_MENU_BUTTON` VALUES ('2037', '', '分割线', 'ENABLED', '', '', '4', '1', '2010', '', null, null, null, null, null, null);

-- ----------------------------
-- Table structure for SYS_OPERATE_LOG
-- ----------------------------
DROP TABLE IF EXISTS `SYS_OPERATE_LOG`;
CREATE TABLE `SYS_OPERATE_LOG` (
  `ID` bigint(19) NOT NULL AUTO_INCREMENT,
  `USER_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '用户编码',
  `USER_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '用户名',
  `OPERATE_CODE` varchar(35) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '操作编码：login登录操作、toApply跳转到贷款申请页面、apply申请的提交',
  `OPERATE_NAME` varchar(150) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '操作名',
  `STATUS` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'RIGHT操作成功，WRONG操作失败',
  `OPERATE_INFO` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '操作详细',
  `IP` varchar(18) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '用户IP',
  `PORT` varchar(18) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '用户端口',
  `OPERATE_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间（默认数据库插入时间）',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of SYS_OPERATE_LOG
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_ORGANIZATION
-- ----------------------------
DROP TABLE IF EXISTS `SYS_ORGANIZATION`;
CREATE TABLE `SYS_ORGANIZATION` (
  `ID` bigint(19) NOT NULL AUTO_INCREMENT,
  `CODE` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ORG_TYPE_ID` bigint(20) DEFAULT NULL,
  `PARENT_ORG_ID` bigint(20) DEFAULT NULL,
  `MANAGER` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `STATUS` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ENABLED` tinyint(1) DEFAULT '0',
  `EXTEND_PROP1` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXTEND_PROP2` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CONTACT_IDENTITY_NO` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CONTACT_BIRTH_DATE` date DEFAULT NULL,
  `CONTACT_SEX` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CONTACT_ADDRESS` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `CONTACT_TEL` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CONTACT_MOBILE` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CONTACT_EMAIL` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CONTACT_QQ` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATOR_ID` bigint(20) DEFAULT NULL,
  `CREATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `LAST_OPERATOR_ID` bigint(20) DEFAULT NULL,
  `LAST_OPERATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_OPERATED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `CODE` (`CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of SYS_ORGANIZATION
-- ----------------------------
INSERT INTO `SYS_ORGANIZATION` VALUES ('1', '1', '1', '1', '-1', null, null, 'ENABLED', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for SYS_ORGANIZATION_TYPE
-- ----------------------------
DROP TABLE IF EXISTS `SYS_ORGANIZATION_TYPE`;
CREATE TABLE `SYS_ORGANIZATION_TYPE` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CODE` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ENABLED` tinyint(1) DEFAULT '0',
  `CREATOR_ID` bigint(20) DEFAULT NULL,
  `CREATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `LAST_OPERATOR_ID` bigint(20) DEFAULT NULL,
  `LAST_OPERATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_OPERATED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `CODE` (`CODE`),
  KEY `CODE_INDEX` (`CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of SYS_ORGANIZATION_TYPE
-- ----------------------------
INSERT INTO `SYS_ORGANIZATION_TYPE` VALUES ('1', '1', '1', '1', '0', null, null, null, null, null, null);

-- ----------------------------
-- Table structure for SYS_PERMISSION
-- ----------------------------
DROP TABLE IF EXISTS `SYS_PERMISSION`;
CREATE TABLE `SYS_PERMISSION` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CODE` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_PERMISSION_ID` bigint(19) DEFAULT NULL,
  `TYPE` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `URL` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `BE_TOP` int(3) DEFAULT NULL,
  `PRIORITY` int(5) DEFAULT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ENABLED` int(3) DEFAULT '0',
  `CREATOR_ID` bigint(19) DEFAULT NULL,
  `CREATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_TIME` timestamp NULL DEFAULT NULL,
  `LAST_OPERATOR_ID` bigint(19) DEFAULT NULL,
  `LAST_OPERATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_OPERATED_TIME` timestamp NULL DEFAULT NULL,
  `ICON_SKIN` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2022 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of SYS_PERMISSION
-- ----------------------------
INSERT INTO `SYS_PERMISSION` VALUES ('100', '系统管理', '系统管理', null, 'MENU', '', '', '1', '100', '', '1', null, null, null, '1', 'root', '2015-05-10 19:40:41', 'pSysIcon');
INSERT INTO `SYS_PERMISSION` VALUES ('101', '用户管理', '用户管理', '100', 'MENU', 'user/list', null, '0', '0', null, '1', null, null, null, null, null, null, null);
INSERT INTO `SYS_PERMISSION` VALUES ('102', '角色管理', '角色管理', '100', 'MENU', 'role/list', null, '0', '1', null, '1', null, null, null, null, null, null, null);
INSERT INTO `SYS_PERMISSION` VALUES ('103', '权限管理', '权限管理', '100', 'MENU', 'permission/list', null, '0', '2', null, '1', null, null, null, null, null, null, null);
INSERT INTO `SYS_PERMISSION` VALUES ('104', '日志管理', '日志管理', '100', 'MENU', 'exceptionLog/list', null, '0', '3', null, '1', null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for SYS_ROLE
-- ----------------------------
DROP TABLE IF EXISTS `SYS_ROLE`;
CREATE TABLE `SYS_ROLE` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CODE` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `STATUS` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ENABLED` int(3) DEFAULT '0',
  `EXTEND_PROP1` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXTEND_PROP2` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATOR_ID` bigint(19) DEFAULT NULL,
  `CREATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_TIME` timestamp NULL DEFAULT NULL,
  `LAST_OPERATOR_ID` int(19) DEFAULT NULL,
  `LAST_OPERATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_OPERATED_TIME` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2006 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of SYS_ROLE
-- ----------------------------
INSERT INTO `SYS_ROLE` VALUES ('2001', 'super_manager', '超级管理员', '', null, '1', null, null, '1', 'root', '2015-03-17 15:07:15', '1', 'root', '2015-03-17 16:11:47');

-- ----------------------------
-- Table structure for SYS_ROLE_MENU
-- ----------------------------
DROP TABLE IF EXISTS `SYS_ROLE_MENU`;
CREATE TABLE `SYS_ROLE_MENU` (
  `ID` bigint(19) NOT NULL AUTO_INCREMENT,
  `ROLE_ID` bigint(19) DEFAULT NULL,
  `MENU_ID` bigint(19) DEFAULT NULL,
  `STATUS` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `CHECKED` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `CREATOR_ID` bigint(19) DEFAULT NULL,
  `CREATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_TIME` timestamp NULL DEFAULT NULL,
  `LAST_OPERATOR_ID` bigint(19) DEFAULT NULL,
  `LAST_OPERATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_OPERATED_TIME` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2036 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of SYS_ROLE_MENU
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_ROLE_PERMISSION
-- ----------------------------
DROP TABLE IF EXISTS `SYS_ROLE_PERMISSION`;
CREATE TABLE `SYS_ROLE_PERMISSION` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ROLE_ID` bigint(20) DEFAULT NULL,
  `PERMISSION_ID` bigint(20) DEFAULT NULL,
  `ENABLED` tinyint(1) DEFAULT '0',
  `CREATOR_ID` bigint(20) DEFAULT NULL,
  `CREATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `LAST_OPERATOR_ID` bigint(20) DEFAULT NULL,
  `LAST_OPERATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_OPERATED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `PERMISSION_ID_INDEX` (`PERMISSION_ID`),
  KEY `ROLE_ID_INDEX` (`ROLE_ID`),
  CONSTRAINT `SYS_ROLE_PERMISSION_ibfk_1` FOREIGN KEY (`PERMISSION_ID`) REFERENCES `SYS_PERMISSION` (`ID`),
  CONSTRAINT `sys_role_id_ibfk_2` FOREIGN KEY (`ROLE_ID`) REFERENCES `SYS_ROLE` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1380 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of SYS_ROLE_PERMISSION
-- ----------------------------
INSERT INTO `SYS_ROLE_PERMISSION` VALUES ('1374', '2001', '100', '1', '1', 'root', '2015-05-10 19:39:34', null, null, null);
INSERT INTO `SYS_ROLE_PERMISSION` VALUES ('1375', '2001', '101', '1', '1', 'root', '2015-05-10 19:39:34', null, null, null);
INSERT INTO `SYS_ROLE_PERMISSION` VALUES ('1376', '2001', '102', '1', '1', 'root', '2015-05-10 19:39:34', null, null, null);
INSERT INTO `SYS_ROLE_PERMISSION` VALUES ('1377', '2001', '103', '1', '1', 'root', '2015-05-10 19:39:34', null, null, null);
INSERT INTO `SYS_ROLE_PERMISSION` VALUES ('1378', '2001', '104', '1', '1', 'root', '2015-05-10 19:39:34', null, null, null);

-- ----------------------------
-- Table structure for SYS_USER
-- ----------------------------
DROP TABLE IF EXISTS `SYS_USER`;
CREATE TABLE `SYS_USER` (
  `ID` bigint(19) NOT NULL AUTO_INCREMENT,
  `CODE` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ORGANIZATION_ID` bigint(19) DEFAULT NULL,
  `PASSWORD` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_PWD` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_MD_PWD_TIME` timestamp NULL DEFAULT NULL,
  `EXPIRED_DATE` timestamp NULL DEFAULT NULL,
  `PASSWORD_EXPIRED_DATE` timestamp NULL DEFAULT NULL,
  `LOCALE` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `BE_ROOT` int(3) DEFAULT '0',
  `ENABLED` int(3) DEFAULT '0',
  `CONTACT_IDENTITY_NO` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CONTACT_BIRTH_DATE` date DEFAULT NULL,
  `CONTACT_SEX` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CONTACT_ADDRESS` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `CONTACT_TEL` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CONTACT_MOBILE` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CONTACT_EMAIL` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CONTACT_QQ` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATOR_ID` bigint(19) DEFAULT NULL,
  `CREATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_TIME` timestamp NULL DEFAULT NULL,
  `LAST_OPERATOR_ID` bigint(19) DEFAULT NULL,
  `LAST_OPERATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_OPERATED_TIME` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IDX_SYS_U_CODE` (`CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=2007 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of SYS_USER
-- ----------------------------
INSERT INTO `SYS_USER` VALUES ('1', 'root', 'root', '1', '63a9f0ea7bb98050796b649e85481845', null, null, null, null, null, '1', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for SYS_USER_ROLE
-- ----------------------------
DROP TABLE IF EXISTS `SYS_USER_ROLE`;
CREATE TABLE `SYS_USER_ROLE` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USER_ID` bigint(20) DEFAULT NULL,
  `ROLE_ID` bigint(20) DEFAULT NULL,
  `ENABLED` tinyint(1) DEFAULT '0',
  `CREATOR_ID` bigint(20) DEFAULT NULL,
  `CREATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_TIME` datetime DEFAULT NULL,
  `LAST_OPERATOR_ID` bigint(20) DEFAULT NULL,
  `LAST_OPERATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_OPERATED_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `USER_ID_INDEX` (`USER_ID`),
  KEY `ROLE_ID_INDEX` (`ROLE_ID`),
  CONSTRAINT `FK_SYS_USER_ROLE_RID` FOREIGN KEY (`ROLE_ID`) REFERENCES `SYS_ROLE` (`ID`),
  CONSTRAINT `FK_SYS_USER_ROLE_UID` FOREIGN KEY (`USER_ID`) REFERENCES `SYS_USER` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of SYS_USER_ROLE
-- ----------------------------
INSERT INTO `SYS_USER_ROLE` VALUES ('95', '1', '2001', '1', '1', 'root', '2015-03-17 15:09:06', null, null, null);

-- ----------------------------
-- Table structure for SYS_USER_TABLE_COLUMNS
-- ----------------------------
DROP TABLE IF EXISTS `SYS_USER_TABLE_COLUMNS`;
CREATE TABLE `SYS_USER_TABLE_COLUMNS` (
  `ID` bigint(19) NOT NULL AUTO_INCREMENT,
  `USER_ID` bigint(19) DEFAULT NULL,
  `TABLE_ID` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `FIELD` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `SORT` smallint(5) DEFAULT NULL,
  `FORMATTER` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `WIDTH` bigint(19) DEFAULT NULL,
  `HIDDEN` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `COL_NAME` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `SORTABLE` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5093 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of SYS_USER_TABLE_COLUMNS
-- ----------------------------

-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`%` FUNCTION `FN_GENERATE_NO`(p_main_type VARCHAR(100),p_second_type VARCHAR(100),p_main_prefix VARCHAR(100),p_second_prefix VARCHAR(100),p_date_prefix VARCHAR(100),p_no_length BIGINT) RETURNS varchar(100) CHARSET latin1
BEGIN
	DECLARE v_no VARCHAR(10) ;
	DECLARE v_cnt BIGINT;
	DECLARE v_id BIGINT;
	DECLARE v_format VARCHAR(20) DEFAULT 'FM9999';
	DECLARE v_x BIGINT DEFAULT 0;
	DECLARE v_no_length BIGINT DEFAULT 6;
	SELECT COUNT(id) INTO v_cnt FROM bis_no WHERE main_type=p_main_type AND second_type=p_second_type AND main_prefix=p_main_prefix AND second_prefix=p_second_prefix AND date_prefix=p_date_prefix;
	IF v_cnt = 0 THEN
	INSERT INTO bis_no(main_type, second_type, main_prefix, second_prefix, date_prefix, seq_no) VALUES(p_main_type, p_second_type, p_main_prefix, p_second_prefix, p_date_prefix, 1);
	SET v_id=LAST_INSERT_ID();
	END IF;
	IF v_id IS NULL THEN
	SELECT id INTO v_id FROM bis_no WHERE main_type=p_main_type AND second_type=p_second_type AND main_prefix=p_main_prefix AND second_prefix=p_second_prefix AND date_prefix=p_date_prefix;
	END IF;
	IF p_no_length IS NOT NULL AND p_no_length <> v_no_length THEN
	SET v_no_length = p_no_length;
	END IF;
	/*
	WHILE v_x < v_no_length
	SET v_format = CONCAT(v_format,'0');
	SET v_x = v_x + 1;
	END WHILE;*/
	SELECT LPAD(seq_no,v_no_length, '0') INTO v_no FROM bis_no WHERE id=v_id FOR UPDATE; /** ����,��ֹ�ظ���ˮ�� */
	UPDATE bis_no SET seq_no=seq_no + 1 WHERE id=v_id;
	RETURN v_no;
END
-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`%` PROCEDURE `SP_BIS_GENERATE_CODE`(IN p_main_type VARCHAR(100),IN p_second_type VARCHAR(100),IN p_main_prefix VARCHAR(100),IN p_second_prefix VARCHAR(100),IN p_no_length BIGINT,OUT ret_code VARCHAR(100))
BEGIN
	DECLARE v_date_prefix VARCHAR(15);
	DECLARE v_no VARCHAR(50);
	SET v_date_prefix = DATE_FORMAT(NOW(),'%y%m%d%H%i%S');
	SET v_no = FN_GENERATE_NO(p_main_type, p_second_type, p_main_prefix, p_second_prefix, v_date_prefix, p_no_length);
	SET ret_code = CONCAT(p_main_prefix,p_second_prefix,v_date_prefix,v_no);
END
    
    -- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`%` PROCEDURE `SP_BIS_GENERATE_NO`(IN p_main_type VARCHAR(100),IN p_second_type VARCHAR(100),IN p_main_prefix VARCHAR(100),IN p_second_prefix VARCHAR(100),IN p_no_length BIGINT,OUT ret_no VARCHAR(100))
BEGIN
	SET ret_no = FN_GENERATE_NO(p_main_type, p_second_type, p_main_prefix, p_second_prefix, '-', p_no_length);
END