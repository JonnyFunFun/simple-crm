/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50524
Source Host           : localhost:3306
Source Database       : crm

Target Server Type    : MYSQL
Target Server Version : 50524
File Encoding         : 65001

Date: 2014-04-20 22:47:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `address_type_id` int(11) NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL,
  `address_line_1` varchar(128) COLLATE utf8_bin NOT NULL,
  `address_line_2` varchar(128) COLLATE utf8_bin NOT NULL,
  `city` varchar(128) COLLATE utf8_bin NOT NULL,
  `state_province_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `primary` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`address_id`),
  KEY `customer_id` (`customer_id`),
  KEY `address_type_id` (`address_type_id`),
  KEY `state_province_id` (`state_province_id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `fk_address_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_address_country_id` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`),
  CONSTRAINT `fk_address_state_prov_id` FOREIGN KEY (`state_province_id`) REFERENCES `state_province` (`state_province_id`),
  CONSTRAINT `fk_address_type_id` FOREIGN KEY (`address_type_id`) REFERENCES `address_type` (`address_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES ('1', '3', '1', 'John Q Smith', '123 Testville Ln', '', 'Testerton', '42', '1', '');

-- ----------------------------
-- Table structure for address_type
-- ----------------------------
DROP TABLE IF EXISTS `address_type`;
CREATE TABLE `address_type` (
  `address_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`address_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of address_type
-- ----------------------------
INSERT INTO `address_type` VALUES ('1', 'Home');
INSERT INTO `address_type` VALUES ('2', 'Work');
INSERT INTO `address_type` VALUES ('3', 'Shipping');
INSERT INTO `address_type` VALUES ('4', 'Other');

-- ----------------------------
-- Table structure for attachment
-- ----------------------------
DROP TABLE IF EXISTS `attachment`;
CREATE TABLE `attachment` (
  `attachment_id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_id` int(11) NOT NULL,
  `attachment_type_id` int(11) NOT NULL,
  `attachment_name` varchar(128) COLLATE utf8_bin NOT NULL,
  `attachment_data` blob NOT NULL,
  PRIMARY KEY (`attachment_id`),
  KEY `contact_id` (`contact_id`),
  KEY `attachment_type_id` (`attachment_type_id`),
  CONSTRAINT `fk_attachment_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`contact_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_attachment_type_id` FOREIGN KEY (`attachment_type_id`) REFERENCES `attachment_type` (`attachment_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of attachment
-- ----------------------------

-- ----------------------------
-- Table structure for attachment_type
-- ----------------------------
DROP TABLE IF EXISTS `attachment_type`;
CREATE TABLE `attachment_type` (
  `attachment_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`attachment_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of attachment_type
-- ----------------------------
INSERT INTO `attachment_type` VALUES ('1', 'Document');
INSERT INTO `attachment_type` VALUES ('2', 'Notes');
INSERT INTO `attachment_type` VALUES ('3', 'Invoice');
INSERT INTO `attachment_type` VALUES ('4', 'Quote/Estimate');
INSERT INTO `attachment_type` VALUES ('5', 'Photo');
INSERT INTO `attachment_type` VALUES ('6', 'Other');

-- ----------------------------
-- Table structure for contact
-- ----------------------------
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact` (
  `contact_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `contact_type_id` int(11) NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `title` varchar(128) COLLATE utf8_bin NOT NULL,
  `description` text COLLATE utf8_bin,
  PRIMARY KEY (`contact_id`),
  KEY `customer_id` (`customer_id`),
  KEY `contact_type_id` (`contact_type_id`),
  CONSTRAINT `fk_contact_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_contact_type_id` FOREIGN KEY (`contact_type_id`) REFERENCES `contact_type` (`contact_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of contact
-- ----------------------------
INSERT INTO `contact` VALUES ('2', '3', '1', '2014-04-20 13:52:15', 'Check-in Call Re: CRM', 0x4A75737420686164206120717569636B2070686F6E652063616C6C2077697468204A6F686E20746F206469736375737320686F77207468652070726F6475637420686173206265656E20776F726B696E6720666F722068696D2E2020486527732067656E6572616C6C7920706C65617365642077697468207468652043524D2C20627574206973206120626974207065727475726265642074686174207468657265206973206E6F207365637572697479206C61796572206275696C7420696E2E20205375676765737465642068652075736520485454502042617369632077697468696E20686973202E68746163636573732066696C65);
INSERT INTO `contact` VALUES ('3', '3', '4', '2014-04-20 13:52:55', 'Lunch', null);
INSERT INTO `contact` VALUES ('7', '3', '4', '2014-04-20 21:51:06', 'Meeting', 0x4D65742077697468204A6F686E202D20686527732072656C61746976656C7920686170707920616761696E2E2E2E2E666F72206E6F772E);

-- ----------------------------
-- Table structure for contact_type
-- ----------------------------
DROP TABLE IF EXISTS `contact_type`;
CREATE TABLE `contact_type` (
  `contact_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`contact_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of contact_type
-- ----------------------------
INSERT INTO `contact_type` VALUES ('1', 'Phone Call');
INSERT INTO `contact_type` VALUES ('2', 'Email');
INSERT INTO `contact_type` VALUES ('3', 'IM/Chat');
INSERT INTO `contact_type` VALUES ('4', 'In Person');
INSERT INTO `contact_type` VALUES ('5', 'Voicemail');
INSERT INTO `contact_type` VALUES ('6', 'Other');

-- ----------------------------
-- Table structure for country
-- ----------------------------
DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `abbreviation` char(2) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of country
-- ----------------------------
INSERT INTO `country` VALUES ('1', 'United States', 'US');
INSERT INTO `country` VALUES ('2', 'Canada', 'CA');
INSERT INTO `country` VALUES ('3', 'Mexico', 'MX');

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_type_id` int(11) NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `customer_type_id` (`customer_type_id`),
  CONSTRAINT `fk_customer_customer_type` FOREIGN KEY (`customer_type_id`) REFERENCES `customer_type` (`customer_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('3', '1', 'John Smith');
INSERT INTO `customer` VALUES ('4', '3', 'ACME Supplies Inc');
INSERT INTO `customer` VALUES ('13', '2', 'Jane Doe');

-- ----------------------------
-- Table structure for customer_type
-- ----------------------------
DROP TABLE IF EXISTS `customer_type`;
CREATE TABLE `customer_type` (
  `customer_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(128) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`customer_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of customer_type
-- ----------------------------
INSERT INTO `customer_type` VALUES ('1', 'Customer');
INSERT INTO `customer_type` VALUES ('2', 'Lead');
INSERT INTO `customer_type` VALUES ('3', 'Vendor');
INSERT INTO `customer_type` VALUES ('4', 'Agent');
INSERT INTO `customer_type` VALUES ('5', 'Other');

-- ----------------------------
-- Table structure for email
-- ----------------------------
DROP TABLE IF EXISTS `email`;
CREATE TABLE `email` (
  `email_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `email_type_id` int(11) NOT NULL,
  `address` varchar(128) COLLATE utf8_bin NOT NULL,
  `primary` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`email_id`),
  UNIQUE KEY `address` (`address`),
  KEY `customer_id` (`customer_id`),
  KEY `email_type_id` (`email_type_id`),
  CONSTRAINT `fk_email_email_type` FOREIGN KEY (`email_type_id`) REFERENCES `email_type` (`email_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_email_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of email
-- ----------------------------
INSERT INTO `email` VALUES ('3', '3', '2', 'j.smith@microsoft.com', '');
INSERT INTO `email` VALUES ('4', '3', '1', 'smithnobody@gmail.com', '\0');
INSERT INTO `email` VALUES ('6', '4', '2', 'sales@acme.com', '');
INSERT INTO `email` VALUES ('10', '3', '3', 'superman123@nospam.org', '\0');

-- ----------------------------
-- Table structure for email_type
-- ----------------------------
DROP TABLE IF EXISTS `email_type`;
CREATE TABLE `email_type` (
  `email_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(128) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`email_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of email_type
-- ----------------------------
INSERT INTO `email_type` VALUES ('1', 'Home');
INSERT INTO `email_type` VALUES ('2', 'Work');
INSERT INTO `email_type` VALUES ('3', 'Other');

-- ----------------------------
-- Table structure for state_province
-- ----------------------------
DROP TABLE IF EXISTS `state_province`;
CREATE TABLE `state_province` (
  `state_province_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `abbreviation` char(2) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`state_province_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of state_province
-- ----------------------------
INSERT INTO `state_province` VALUES ('1', 'Alabama', 'AL');
INSERT INTO `state_province` VALUES ('2', 'Alaska', 'AK');
INSERT INTO `state_province` VALUES ('3', 'Arizona', 'AZ');
INSERT INTO `state_province` VALUES ('4', 'Arkansas', 'AR');
INSERT INTO `state_province` VALUES ('5', 'California', 'CA');
INSERT INTO `state_province` VALUES ('6', 'Colorado', 'CO');
INSERT INTO `state_province` VALUES ('7', 'Connecticut', 'CT');
INSERT INTO `state_province` VALUES ('8', 'Delaware', 'DE');
INSERT INTO `state_province` VALUES ('9', 'Florida', 'FL');
INSERT INTO `state_province` VALUES ('10', 'Georgia', 'GA');
INSERT INTO `state_province` VALUES ('11', 'Hawaii', 'HI');
INSERT INTO `state_province` VALUES ('12', 'Idaho', 'ID');
INSERT INTO `state_province` VALUES ('13', 'Illinois', 'IL');
INSERT INTO `state_province` VALUES ('14', 'Indiana', 'IN');
INSERT INTO `state_province` VALUES ('15', 'Iowa', 'IA');
INSERT INTO `state_province` VALUES ('16', 'Kansas', 'KS');
INSERT INTO `state_province` VALUES ('17', 'Kentucky', 'KY');
INSERT INTO `state_province` VALUES ('18', 'Louisiana', 'LA');
INSERT INTO `state_province` VALUES ('19', 'Maine', 'ME');
INSERT INTO `state_province` VALUES ('20', 'Maryland', 'MD');
INSERT INTO `state_province` VALUES ('21', 'Massachusetts', 'MA');
INSERT INTO `state_province` VALUES ('22', 'Michigan', 'MI');
INSERT INTO `state_province` VALUES ('23', 'Minnesota', 'MN');
INSERT INTO `state_province` VALUES ('24', 'Mississippi', 'MS');
INSERT INTO `state_province` VALUES ('25', 'Missouri', 'MO');
INSERT INTO `state_province` VALUES ('26', 'Montana', 'MT');
INSERT INTO `state_province` VALUES ('27', 'Nebraska', 'NE');
INSERT INTO `state_province` VALUES ('28', 'Nevada', 'NV');
INSERT INTO `state_province` VALUES ('29', 'New Hampshire', 'NH');
INSERT INTO `state_province` VALUES ('30', 'New Jersey', 'NJ');
INSERT INTO `state_province` VALUES ('31', 'New Mexico', 'NM');
INSERT INTO `state_province` VALUES ('32', 'New York', 'NY');
INSERT INTO `state_province` VALUES ('33', 'North Carolina', 'NC');
INSERT INTO `state_province` VALUES ('34', 'North Dakota', 'ND');
INSERT INTO `state_province` VALUES ('35', 'Ohio', 'OH');
INSERT INTO `state_province` VALUES ('36', 'Oklahoma', 'OK');
INSERT INTO `state_province` VALUES ('37', 'Oregon', 'OR');
INSERT INTO `state_province` VALUES ('38', 'Pennsylvania', 'PA');
INSERT INTO `state_province` VALUES ('39', 'Rhode Island', 'RI');
INSERT INTO `state_province` VALUES ('40', 'South Carolina', 'SC');
INSERT INTO `state_province` VALUES ('41', 'South Dakota', 'SD');
INSERT INTO `state_province` VALUES ('42', 'Tennessee', 'TN');
INSERT INTO `state_province` VALUES ('43', 'Texas', 'TX');
INSERT INTO `state_province` VALUES ('44', 'Utah', 'UT');
INSERT INTO `state_province` VALUES ('45', 'Vermont', 'VT');
INSERT INTO `state_province` VALUES ('46', 'Virginia', 'VA');
INSERT INTO `state_province` VALUES ('47', 'Washington', 'WA');
INSERT INTO `state_province` VALUES ('48', 'West Virginia', 'WV');
INSERT INTO `state_province` VALUES ('49', 'Wisconsin', 'WI');
INSERT INTO `state_province` VALUES ('50', 'Wyoming', 'WY');
INSERT INTO `state_province` VALUES ('51', 'Washington DC', 'DC');
INSERT INTO `state_province` VALUES ('52', 'Alberta ', 'AB');
INSERT INTO `state_province` VALUES ('53', 'British Columbia ', 'BC');
INSERT INTO `state_province` VALUES ('54', 'Manitoba ', 'MB');
INSERT INTO `state_province` VALUES ('55', 'New Brunswick ', 'NB');
INSERT INTO `state_province` VALUES ('56', 'Newfoundland and Labrador ', 'NL');
INSERT INTO `state_province` VALUES ('57', 'Nova Scotia ', 'NS');
INSERT INTO `state_province` VALUES ('58', 'Ontario ', 'ON');
INSERT INTO `state_province` VALUES ('59', 'Prince Edward Island ', 'PE');
INSERT INTO `state_province` VALUES ('60', 'Quebec ', 'QC');
INSERT INTO `state_province` VALUES ('61', 'Saskatchewan ', 'SK');
