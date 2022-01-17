/*
 Navicat Premium Data Transfer

 Source Server         : 103.57.220.124_3306
 Source Server Type    : MySQL
 Source Server Version : 50735
 Source Host           : 103.57.220.124:3306
 Source Schema         : dev-poly

 Target Server Type    : MySQL
 Target Server Version : 50735
 File Encoding         : 65001

 Date: 28/08/2021 14:57:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for challenge_categories
-- ----------------------------
DROP TABLE IF EXISTS `challenge_categories`;
CREATE TABLE `challenge_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `image` varchar(191) NOT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `challenge_categories_name_unique` (`name`),
  UNIQUE KEY `challenge_categories_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of challenge_categories
-- ----------------------------
BEGIN;
INSERT INTO `challenge_categories` VALUES (1, 'Lập trình viên full stack', 'lap-trinh-vien-full-stack', 'files/1627548596-image.svg', '<p>Trở th&agrave;nh nh&agrave; ph&aacute;t triển Full-stack bằng c&aacute;ch x&acirc;y dựng 8 ứng dụng web full-stack n&acirc;ng cao</p>\n\n<p>D&agrave;nh cho những ai muốn:</p>\n\n<ul>\n	<li>\n	<p>Thực h&agrave;nh&nbsp;<strong>c&aacute;c thư viện Front-end v&agrave; x&acirc;y dựng c&aacute;c ứng dụng ho&agrave;n chỉnh</strong></p>\n	</li>\n	<li>\n	<p>Trở th&agrave;nh&nbsp;<strong>nh&agrave; ph&aacute;t triển Full-stack</strong></p>\n	</li>\n	<li>\n	<p>X&acirc;y dựng trang web với&nbsp;<strong>c&aacute;c hoạt động thực tế</strong></p>\n	</li>\n</ul>', NULL, '2021-07-29 08:49:56');
INSERT INTO `challenge_categories` VALUES (4, 'Nhà phát triển Front-end', 'nha-phat-trien-front-end', 'files/1627548551-image.svg', '<p>Trở th&agrave;nh Nh&agrave; ph&aacute;t triển Front-end bằng c&aacute;ch x&acirc;y dựng 8 dự &aacute;n thực tế, bạn c&oacute; thể sử dụng bất kỳ khu&ocirc;n khổ Front-end n&agrave;o</p>\n\n<p>D&agrave;nh cho những ai muốn:</p>\n\n<ul>\n	<li>\n	<p>Thực h&agrave;nh&nbsp;<strong>React, Vue hoặc c&aacute;c thư viện front-end kh&aacute;c</strong></p>\n	</li>\n	<li>\n	<p>Trở th&agrave;nh&nbsp;<strong>nh&agrave; ph&aacute;t triển Front-end</strong></p>\n	</li>\n	<li>\n	<p>X&acirc;y dựng trang web với&nbsp;<strong>c&aacute;c hoạt động thực tế</strong></p>\n	</li>\n</ul>', '2021-07-29 08:49:11', '2021-07-29 08:49:11');
INSERT INTO `challenge_categories` VALUES (5, 'Nhà phát triển web đáp ứng', 'nha-phat-trien-web-dap-ung', 'files/1627548686-image.svg', '<p>T&igrave;m hiểu v&agrave; Thực h&agrave;nh Ph&aacute;t triển Web Đ&aacute;p ứng bằng c&aacute;ch x&acirc;y dựng 8 Trang web với c&aacute;c thiết kế cho sẵn</p>\n\n<p>D&agrave;nh cho những ai muốn:</p>\n\n<ul>\n	<li>\n	<p>Bắt đầu với&nbsp;<strong>m&atilde; h&oacute;a</strong></p>\n	</li>\n	<li>\n	<p>Thực h&agrave;nh&nbsp;<strong>HTML, CSS v&agrave; JavaScript cơ bản</strong></p>\n	</li>\n	<li>\n	<p>X&acirc;y dựng trang web với&nbsp;<strong>c&aacute;c hoạt động thực tế</strong>&nbsp;.</p>\n	</li>\n</ul>', '2021-07-29 08:51:26', '2021-07-29 08:51:26');
COMMIT;

-- ----------------------------
-- Table structure for challenge_users
-- ----------------------------
DROP TABLE IF EXISTS `challenge_users`;
CREATE TABLE `challenge_users` (
  `user_id` int(10) NOT NULL,
  `challen_id` int(10) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id` int(191) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of challenge_users
-- ----------------------------
BEGIN;
INSERT INTO `challenge_users` VALUES (1, 1, '2021-08-23 10:29:50', '2021-08-23 10:31:04', 1, 1);
INSERT INTO `challenge_users` VALUES (1, 4, '2021-08-27 08:02:46', '2021-08-27 08:03:05', 2, 1);
INSERT INTO `challenge_users` VALUES (1, 5, '2021-08-27 08:14:16', '2021-08-27 08:14:16', 3, 0);
COMMIT;

-- ----------------------------
-- Table structure for challenges
-- ----------------------------
DROP TABLE IF EXISTS `challenges`;
CREATE TABLE `challenges` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `description` text NOT NULL,
  `language` varchar(191) NOT NULL,
  `link_figma` varchar(191) NOT NULL,
  `design_on_figma` varchar(191) DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `resources` varchar(191) NOT NULL,
  `level` tinyint(4) NOT NULL DEFAULT '1',
  `cate_challen_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `challenges_title_unique` (`title`),
  UNIQUE KEY `challenges_slug_unique` (`slug`),
  UNIQUE KEY `challenges_link_figma_unique` (`link_figma`),
  UNIQUE KEY `design_on_figma` (`design_on_figma`),
  KEY `challenges_cate_challen_id_foreign` (`cate_challen_id`),
  CONSTRAINT `challenges_cate_challen_id_foreign` FOREIGN KEY (`cate_challen_id`) REFERENCES `challenge_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of challenges
-- ----------------------------
BEGIN;
INSERT INTO `challenges` VALUES (1, 'Trình tải lên hình ảnh', 'trinh-tai-len-hinh-anh', '<p><strong>Th&aacute;ch thức:</strong>&nbsp;Tạo ứng dụng Tr&igrave;nh tải l&ecirc;n h&igrave;nh ảnh.&nbsp;Sử dụng bất kỳ thư viện front-end n&agrave;o m&agrave; bạn chọn.&nbsp;Tạo API của bạn.&nbsp;Đừng nh&igrave;n v&agrave;o giải ph&aacute;p hiện c&oacute;.&nbsp;Thực hiện c&aacute;c c&acirc;u chuyện của người d&ugrave;ng dưới đ&acirc;y:</p>\n\n<ul>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể k&eacute;o v&agrave; thả một h&igrave;nh ảnh để tải n&oacute; l&ecirc;n</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể chọn để chọn một h&igrave;nh ảnh từ thư mục của m&igrave;nh</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể thấy tr&igrave;nh tải khi tải l&ecirc;n</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;Khi h&igrave;nh ảnh được tải l&ecirc;n, t&ocirc;i c&oacute; thể xem h&igrave;nh ảnh v&agrave; sao ch&eacute;p n&oacute;</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể chọn sao ch&eacute;p v&agrave;o khay nhớ tạm</li>\n</ul>', 'HTML/CSS JS', 'https://www.figma.com/file/NxbZm3CAovYh89dFXe7EOw?chrome=DOCUMENTATION&embed_host=astra&kind=&node-id=0%3A1&viewer=1', 'https://www.figma.com/file/NxbZm3CAovYh89dFXe7EOw/Image-Uploader', 'files/1627698467-image.png', 'files/1627380961-image-uploader-master.zip', 6, 1, '2021-07-30 23:25:12', '2021-08-28 11:46:15');
INSERT INTO `challenges` VALUES (2, 'Button component', 'button-component', '<p><strong>Th&aacute;ch thức:</strong>&nbsp;Tạo một n&uacute;t c&oacute; thể sử dụng lại với tất cả c&aacute;c trạng th&aacute;i trong thiết kế v&agrave; một trang hiển thị tất cả c&aacute;c trạng th&aacute;i.&nbsp;Bạn c&oacute; thể l&agrave;m việc trong c&ugrave;ng một dự &aacute;n với những&nbsp;<code>design system&nbsp;</code>thử th&aacute;ch&nbsp;kh&aacute;c&nbsp;.&nbsp;Sử dụng c&aacute;c thư viện Front-end như React hoặc Vue.&nbsp;Đừng nh&igrave;n v&agrave;o giải ph&aacute;p hiện c&oacute;.&nbsp;Thực hiện c&aacute;c c&acirc;u chuyện của người d&ugrave;ng dưới đ&acirc;y:</p>\n\n<ul>\n	<li><strong>Sử dụng c&acirc;u chuyện:</strong>&nbsp;T&ocirc;i c&oacute; thể xem c&aacute;c loại n&uacute;t kh&aacute;c nhau:&nbsp;<code>default</code>,&nbsp;<code>outline&nbsp;</code>v&agrave;&nbsp;<code>text</code></li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể chọn tắt&nbsp;<code>box-shadow</code></li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể chọn tắt n&uacute;t</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể chọn c&oacute; một biểu tượng ở b&ecirc;n tr&aacute;i hoặc b&ecirc;n phải (Sử dụng Biểu tượng Google v&agrave; &iacute;t nhất 5 biến thể)</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể c&oacute; c&aacute;c k&iacute;ch thước n&uacute;t kh&aacute;c nhau</li>\n	<li><strong>C&acirc;u chuyện người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể c&oacute; nhiều m&agrave;u sắc kh&aacute;c nhau</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;Khi t&ocirc;i di chuột qua hoặc lấy n&eacute;t, t&ocirc;i c&oacute; thể thấy c&aacute;c chỉ b&aacute;o trực quan</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i vẫn c&oacute; thể truy cập tất cả c&aacute;c thuộc t&iacute;nh của n&uacute;t</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng (t&ugrave;y chọn):</strong>&nbsp;Hiển thị n&uacute;t theo c&aacute;ch tương tự như thiết kế hoặc sử dụng&nbsp;<a href=\"https://storybook.js.org/\">Storybook</a>&nbsp;.&nbsp;Nếu kh&ocirc;ng, hiển thị n&uacute;t ở nhiều trạng th&aacute;i l&agrave; đủ</li>\n</ul>\n\n<p><strong>Biểu tượng:&nbsp;</strong><a href=\"https://google.github.io/material-design-icons/\">https://google.github.io/material-design-icons/</a></p>', 'HTML/CSS thư viện react hoặc vue', 'https://www.figma.com/file/vfMDJhGGnqfaskO2aud06o?chrome=DOCUMENTATION&embed_host=astra&kind=&node-id=0%3A1&viewer=1', '', 'files/1627549033-image.png', 'files/1627549033-image-uploader-master.zip', 2, 4, '2021-07-29 08:57:13', '2021-07-29 08:57:13');
INSERT INTO `challenges` VALUES (3, '404 Not Found', '404-not-found', '<p><strong>Th&aacute;ch thức:</strong>&nbsp;Tạo trang 404 kh&ocirc;ng t&igrave;m thấy theo thiết kế.&nbsp;Trang phải đ&aacute;p ứng.&nbsp;Đừng nh&igrave;n v&agrave;o giải ph&aacute;p hiện c&oacute;.&nbsp;Thực hiện c&aacute;c c&acirc;u chuyện của người d&ugrave;ng dưới đ&acirc;y:</p>\n\n<ul>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể thấy một trang theo thiết kế đ&atilde; cho</li>\n</ul>\n\n<p>&nbsp;</p>', 'HTML/CSS', 'https://www.figma.com/embed?embed_host=astra&url=https%3A%2F%2Fwww.figma.com%2Ffile%2FQeKWLNhB13zDjJzqR22TKE%2F404-page%3Fnode-id%3D0%253A1&chrome=DOCUMENTATION', 'https://www.figma.com/file/QeKWLNhB13zDjJzqR22TKE/404-page-challenge?node-id=0%3A1', 'files/1627549353-image.png', 'files/1627549353-404-not-found-master.zip', 1, 5, '2021-07-29 09:02:33', '2021-07-31 02:51:07');
INSERT INTO `challenges` VALUES (4, 'My Unsplash', 'my-unsplash', '<p><strong>Th&aacute;ch thức:</strong>&nbsp;Tạo ứng dụng Unsplash của t&ocirc;i.&nbsp;Sử dụng c&aacute;c thư viện Front-end như React hoặc Vue.&nbsp;Tạo API của ri&ecirc;ng bạn.&nbsp;Đừng nh&igrave;n v&agrave;o giải ph&aacute;p hiện c&oacute;.&nbsp;Thực hiện c&aacute;c c&acirc;u chuyện của người d&ugrave;ng dưới đ&acirc;y:</p>\n\n<ul>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể xem danh s&aacute;ch c&aacute;c ảnh trong&nbsp;<code>masonry</code>bố cục m&agrave; t&ocirc;i đ&atilde; th&ecirc;m</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể th&ecirc;m ảnh mới v&agrave;o danh s&aacute;ch - ảnh mới phải ở đầu danh s&aacute;ch</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể t&igrave;m kiếm ảnh theo nh&atilde;n</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;Khi t&ocirc;i di chuột qua ảnh, t&ocirc;i c&oacute; thể thấy nh&atilde;n v&agrave; n&uacute;t x&oacute;a</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể x&oacute;a h&igrave;nh ảnh</li>\n	<li><strong>C&acirc;u chuyện người d&ugrave;ng (t&ugrave;y chọn):</strong>&nbsp;Khi t&ocirc;i x&oacute;a một h&igrave;nh ảnh, t&ocirc;i c&oacute; thể nhập mật khẩu của m&igrave;nh</li>\n</ul>\n\n<p><strong>Biểu tượng:&nbsp;</strong><a href=\"https://google.github.io/material-design-icons/\">https://google.github.io/material-design-icons/</a></p>', 'React hoặc Vue', 'https://www.figma.com/file/a1xUD6nInLKRz6evFKKdir/My-unsplash', 'https://www.figma.com/file/a1xUD6nInLKRz6evFKKdir/My-unsplash?node-id=0%3A1', 'files/1627549577-image.png', 'files/1627549488-my-unsplash-master.zip', 4, 1, '2021-07-29 09:04:48', '2021-08-28 12:18:35');
INSERT INTO `challenges` VALUES (5, 'CatWiki', 'catwiki', '<p><strong>Th&aacute;ch thức:</strong>&nbsp;Tạo ứng dụng CatWiki của t&ocirc;i.&nbsp;Sử dụng c&aacute;c thư viện Front-end như React hoặc Vue.js.&nbsp;Tạo API của bạn.&nbsp;Đừng nh&igrave;n v&agrave;o giải ph&aacute;p hiện c&oacute;.&nbsp;Thực hiện c&aacute;c c&acirc;u chuyện của người d&ugrave;ng dưới đ&acirc;y:</p>\n\n<p>Sử dụng https://docs.thecatapi.com/ để ho&agrave;n th&agrave;nh thử th&aacute;ch n&agrave;y.&nbsp;Ph&iacute;a m&aacute;y kh&aacute;ch kh&ocirc;ng n&ecirc;n sử dụng API trực tiếp.&nbsp;Mọi thứ n&ecirc;n được xử l&yacute; ở ph&iacute;a m&aacute;y chủ.&nbsp;V&iacute; dụ: đề xuất c&aacute;c giống hoặc lấy h&igrave;nh ảnh cho giống.</p>\n\n<ul>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể t&igrave;m kiếm c&aacute;c giống m&egrave;o v&agrave; chọn một giống m&egrave;o m&agrave; t&ocirc;i lựa chọn</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể xem t&oacute;m tắt c&aacute;c giống m&egrave;o được t&igrave;m kiếm phổ biến nhất tr&ecirc;n trang chủ</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể xem 10 giống m&egrave;o được t&igrave;m kiếm nhiều nhất</li>\n	<li><strong>C&acirc;u chuyện User:</strong>&nbsp;T&ocirc;i c&oacute; thể xem chi tiết giống như&nbsp;<code>description</code>,&nbsp;<code>temperament</code>,&nbsp;<code>origin</code>,&nbsp;<code>life span</code>,&nbsp;<code>adaptability</code>,&nbsp;<code>affection level</code>,&nbsp;<code>child-friendly</code>,&nbsp;<code>grooming</code>,&nbsp;<code>intelligence</code>,&nbsp;<code>health issues</code>,&nbsp;<code>social needs</code>,<code>stranger friendly</code></li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể xem th&ecirc;m ảnh về giống ch&oacute; n&agrave;y</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;Tr&ecirc;n thiết bị di động, khi t&ocirc;i chọn t&ugrave;y chọn t&igrave;m kiếm, một phương thức t&igrave;m kiếm giống sẽ bật l&ecirc;n</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng (t&ugrave;y chọn):</strong>&nbsp;T&ocirc;i c&oacute; thể chuyển đến b&agrave;i viết về m&egrave;o khi nhấp&nbsp;<code>read more</code>v&agrave;o mục Tại sao bạn n&ecirc;n c&oacute; m&egrave;o</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng (t&ugrave;y chọn):</strong>&nbsp;T&ocirc;i c&oacute; thể đi đến 10 con m&egrave;o h&agrave;ng đầu bằng c&aacute;ch nhấp&nbsp;<code>see more</code>v&agrave;o trang tổng quan</li>\n</ul>\n\n<p><strong>API:&nbsp;</strong><a href=\"https://docs.thecatapi.com/\">https://docs.thecatapi.com/</a></p>\n\n<p><strong>Biểu tượng:&nbsp;</strong><a href=\"https://google.github.io/material-design-icons/\">https://google.github.io/material-design-icons/</a></p>', 'React hoặc Vue.js', 'https://www.figma.com/embed?embed_host=astra&url=https%3A%2F%2Fwww.figma.com%2Ffile%2F6XLJCClikameMhnTZ3RKnM%2F404-page%3Fnode-id%3D0%253A1&chrome=DOCUMENTATION', 'https://www.figma.com/file/6XLJCClikameMhnTZ3RKnM/CatWiki?node-id=0%3A1', 'files/1627549673-image.png', 'files/1627549673-cat-wiki-master.zip', 3, 1, '2021-07-29 09:07:53', '2021-07-31 02:51:25');
INSERT INTO `challenges` VALUES (6, 'Tweeter - Bản sao Twitter', 'tweeter-ban-sao-twitter', '<p><strong>Th&aacute;ch thức:</strong>&nbsp;Tạo ứng dụng sao ch&eacute;p Twitter - Tweeter.&nbsp;Sử dụng bất kỳ thư viện front-end n&agrave;o m&agrave; bạn chọn.&nbsp;Tạo API của bạn.&nbsp;Đừng nh&igrave;n v&agrave;o giải ph&aacute;p hiện c&oacute;.&nbsp;Thực hiện c&aacute;c c&acirc;u chuyện của người d&ugrave;ng dưới đ&acirc;y:</p>\n\n<ul>\n	<li>\n	<p><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể xem hồ sơ của m&igrave;nh hoặc hồ sơ của người kh&aacute;c</p>\n	</li>\n	<li>\n	<p><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;Khi t&ocirc;i ở tr&ecirc;n một trang c&aacute; nh&acirc;n, t&ocirc;i c&oacute; thể thấy Tweets v&agrave; Retweets.&nbsp;T&ocirc;i cũng c&oacute; thể lọc theo&nbsp;<code>Tweets</code>,&nbsp;<code>Tweets and replies</code>,&nbsp;<code>Media</code>v&agrave;<code>Likes</code></p>\n	</li>\n	<li>\n	<p><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;Khi t&ocirc;i ở tr&ecirc;n hồ sơ, t&ocirc;i c&oacute; thể thấy&nbsp;<code>followers&nbsp;</code>v&agrave;&nbsp;<code>following</code></p>\n	</li>\n	<li>\n	<p><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;Khi t&ocirc;i ở tr&ecirc;n hồ sơ, t&ocirc;i c&oacute; thể thấy&nbsp;<code>follow&nbsp;</code>hoặc&nbsp;<code>unfollow&nbsp;</code>người d&ugrave;ng</p>\n	</li>\n	<li>\n	<p><strong>Sử dụng c&acirc;u chuyện:</strong>&nbsp;T&ocirc;i c&oacute; thể di chuyển giữa&nbsp;<code>Home</code>,&nbsp;<code>Explore&nbsp;</code>v&agrave;&nbsp;&nbsp;<code>Bookmarks</code></p>\n	</li>\n	<li>\n	<p><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể điều hướng đến&nbsp;<code>My Profile</code>,&nbsp;<code>Group Chat</code>(t&ugrave;y chọn)&nbsp;<code>Setting/Authentication App</code>,.</p>\n	</li>\n	<li>\n	<p><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;Khi t&ocirc;i ở tr&ecirc;n&nbsp;<code>Home</code>, t&ocirc;i c&oacute; thể đăng một Tweet mới</p>\n	</li>\n	<li>\n	<p><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;Khi t&ocirc;i đăng một Tweet mới, t&ocirc;i c&oacute; thể chọn tải l&ecirc;n một h&igrave;nh ảnh v&agrave; đặt Tweet th&agrave;nh&nbsp;<code>public</code>hoặc<code>only-follower</code></p>\n	</li>\n	<li>\n	<p><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;Khi t&ocirc;i bật&nbsp;<code>Home</code>, t&ocirc;i c&oacute; thể thấy Tweet của những người t&ocirc;i theo d&otilde;i</p>\n	</li>\n	<li>\n	<p><strong>C&acirc;u chuyện User:</strong>&nbsp;T&ocirc;i c&oacute; thể&nbsp;<code>Comment</code>,&nbsp;<code>Retweet</code>,&nbsp;<code>Like</code>hoặc&nbsp;<code>Save</code>một Tweet</p>\n	</li>\n	<li>\n	<p><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể&nbsp;<code>Comment</code>với h&igrave;nh ảnh v&agrave; t&ocirc;i c&oacute; thể th&iacute;ch một b&igrave;nh luận</p>\n	</li>\n	<li>\n	<p><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể thấy thời gian đăng của&nbsp;<code>Comments</code>v&agrave;<code>Tweets</code></p>\n	</li>\n	<li>\n	<p><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;Khi t&ocirc;i tham gia&nbsp;<code>Home</code>, t&ocirc;i c&oacute; thể thấy những người nổi tiếng nhất&nbsp;<code>hashtags</code>v&agrave; những người t&ocirc;i n&ecirc;n theo d&otilde;i (t&ugrave;y thuộc v&agrave;o bạn c&aacute;ch triển khai điều n&agrave;y)</p>\n	</li>\n	<li>\n	<p><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;Khi t&ocirc;i bật&nbsp;<code>Explore</code>, t&ocirc;i c&oacute; thể thấy&nbsp;<code>Top</code>,&nbsp;<code>Latest</code>Tweet hoặc Tweet với Media.&nbsp;T&ocirc;i cũng c&oacute; thể chọn để xem những người phổ biến nhất</p>\n	</li>\n	<li>\n	<p><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;Khi t&ocirc;i bật&nbsp;<code>Bookmarks</code>, t&ocirc;i c&oacute; thể thấy&nbsp;<code>Saved</code>Tweet</p>\n	</li>\n	<li>\n	<p><strong>C&acirc;u chuyện của người d&ugrave;ng (t&ugrave;y chọn):</strong>&nbsp;T&ocirc;i c&oacute; thể t&igrave;m kiếm một nh&oacute;m</p>\n	</li>\n</ul>\n\n<p>Bạn c&oacute; thể sử dụng&nbsp;<a href=\"https://devchallenges.io/challenges/N1fvBjQfhlkctmwj1tnw\">Thử th&aacute;ch x&aacute;c thực</a>&nbsp;hoặc tạo ứng dụng x&aacute;c thực của ri&ecirc;ng m&igrave;nh cho thử th&aacute;ch n&agrave;y.</p>\n\n<p>Bạn c&oacute; thể kiểm tra&nbsp;<a href=\"https://twitter.com/home\">Twitter</a>&nbsp;để biết c&aacute;c tương t&aacute;c.</p>\n\n<p><strong>Biểu tượng:&nbsp;</strong><a href=\"https://google.github.io/material-design-icons/\">https://google.github.io/material-design-icons/</a></p>\n\n<p>Sau khi bạn ho&agrave;n th&agrave;nh, h&atilde;y gửi c&aacute;c giải ph&aacute;p của bạn bằng c&aacute;ch cung cấp&nbsp;<strong>URL cho cả kho lưu trữ GitHub v&agrave; ứng dụng trực tiếp</strong>&nbsp;tr&ecirc;n bất kỳ nền tảng lưu trữ n&agrave;o (&nbsp;<a href=\"https://blogs.devchallenges.io/posts/tJ26U8MhZTPgBSRSwpqr\" target=\"_blank\">5</a>&nbsp;Nền tảng lưu trữ&nbsp;<a href=\"https://blogs.devchallenges.io/posts/tJ26U8MhZTPgBSRSwpqr\" target=\"_blank\">miễn ph&iacute;</a>&nbsp;) v&agrave; giải th&iacute;ch ngắn gọn những g&igrave; bạn đ&atilde; l&agrave;m.</p>\n\n<p>Miễn l&agrave; bạn ho&agrave;n th&agrave;nh tất cả c&aacute;c c&acirc;u chuyện của người d&ugrave;ng, bạn c&oacute; thể tạo dấu ấn c&aacute; nh&acirc;n của m&igrave;nh bằng c&aacute;ch th&ecirc;m chuyển tiếp, sử dụng h&igrave;nh ảnh của ri&ecirc;ng bạn, thay đổi m&agrave;u sắc, ...</p>\n\n<p>H&atilde;y nhớ đặt t&ecirc;n của bạn ở ch&acirc;n trang để ngăn người kh&aacute;c gửi giải ph&aacute;p của bạn.</p>\n\n<p>Bạn c&oacute; thể kiểm tra c&aacute;c giải ph&aacute;p của người kh&aacute;c v&agrave; đưa ra phản hồi cho họ.</p>', 'Dùng bất kỳ thư viện front-end nào', 'https://www.figma.com/embed?embed_host=astra&url=https%3A%2F%2Fwww.figma.com%2Ffile%2Fxxf4TG14lpF3vFUbBtEZUR%2F404-page%3Fnode-id%3D0%253A1&chrome=DOCUMENTATION', 'https://www.figma.com/file/xxf4TG14lpF3vFUbBtEZUR/Tweeter', 'files/1627549845-image.png', 'files/1627549845-tweeter-master.zip', 3, 1, '2021-07-29 09:10:45', '2021-07-31 02:51:30');
INSERT INTO `challenges` VALUES (7, 'Input component', 'input-component', '<p><strong>Th&aacute;ch thức:</strong>&nbsp;Tạo một đầu v&agrave;o c&oacute; thể t&aacute;i sử dụng với tất cả c&aacute;c trạng th&aacute;i trong thiết kế v&agrave; một trang hiển thị tất cả c&aacute;c trạng th&aacute;i.&nbsp;Bạn c&oacute; thể l&agrave;m việc trong c&ugrave;ng một dự &aacute;n với những&nbsp;<code>design system</code>thử th&aacute;ch&nbsp;kh&aacute;c&nbsp;.&nbsp;Sử dụng c&aacute;c thư viện Front-end như React hoặc Vue.&nbsp;Đừng nh&igrave;n v&agrave;o giải ph&aacute;p hiện c&oacute;.&nbsp;Thực hiện c&aacute;c c&acirc;u chuyện của người d&ugrave;ng dưới đ&acirc;y:</p>\n\n<ul>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể thấy trạng th&aacute;i lỗi</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể chọn tắt đầu v&agrave;o</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể chọn để c&oacute; văn bản trợ gi&uacute;p</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể chọn c&oacute; một biểu tượng ở b&ecirc;n tr&aacute;i hoặc b&ecirc;n phải (Sử dụng Biểu tượng Google v&agrave; &iacute;t nhất 5 biến thể)</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể c&oacute; c&aacute;c k&iacute;ch thước đầu v&agrave;o kh&aacute;c nhau</li>\n	<li><strong>C&acirc;u chuyện người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể c&oacute; nhiều m&agrave;u sắc kh&aacute;c nhau</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể chọn để đầu v&agrave;o c&oacute; chiều rộng của gi&aacute; trị gốc</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể c&oacute; đầu v&agrave;o nhiều d&ograve;ng như một<code>textarea</code></li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;Khi t&ocirc;i di chuột qua hoặc lấy n&eacute;t, t&ocirc;i c&oacute; thể thấy c&aacute;c chỉ b&aacute;o trực quan</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i vẫn c&oacute; thể truy cập tất cả c&aacute;c thuộc t&iacute;nh đầu v&agrave;o</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng (t&ugrave;y chọn):</strong>&nbsp;Hiển thị đầu v&agrave;o theo c&aacute;ch tương tự như thiết kế hoặc sử dụng&nbsp;<a href=\"https://storybook.js.org/\">Storybook</a>&nbsp;.&nbsp;Nếu kh&ocirc;ng, hiển thị đầu v&agrave;o ở nhiều trạng th&aacute;i l&agrave; đủ</li>\n</ul>\n\n<p><strong>Biểu tượng:&nbsp;</strong><a href=\"https://google.github.io/material-design-icons/\">https://google.github.io/material-design-icons/</a></p>', 'React hoặc Vue', 'https://www.figma.com/embed?embed_host=astra&url=https%3A%2F%2Fwww.figma.com%2Ffile%2FslzHnI05qpbBeC33ZMZGa5%2F404-page%3Fnode-id%3D0%253A1&chrome=DOCUMENTATION', 'https://www.figma.com/file/slzHnI05qpbBeC33ZMZGa5/input-component', 'files/1627550611-image.png', 'files/1627550611-input-component-master.zip', 3, 4, '2021-07-29 09:23:31', '2021-07-31 02:51:40');
INSERT INTO `challenges` VALUES (8, 'Windbnb', 'windbnb', '<p><strong>Thử th&aacute;ch:</strong>&nbsp;Tạo một phi&ecirc;n bản nhỏ của Airbnb - Windbnb với dữ liệu đ&atilde; cho.&nbsp;Sử dụng c&aacute;c thư viện Front-end như React hoặc Vue.&nbsp;Đừng nh&igrave;n v&agrave;o giải ph&aacute;p hiện c&oacute;.&nbsp;Thực hiện c&aacute;c c&acirc;u chuyện của người d&ugrave;ng dưới đ&acirc;y:</p>\n\n<ul>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể xem danh s&aacute;ch c&aacute;c t&agrave;i sản</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể thấy thẻ t&agrave;i sản với t&ecirc;n, xếp hạng, loại căn hộ v&agrave; si&ecirc;u chủ nh&agrave;</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể mở ngăn bộ lọc</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể lọc c&aacute;c thuộc t&iacute;nh theo vị tr&iacute; v&agrave; số lượng kh&aacute;ch</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể thấy số lượng mục đ&atilde; lọc</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể thấy c&aacute;c trang sau c&aacute;c thiết kế nhất định</li>\n</ul>\n\n<p><strong>Biểu tượng:&nbsp;</strong><a href=\"https://google.github.io/material-design-icons/\">https://google.github.io/material-design-icons/</a></p>', 'React hoặc Vue', 'https://www.figma.com/embed?embed_host=astra&url=https%3A%2F%2Fwww.figma.com%2Ffile%2FKGNH8dbclXT1vzXLyPrBeu%2F404-page%3Fnode-id%3D0%253A1&chrome=DOCUMENTATION', 'https://www.figma.com/file/KGNH8dbclXT1vzXLyPrBeu/Windbnb', 'files/1627551358-image.png', 'files/1627551358-windbnb-master.zip', 3, 4, '2021-07-29 09:35:58', '2021-07-31 02:52:26');
INSERT INTO `challenges` VALUES (9, 'Todo app', 'todo-app', '<p><strong>Th&aacute;ch thức:</strong>&nbsp;Tạo một ứng dụng todo theo c&aacute;c thiết kế đ&atilde; cho.&nbsp;Sử dụng c&aacute;c thư viện Front-end như React hoặc Vue.&nbsp;Đừng nh&igrave;n v&agrave;o giải ph&aacute;p hiện c&oacute;.&nbsp;Thực hiện c&aacute;c c&acirc;u chuyện của người d&ugrave;ng dưới đ&acirc;y:</p>\n\n<ul>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể th&ecirc;m một nhiệm vụ mới</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể ho&agrave;n th&agrave;nh một nhiệm vụ</li>\n	<li><strong>Sử dụng c&acirc;u chuyện:</strong>&nbsp;T&ocirc;i c&oacute; thể chuyển đổi giữa&nbsp;<code>All</code>,&nbsp;<code>Active&nbsp;</code>v&agrave;&nbsp;<code>Completed</code></li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể x&oacute;a một hoặc tất cả c&aacute;c nhiệm vụ trong&nbsp;<code>Completed</code>tab</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng (t&ugrave;y chọn):</strong>&nbsp;Lưu trữ dữ liệu trong bộ nhớ cục bộ m&agrave; khi t&ocirc;i l&agrave;m mới trang, t&ocirc;i vẫn c&oacute; thể thấy tiến tr&igrave;nh của m&igrave;nh</li>\n</ul>\n\n<p><strong>Biểu tượng:&nbsp;</strong><a href=\"https://google.github.io/material-design-icons/\">https://google.github.io/material-design-icons/</a></p>', 'React hoặc Vue', 'https://www.figma.com/embed?embed_host=astra&url=https%3A%2F%2Fwww.figma.com%2Ffile%2FSClDA1weEGA3Mo8Is8Sbf2%2F404-page%3Fnode-id%3D0%253A1&chrome=DOCUMENTATION', 'https://www.figma.com/file/SClDA1weEGA3Mo8Is8Sbf2/todo?node-id=0%3A1', 'files/1627551485-image.png', 'files/1627551485-todo-app-master.zip', 2, 4, '2021-07-29 09:38:05', '2021-07-31 02:51:45');
INSERT INTO `challenges` VALUES (10, 'Trình tạo báo giá ngẫu nhiên', 'trinh-tao-bao-gia-ngau-nhien', '<p><strong>Th&aacute;ch thức:</strong>&nbsp;Tạo một ứng dụng tạo b&aacute;o gi&aacute;.&nbsp;Sử dụng c&aacute;c thư viện Front-end như React hoặc Vue.&nbsp;Đừng nh&igrave;n v&agrave;o giải ph&aacute;p hiện c&oacute;.&nbsp;Thực hiện c&aacute;c c&acirc;u chuyện của người d&ugrave;ng dưới đ&acirc;y:</p>\n\n<ul>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể thấy một tr&iacute;ch dẫn ngẫu nhi&ecirc;n</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i tạo một tr&iacute;ch dẫn ngẫu nhi&ecirc;n mới</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;Khi t&ocirc;i chọn t&aacute;c giả tr&iacute;ch dẫn, t&ocirc;i c&oacute; thể xem danh s&aacute;ch c&aacute;c tr&iacute;ch dẫn từ họ</li>\n	<li><strong>Truyện người d&ugrave;ng:</strong>&nbsp;M&igrave;nh c&oacute; thể xem thể loại quote dưới t&aacute;c giả</li>\n</ul>\n\n<p><strong>Biểu tượng:&nbsp;</strong><a href=\"https://google.github.io/material-design-icons/\">https://google.github.io/material-design-icons/</a></p>\n\n<p><strong>API:&nbsp;</strong><a href=\"https://pprathameshmore.github.io/QuoteGarden/\">https://pprathameshmore.github.io/QuoteGarden/</a></p>', 'React hoặc Vue', 'https://www.figma.com/embed?embed_host=astra&url=https%3A%2F%2Fwww.figma.com%2Ffile%2FFFxqnf1cEDiHhvFpN6u4hV%2F404-page%3Fnode-id%3D0%253A1&chrome=DOCUMENTATION', 'https://www.figma.com/file/FFxqnf1cEDiHhvFpN6u4hV/quote?node-id=0%3A1', 'files/1627551584-image.png', 'files/1627551584-quote-generator-master.zip', 2, 4, '2021-07-29 09:39:44', '2021-07-31 02:51:55');
INSERT INTO `challenges` VALUES (11, 'Câu đố quốc gia', 'cau-do-quoc-gia', '<p><strong>Th&aacute;ch thức:</strong>&nbsp;Tạo ứng dụng c&acirc;u đố quốc gia bằng API.&nbsp;Sử dụng c&aacute;c thư viện Front-end như React hoặc Vue.&nbsp;Đừng nh&igrave;n v&agrave;o giải ph&aacute;p hiện c&oacute;.&nbsp;Thực hiện c&aacute;c c&acirc;u chuyện của người d&ugrave;ng dưới đ&acirc;y:</p>\n\n<ul>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể thấy &iacute;t nhất 2 loại c&acirc;u hỏi:&nbsp;<code>a city is the capital of..</code>hoặc<code>a flag belong to country..</code></li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể chọn một c&acirc;u trả lời</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể xem c&acirc;u trả lời của m&igrave;nh l&agrave; đ&uacute;ng hay sai</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;Khi t&ocirc;i trả lời đ&uacute;ng, t&ocirc;i c&oacute; thể chuyển sang c&acirc;u hỏi tiếp theo</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;Khi t&ocirc;i trả lời sai, t&ocirc;i c&oacute; thể xem kết quả của m&igrave;nh v&agrave; thử lại</li>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể thử lại</li>\n</ul>\n\n<p><strong>Biểu tượng:&nbsp;</strong><a href=\"https://google.github.io/material-design-icons/\">https://google.github.io/material-design-icons/</a></p>\n\n<p><strong>API:&nbsp;</strong><a href=\"https://restcountries.eu/\">https://restcountries.eu/</a>&nbsp;.&nbsp;Sử dụng dữ liệu từ API để tạo c&acirc;u hỏi v&agrave; c&acirc;u trả lời.</p>', 'React hoặc Vue', 'https://www.figma.com/embed?embed_host=astra&url=https%3A%2F%2Fwww.figma.com%2Ffile%2FGw0ZNBbYN8asqFlZWy3jG1%2F404-page%3Fnode-id%3D0%253A1&chrome=DOCUMENTATION', 'https://www.figma.com/file/Gw0ZNBbYN8asqFlZWy3jG1/Country-Quiz', 'files/1627551710-image.png', 'files/1627551710-country-quiz-master.zip', 3, 4, '2021-08-01 09:41:50', '2021-08-01 02:52:00');
INSERT INTO `challenges` VALUES (12, 'Nhóm của tôi', 'nhom-cua-toi', '<p><strong>Th&aacute;ch thức:</strong>&nbsp;Tạo trang nh&oacute;m của t&ocirc;i theo thiết kế.&nbsp;Trang phải đ&aacute;p ứng.&nbsp;Đừng nh&igrave;n v&agrave;o giải ph&aacute;p hiện c&oacute;.&nbsp;Thực hiện c&aacute;c c&acirc;u chuyện của người d&ugrave;ng b&ecirc;n dưới</p>\n\n<ul>\n	<li><strong>C&acirc;u chuyện của người d&ugrave;ng:</strong>&nbsp;T&ocirc;i c&oacute; thể thấy một trang theo thiết kế đ&atilde; cho</li>\n</ul>', 'HTML/CSS JS', 'https://www.figma.com/embed?embed_host=astra&url=https%3A%2F%2Fwww.figma.com%2Ffile%2FF8d1qJsorEdY47N74HLxQ4%2F404-page%3Fnode-id%3D0%253A1&chrome=DOCUMENTATION', 'https://www.figma.com/file/F8d1qJsorEdY47N74HLxQ4/team-page-challenge', 'files/1627551817-image.png', 'files/1627551817-my-team-page-master.zip', 2, 5, '2021-08-01 09:43:37', '2021-08-01 02:52:07');
COMMIT;

-- ----------------------------
-- Table structure for chat_messages
-- ----------------------------
DROP TABLE IF EXISTS `chat_messages`;
CREATE TABLE `chat_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `chat_room_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `message` mediumtext,
  `image` varchar(191) DEFAULT NULL,
  `receiver_id` int(10) unsigned DEFAULT NULL,
  `time` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chat_messages_chat_room_id_foreign` (`chat_room_id`),
  KEY `chat_messages_user_id_foreign` (`user_id`),
  CONSTRAINT `chat_messages_chat_room_id_foreign` FOREIGN KEY (`chat_room_id`) REFERENCES `chat_rooms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chat_messages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of chat_messages
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chat_rooms
-- ----------------------------
DROP TABLE IF EXISTS `chat_rooms`;
CREATE TABLE `chat_rooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `image` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of chat_rooms
-- ----------------------------
BEGIN;
INSERT INTO `chat_rooms` VALUES (1, 'General', 'files/1627698467-image.png', NULL, NULL);
INSERT INTO `chat_rooms` VALUES (2, 'Teck talk', 'files/1627698467-image.png', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for feedbacks
-- ----------------------------
DROP TABLE IF EXISTS `feedbacks`;
CREATE TABLE `feedbacks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `feedback_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `solution_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` int(10) unsigned DEFAULT '0',
  `is_approved` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `feedbacks_solution_id_foreign` (`solution_id`),
  KEY `feedbacks_user_id_foreign` (`user_id`),
  CONSTRAINT `feedbacks_solution_id_foreign` FOREIGN KEY (`solution_id`) REFERENCES `solutions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `feedbacks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of feedbacks
-- ----------------------------
BEGIN;
INSERT INTO `feedbacks` VALUES (9, '<p>Aadsasd</p>', 1, 'a3cfe3d7-cfb9-433e-ae72-06199a55d643', 0, 0, '2021-08-27 13:53:17', '2021-08-27 13:53:17');
COMMIT;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of migrations
-- ----------------------------
BEGIN;
INSERT INTO `migrations` VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (8, '2021_05_27_095755_create_challenge_categories_table', 1);
INSERT INTO `migrations` VALUES (9, '2021_05_27_104100_create_challenges_table', 1);
INSERT INTO `migrations` VALUES (10, '2021_05_27_104151_create_solutions_table', 1);
INSERT INTO `migrations` VALUES (11, '2021_05_27_104257_create_feedbacks_table', 1);
INSERT INTO `migrations` VALUES (12, '2021_05_29_091858_create_messages_table', 1);
INSERT INTO `migrations` VALUES (13, '2021_05_29_092229_create_notifications_table', 1);
INSERT INTO `migrations` VALUES (14, '2021_06_01_014607_create_failed_jobs_table', 1);
INSERT INTO `migrations` VALUES (15, '2021_06_03_024436_create_challenge_users_table', 1);
INSERT INTO `migrations` VALUES (16, '2021_06_07_070717_create_permission_tables', 1);
INSERT INTO `migrations` VALUES (17, '2021_06_11_032709_create_solution_users_table', 1);
INSERT INTO `migrations` VALUES (23, '2016_06_01_000001_create_oauth_auth_codes_table', 2);
INSERT INTO `migrations` VALUES (24, '2016_06_01_000002_create_oauth_access_tokens_table', 2);
INSERT INTO `migrations` VALUES (25, '2016_06_01_000003_create_oauth_refresh_tokens_table', 2);
INSERT INTO `migrations` VALUES (26, '2016_06_01_000004_create_oauth_clients_table', 2);
INSERT INTO `migrations` VALUES (27, '2016_06_01_000005_create_oauth_personal_access_clients_table', 2);
INSERT INTO `migrations` VALUES (30, '2021_07_25_094500_create_chat_rooms_table', 3);
INSERT INTO `migrations` VALUES (31, '2021_07_25_094633_create_chat_messages_table', 3);
INSERT INTO `migrations` VALUES (35, '2021_08_11_160509_create_upgrades_table', 4);
INSERT INTO `migrations` VALUES (36, '2021_08_11_160901_create_orders_table', 4);
INSERT INTO `migrations` VALUES (37, '2021_08_16_082359_create_upvotes_table', 5);
INSERT INTO `migrations` VALUES (39, '2021_08_17_180012_create_upvote_feedbacks_table', 6);
COMMIT;

-- ----------------------------
-- Table structure for model_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE `model_has_permissions` (
  `permission_id` int(10) unsigned NOT NULL,
  `model_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` int(11) NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of model_has_permissions
-- ----------------------------
BEGIN;
INSERT INTO `model_has_permissions` VALUES (22, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (23, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (29, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (30, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (31, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (32, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (22, 'App\\Models\\User', 16);
INSERT INTO `model_has_permissions` VALUES (23, 'App\\Models\\User', 16);
INSERT INTO `model_has_permissions` VALUES (29, 'App\\Models\\User', 16);
INSERT INTO `model_has_permissions` VALUES (30, 'App\\Models\\User', 16);
INSERT INTO `model_has_permissions` VALUES (31, 'App\\Models\\User', 16);
INSERT INTO `model_has_permissions` VALUES (32, 'App\\Models\\User', 16);
COMMIT;

-- ----------------------------
-- Table structure for model_has_roles
-- ----------------------------
DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE `model_has_roles` (
  `role_id` int(10) unsigned NOT NULL,
  `model_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of model_has_roles
-- ----------------------------
BEGIN;
INSERT INTO `model_has_roles` VALUES (2, 'App\\Models\\User', 1);
INSERT INTO `model_has_roles` VALUES (1, 'App\\Models\\User', 14);
INSERT INTO `model_has_roles` VALUES (6, 'App\\Models\\User', 16);
INSERT INTO `model_has_roles` VALUES (1, 'App\\Models\\User', 17);
INSERT INTO `model_has_roles` VALUES (1, 'App\\Models\\User', 18);
COMMIT;

-- ----------------------------
-- Table structure for notifications
-- ----------------------------
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_user_id_foreign` (`user_id`),
  CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of notifications
-- ----------------------------
BEGIN;
INSERT INTO `notifications` VALUES (1, 1, 'Nâng cấp tài khoản thành công', '<p>N&acirc;ng cấp t&agrave;i khoản th&agrave;nh c&ocirc;ng bạn sẽ được nhận th&ecirc;m nhiều thử th&aacute;ch kh&oacute; hơn</p>', 1, '2021-08-25 16:58:01', '2021-08-25 18:09:13');
COMMIT;

-- ----------------------------
-- Table structure for oauth_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oauth_access_tokens
-- ----------------------------
BEGIN;
INSERT INTO `oauth_access_tokens` VALUES ('04f94ed09ce7030a6a0db0645f640eb98fc3f68241f4513557d5374c615e128288db9e7b8a602274', 6, 1, 'Personal Access Token', '[]', 0, '2021-08-16 23:55:08', '2021-08-16 23:55:08', '2022-08-16 23:55:08');
INSERT INTO `oauth_access_tokens` VALUES ('0a9b695c9c946603147f6d9184592b9d270a4c59dc6b7bcba410d877e593cba7c4e2ab3f7953dc99', 12, 1, 'Personal Access Token', '[]', 0, '2021-08-14 21:23:59', '2021-08-14 21:23:59', '2022-08-14 21:23:59');
INSERT INTO `oauth_access_tokens` VALUES ('0bba21c75c92865279d3d5c1cd67dbdb1bdecddfe44de78dff184bd1564d38325880781749e85521', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-17 09:57:04', '2021-08-17 09:57:04', '2022-08-17 09:57:04');
INSERT INTO `oauth_access_tokens` VALUES ('0cbf50ea24868655caac780756cc37fc2dc6f6dad5cef0338c27cc598ca0b971fb22d79d447d27a2', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-15 13:54:38', '2021-08-15 13:54:38', '2022-08-15 13:54:38');
INSERT INTO `oauth_access_tokens` VALUES ('0cce334bd5d42326171cddee939df0184fce172b2c1a0a69b6b36931fa8405aabfe9a6c897dd9ae2', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-23 10:29:37', '2021-08-23 10:29:37', '2022-08-23 10:29:37');
INSERT INTO `oauth_access_tokens` VALUES ('1358acc3d8aaf7c00fde7cfaf4afecff0bc6a778fd3d9bbeaf4965a5e7c716ad80597d9cc8670fba', 6, 1, 'Personal Access Token', '[]', 0, '2021-08-08 00:16:51', '2021-08-08 00:16:51', '2022-08-08 00:16:51');
INSERT INTO `oauth_access_tokens` VALUES ('175041ee024faed43b06366c9bf9f79db5382f6ab06ca1cc2d37e01dac8fa94d7c9eed852167a7bc', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-14 21:52:21', '2021-08-14 21:52:21', '2022-08-14 21:52:21');
INSERT INTO `oauth_access_tokens` VALUES ('1904fda26595bbd0d480eb86407782eabbd03f283dcf55da57593518b127a449a7e106cdd6afd787', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-17 17:03:22', '2021-08-17 17:03:22', '2022-08-17 17:03:22');
INSERT INTO `oauth_access_tokens` VALUES ('1b0d80356c2901341e1f51e935bc758ed6d297aea75e6870ed5c83540da98b00bc973954814b428f', 1, 1, 'Personal Access Token', '[]', 1, '2021-08-18 14:46:14', '2021-08-18 14:46:14', '2022-08-18 14:46:14');
INSERT INTO `oauth_access_tokens` VALUES ('1d145ea39e1f9416e880101753f03f7a3636571bfb57c641c965a5fc47cb7716b19da1a63f19b885', 1, 1, 'Personal Access Token', '[]', 1, '2021-08-27 18:45:47', '2021-08-27 18:45:47', '2022-08-27 18:45:47');
INSERT INTO `oauth_access_tokens` VALUES ('21729825c4d33d33dd4c6572f6b8c52d7b90f866a8f413afc189e0bb6bcd122db41d893953a4fbb2', 16, 1, 'Personal Access Token', '[]', 0, '2021-08-28 13:41:53', '2021-08-28 13:41:53', '2022-08-28 13:41:53');
INSERT INTO `oauth_access_tokens` VALUES ('2b01507e67e808995777601ad22cd7171fc10818feb34486e638584d010d347494953a7825158b8f', 12, 1, 'Personal Access Token', '[]', 0, '2021-08-14 21:30:02', '2021-08-14 21:30:02', '2022-08-14 21:30:02');
INSERT INTO `oauth_access_tokens` VALUES ('2d6874f4d5240c4ea917df6bee2185da239c1108c1c33627f12eec1f7512eaa05b9352f6a89a38c3', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-28 11:44:51', '2021-08-28 11:44:51', '2022-08-28 11:44:51');
INSERT INTO `oauth_access_tokens` VALUES ('2f37d6fb4314de8c29fa8532611158b87835d0a38da8b93db9a7232752b020f8a949b5e4ef5decb2', 12, 1, 'Personal Access Token', '[]', 0, '2021-08-14 21:24:15', '2021-08-14 21:24:15', '2022-08-14 21:24:15');
INSERT INTO `oauth_access_tokens` VALUES ('343bc2f0eb4cd02fe94cbb7a95155a672fe9d1dcb5de273d598da1e7a1476a814ba5f4c70bde67c8', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-17 09:57:04', '2021-08-17 09:57:04', '2022-08-17 09:57:04');
INSERT INTO `oauth_access_tokens` VALUES ('3662186d361aae917019b9df6106dcaf5687b1df2eb42f773961ed444c2b715b2cd6850fcc34fb93', 14, 1, 'Personal Access Token', '[]', 0, '2021-08-18 17:30:00', '2021-08-18 17:30:00', '2022-08-18 17:30:00');
INSERT INTO `oauth_access_tokens` VALUES ('3719760568cfa84dabc064aad326a3bf9eb18e3f740bbe5fe79304403431a866a8327ea2fa8db0fe', 12, 1, 'Personal Access Token', '[]', 0, '2021-08-14 21:24:02', '2021-08-14 21:24:02', '2022-08-14 21:24:02');
INSERT INTO `oauth_access_tokens` VALUES ('383a17350d1ca436f95b88fe6b5a932e424dcc978207b67535e63609f6c8bf77586bca730de314c0', 1, 1, 'Personal Access Token', '[]', 1, '2021-08-14 21:50:45', '2021-08-14 21:50:45', '2022-08-14 21:50:45');
INSERT INTO `oauth_access_tokens` VALUES ('38ced18c407ff9deff68eb7d7dca88f354dbabd5e788f7188835caacb8e2523c6f19c0d6cbba0f04', 14, 1, 'Personal Access Token', '[]', 1, '2021-08-15 22:06:13', '2021-08-15 22:06:13', '2022-08-15 22:06:13');
INSERT INTO `oauth_access_tokens` VALUES ('38d5df0cd80a6afaafabefd6505ce2646294e38335ebb1ae13a91f98c29ccdbbf7cded1b07084986', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-11 19:38:49', '2021-08-11 19:38:49', '2022-08-11 19:38:49');
INSERT INTO `oauth_access_tokens` VALUES ('3a7156f3fb286d530ae633b0c8a5894fa5c017ce2adb31dd5da59ab43a37b91af30a465b8d248728', 11, 1, 'Personal Access Token', '[]', 0, '2021-08-14 20:26:17', '2021-08-14 20:26:17', '2022-08-14 20:26:17');
INSERT INTO `oauth_access_tokens` VALUES ('3e2ccaa71609f0e8e1f14ddd8d2c5bb63aeb12d04d2b151719fdc0150bedaa29abf3b14c41b2a11c', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-12 15:35:20', '2021-08-12 15:35:20', '2022-08-12 15:35:20');
INSERT INTO `oauth_access_tokens` VALUES ('48fa82772023dd6dd87b7906b2dc847a6cc5742c2427e2d7a7388c8ede116912dc0169fda1b5e710', 1, 1, 'Personal Access Token', '[]', 1, '2021-08-14 21:05:32', '2021-08-14 21:05:32', '2022-08-14 21:05:32');
INSERT INTO `oauth_access_tokens` VALUES ('50e4da2f0469dbe6a4e1d50c8915eb7e4306ab6bf8cd20a1a2195ad7d21d989b9a3a0e0fec4ab0b2', 14, 1, 'Personal Access Token', '[]', 1, '2021-08-14 21:46:00', '2021-08-14 21:46:00', '2022-08-14 21:46:00');
INSERT INTO `oauth_access_tokens` VALUES ('50f47ce871bc3481313386c56b4e19623cf17751be2625c4263faa2fc9c4eb6ba04e09298517c794', 1, 1, 'Personal Access Token', '[]', 1, '2021-08-27 19:02:21', '2021-08-27 19:02:21', '2022-08-27 19:02:21');
INSERT INTO `oauth_access_tokens` VALUES ('5622c7db8aa8b7e7405bdb4fe5b2349abb87da7342f6d05e445746f068950c8958ca76a83af2dc85', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-13 22:21:05', '2021-08-13 22:21:05', '2022-08-13 22:21:05');
INSERT INTO `oauth_access_tokens` VALUES ('5e52c9361f3a092daf5ee4f6d942cb28fe57640e129ccfcae57b92e7ce732b1db3f1c174a048029a', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-17 09:57:04', '2021-08-17 09:57:04', '2022-08-17 09:57:04');
INSERT INTO `oauth_access_tokens` VALUES ('5f7c1763d262ae655d441c5278e45eb19b7447c12819b011795f5262b659599dbe019d221147bdb5', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-16 16:31:45', '2021-08-16 16:31:45', '2022-08-16 16:31:45');
INSERT INTO `oauth_access_tokens` VALUES ('60054ecf90690b0ef6f3abaf2616b64b23a7e6cac2d50748ec1fa309671a9a8d3ccc4822e2974c38', 1, 1, 'Personal Access Token', '[]', 1, '2021-08-15 13:54:38', '2021-08-15 13:54:38', '2022-08-15 13:54:38');
INSERT INTO `oauth_access_tokens` VALUES ('616ae9a0d24a80fe4ce44f3ab2a84c6794f630349b5e42290d122bd7383c5ed6382bf4a0a18bec2b', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-12 23:46:32', '2021-08-12 23:46:32', '2022-08-12 23:46:32');
INSERT INTO `oauth_access_tokens` VALUES ('6272041fad52d357824fbd1f751809e2aaa03c7ae8fc494a2a8e2f84e35030115e184f49dd95a5e1', 1, 1, 'Personal Access Token', '[]', 1, '2021-08-08 00:15:35', '2021-08-08 00:15:35', '2022-08-08 00:15:35');
INSERT INTO `oauth_access_tokens` VALUES ('62fe08e2b4a7615504b16ab1f6d02bd093cceda4fa91c7e222b99df64bc636d1ecda299e1b5392bf', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-13 22:23:35', '2021-08-13 22:23:35', '2022-08-13 22:23:35');
INSERT INTO `oauth_access_tokens` VALUES ('6a247434dbe7da42ad5b950d32baeabfe4d81ad053c26e82043a48492b9975d602df711a1d063707', 10, 1, 'Personal Access Token', '[]', 0, '2021-08-14 20:25:21', '2021-08-14 20:25:21', '2022-08-14 20:25:21');
INSERT INTO `oauth_access_tokens` VALUES ('6aa82fb2b131837e6226d3c2576b9cc7559219a64026d2488a2da922fa24556cf61f98b7c88b049b', 12, 1, 'Personal Access Token', '[]', 0, '2021-08-14 21:23:53', '2021-08-14 21:23:53', '2022-08-14 21:23:53');
INSERT INTO `oauth_access_tokens` VALUES ('6db413b2c1ede2d05d2281ce666f4837699aba3f7fddb40c7e7adcceb76a0b82870a66094b373cf8', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-12 22:22:10', '2021-08-12 22:22:10', '2022-08-12 22:22:10');
INSERT INTO `oauth_access_tokens` VALUES ('6e4fdc1c55fe5642d5211d1c21bcb1ce7f93183fb3207f328f91808822e70b5a590e7f97041c26cd', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-17 09:57:06', '2021-08-17 09:57:06', '2022-08-17 09:57:06');
INSERT INTO `oauth_access_tokens` VALUES ('6eec0421be16ec2ea08362d1cc12ec54da226ffc0d2526eb7e7556900322cd0b5a811cc1eafcf6f2', 1, 1, 'Personal Access Token', '[]', 1, '2021-08-18 23:20:44', '2021-08-18 23:20:44', '2022-08-18 23:20:44');
INSERT INTO `oauth_access_tokens` VALUES ('6f3ab7be812827365f92047b2c2362fcfcf19a28f3d9384fd6ddda1c48b168e35cd5832ddfbe2cf6', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-17 09:57:06', '2021-08-17 09:57:06', '2022-08-17 09:57:06');
INSERT INTO `oauth_access_tokens` VALUES ('7787e9ea29a6698896c19c1a4f953477ecef465ccc39a3393a4dc821de2bfb144637f6909008c6d0', 1, 1, 'Personal Access Token', '[]', 1, '2021-08-12 20:32:29', '2021-08-12 20:32:29', '2022-08-12 20:32:29');
INSERT INTO `oauth_access_tokens` VALUES ('778fe1d8c6aa4ab97523edaef0c4bf576a42d3cdbd70d8b5ec7503ea3ca5dfcb4bc3038c9b7387bc', 14, 1, 'Personal Access Token', '[]', 1, '2021-08-18 16:47:30', '2021-08-18 16:47:30', '2022-08-18 16:47:30');
INSERT INTO `oauth_access_tokens` VALUES ('78d57cbdb5f342b519afb2d9251c80558408711540faa65f9b296a8a459010bd8a4d117750248be3', 1, 1, 'Personal Access Token', '[]', 1, '2021-08-27 08:20:00', '2021-08-27 08:20:00', '2022-08-27 08:20:00');
INSERT INTO `oauth_access_tokens` VALUES ('7bbd9332e7303c4a35c139b727f6adee15befa5acebdce47b1ad55c44e72696fd7e89524d590da6d', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-14 21:05:31', '2021-08-14 21:05:31', '2022-08-14 21:05:31');
INSERT INTO `oauth_access_tokens` VALUES ('8014ee2ecfe4cc259646da313624e5f6640f833c3d665fd3cad5b338020935a6d03498d8840544c3', 18, 1, 'Personal Access Token', '[]', 1, '2021-08-27 19:01:12', '2021-08-27 19:01:12', '2022-08-27 19:01:12');
INSERT INTO `oauth_access_tokens` VALUES ('814fe031a54076c6c7985ff6464192a2591e95acaf72b6fcb471c73c8e3f75f937daeeb8d6fc1058', 12, 1, 'Personal Access Token', '[]', 0, '2021-08-14 21:23:56', '2021-08-14 21:23:56', '2022-08-14 21:23:56');
INSERT INTO `oauth_access_tokens` VALUES ('81b5fe7744d5c1dbc128ea3ccb9d072e696a9224b860867f9b81d5efcc1e05a47964741b6c215341', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-26 09:01:00', '2021-08-26 09:01:00', '2022-08-26 09:01:00');
INSERT INTO `oauth_access_tokens` VALUES ('842ef6ad83f2a613780c06d9c96d96f115d11a68d1a9f11aaf295273754344aa6abbfdc8d544bb5d', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-17 17:39:35', '2021-08-17 17:39:35', '2022-08-17 17:39:35');
INSERT INTO `oauth_access_tokens` VALUES ('8699478a5f527f61d2f442a32eb0f87121b3225cfdf94a14243ee8b4f89bbf0787910dcea38a20b1', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-16 17:03:01', '2021-08-16 17:03:01', '2022-08-16 17:03:01');
INSERT INTO `oauth_access_tokens` VALUES ('88dd5af83834e3a56d9cfa79f195e88ad316c1676b32e7e2ba1235ca34017ff3852292f92e90c877', 12, 1, 'Personal Access Token', '[]', 0, '2021-08-14 21:24:08', '2021-08-14 21:24:08', '2022-08-14 21:24:08');
INSERT INTO `oauth_access_tokens` VALUES ('8c2c755f73e8aacddc1a681651ffef04b400ec9dfdd70c39c90f3a7c3f73435d85cddf6bf0ece041', 12, 1, 'Personal Access Token', '[]', 1, '2021-08-14 21:24:11', '2021-08-14 21:24:11', '2022-08-14 21:24:11');
INSERT INTO `oauth_access_tokens` VALUES ('921869dd7be53a63ccd3e53b6f7b63fdd02526d3ddb2d39919720ec5f2061f9c6b7dfbab0a2e02c9', 14, 1, 'Personal Access Token', '[]', 1, '2021-08-18 16:27:20', '2021-08-18 16:27:20', '2022-08-18 16:27:20');
INSERT INTO `oauth_access_tokens` VALUES ('9862b16b9310f375b79b770029bdbe82f1c68cca10701dc1da37705616ad4556dadb3c4f32181e82', 7, 1, 'Personal Access Token', '[]', 0, '2021-08-14 18:32:17', '2021-08-14 18:32:17', '2022-08-14 18:32:17');
INSERT INTO `oauth_access_tokens` VALUES ('a3bac0ccaf17898ba23688d4a5e6bf510f4080bedbe774a206a4b8f4d3778ed8710d05186e27bf1d', 17, 1, 'Personal Access Token', '[]', 1, '2021-08-28 11:44:14', '2021-08-28 11:44:14', '2022-08-28 11:44:14');
INSERT INTO `oauth_access_tokens` VALUES ('a6a1225bd9dce4835315bf8f1adca706d9c069b273b3026452c60e9bc7777166f0c5ce727cd570e1', 17, 1, 'Personal Access Token', '[]', 1, '2021-08-27 13:45:06', '2021-08-27 13:45:06', '2022-08-27 13:45:06');
INSERT INTO `oauth_access_tokens` VALUES ('a6aebb0a40a29e54ef9146d53a367a42244a765a0c7889bc414eb0968daed9d6665db231e89d37e2', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-26 09:26:26', '2021-08-26 09:26:26', '2022-08-26 09:26:26');
INSERT INTO `oauth_access_tokens` VALUES ('ad4c749a5dd9dd865a7816aacd105e85a87a4e7783326c19c7b091df1c7570a1da996522b45a7cc1', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-12 22:25:19', '2021-08-12 22:25:19', '2022-08-12 22:25:19');
INSERT INTO `oauth_access_tokens` VALUES ('aecd9cf6399b7ff98cc47f059b730a856208f1601fd58bf84650f955f1eec4fabd190f8e9ae175ce', 12, 1, 'Personal Access Token', '[]', 0, '2021-08-14 21:24:05', '2021-08-14 21:24:05', '2022-08-14 21:24:05');
INSERT INTO `oauth_access_tokens` VALUES ('b20662f978c960023f924157e607e6fa5d7cce7b6397636128f240256e9fc3e1302a52b9de20d7c4', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-17 09:57:06', '2021-08-17 09:57:06', '2022-08-17 09:57:06');
INSERT INTO `oauth_access_tokens` VALUES ('b3ebf845651bca8dd0d712818690d46785ff1bc4236bef29bca21f68190b10ef5b6207742fe51af0', 18, 1, 'Personal Access Token', '[]', 0, '2021-08-27 13:55:09', '2021-08-27 13:55:09', '2022-08-27 13:55:09');
INSERT INTO `oauth_access_tokens` VALUES ('b732d271d81936bf0e20a4aebbf828065db2b16d95a9598004f3de033ee548bf47526c2e7d968c60', 15, 1, 'Personal Access Token', '[]', 1, '2021-08-18 20:33:12', '2021-08-18 20:33:12', '2022-08-18 20:33:12');
INSERT INTO `oauth_access_tokens` VALUES ('c08fb6e684c1a3b0b142ae9de58116d8aa77caeeeae989eaf0f3e82085ecc49343f201502adc28a9', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-27 13:47:15', '2021-08-27 13:47:15', '2022-08-27 13:47:15');
INSERT INTO `oauth_access_tokens` VALUES ('c8b7e060dfd032b3d6748505e98a652f2e6724bd05816f82ccce7f7f2679043f13f55d4f5c22ef12', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-17 17:03:22', '2021-08-17 17:03:22', '2022-08-17 17:03:22');
INSERT INTO `oauth_access_tokens` VALUES ('c9fc1262337671e58cdb23316ef4f1e0cdfbe7d67b328ef1ac1069ad5ca540da223514a53b99defe', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-18 23:20:43', '2021-08-18 23:20:43', '2022-08-18 23:20:43');
INSERT INTO `oauth_access_tokens` VALUES ('ca36b840a49152350a61cffcb32402ab6022cd1bbd823fd883d58d41ac7fb9dcb21f48c1586385f1', 1, 1, 'Personal Access Token', '[]', 1, '2021-08-15 22:17:59', '2021-08-15 22:17:59', '2022-08-15 22:17:59');
INSERT INTO `oauth_access_tokens` VALUES ('cac01fe9f80c6a1b9a5e0bf9089f70f7dd233cb9823b459febc84d6c8a12b0d11cfcb8079d733865', 1, 1, 'Personal Access Token', '[]', 1, '2021-08-15 14:46:03', '2021-08-15 14:46:03', '2022-08-15 14:46:03');
INSERT INTO `oauth_access_tokens` VALUES ('d08e4cd74cbf9fa193172edac9875f5df1144100ac04730df8a6d75825dcc38900318ea86a27a34f', 15, 1, 'Personal Access Token', '[]', 0, '2021-08-18 21:15:34', '2021-08-18 21:15:34', '2022-08-18 21:15:34');
INSERT INTO `oauth_access_tokens` VALUES ('d26a518e3b4f720bd768d0f1d472fa32a1af7cfc36c31e3cd2487e218146f1b4614689e701f33410', 1, 1, 'Personal Access Token', '[]', 1, '2021-08-14 21:48:57', '2021-08-14 21:48:57', '2022-08-14 21:48:57');
INSERT INTO `oauth_access_tokens` VALUES ('d52e73c861a393d1205bc9d570de8a828adaaf2c5603a709045964ad94994311969bfc7a09512ee9', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-17 20:36:48', '2021-08-17 20:36:48', '2022-08-17 20:36:48');
INSERT INTO `oauth_access_tokens` VALUES ('d7209ba7d2489739e0d8dc09ce62a89c3e7bb0df97b8e6d7321179261db64eff843a699c08f64e51', 14, 1, 'Personal Access Token', '[]', 1, '2021-08-18 20:26:02', '2021-08-18 20:26:02', '2022-08-18 20:26:02');
INSERT INTO `oauth_access_tokens` VALUES ('da14162db41066dd9e49558dfb46d1f79ae0c7d35dedac7eb6e8af0947851650730e3cb6606171bd', 1, 1, 'Personal Access Token', '[]', 1, '2021-08-13 22:26:16', '2021-08-13 22:26:16', '2022-08-13 22:26:16');
INSERT INTO `oauth_access_tokens` VALUES ('e1ab0b3574a3ef77b786b3a372f6806d26ee687539b83cfb9d77129b2d714ec54ef5e94619ee3301', 12, 1, 'Personal Access Token', '[]', 0, '2021-08-14 21:17:33', '2021-08-14 21:17:33', '2022-08-14 21:17:33');
INSERT INTO `oauth_access_tokens` VALUES ('e81418b305136fb138fbe34dedc9ce2320c6e1983615a401c0ed33cda544d7d866baec5e130208df', 14, 1, 'Personal Access Token', '[]', 1, '2021-08-18 17:27:20', '2021-08-18 17:27:20', '2022-08-18 17:27:20');
INSERT INTO `oauth_access_tokens` VALUES ('eb30308f9764f085ce69a97f489611800a5ccef55701f2f8f2d8b308465b0e1d1980a2367f0aaf01', 13, 1, 'Personal Access Token', '[]', 1, '2021-08-14 21:42:16', '2021-08-14 21:42:16', '2022-08-14 21:42:16');
INSERT INTO `oauth_access_tokens` VALUES ('ec33c34e3a9f62c17591a9a7a33bad7698e47d42142034c482c0dc7ed253b8df2341b86e69b42ccd', 10, 1, 'Personal Access Token', '[]', 1, '2021-08-14 18:34:20', '2021-08-14 18:34:20', '2022-08-14 18:34:20');
INSERT INTO `oauth_access_tokens` VALUES ('f467dc7457528abcbe824ad2dfa2f28a4d1dac66b63b1034befb628ae38239e6bea96b9cb6ea3bd1', 18, 1, 'LaravelPassport', '[]', 0, '2021-08-27 13:55:01', '2021-08-27 13:55:01', '2022-08-27 13:55:01');
INSERT INTO `oauth_access_tokens` VALUES ('f5ec3c4a147dce9132aa2091bafd08c87084c117330c0453b654a5b49b6e68151033e30511881e5b', 1, 1, 'Personal Access Token', '[]', 0, '2021-08-19 09:52:45', '2021-08-19 09:52:45', '2022-08-19 09:52:45');
INSERT INTO `oauth_access_tokens` VALUES ('ffdab722fe005e3eae0a5cb6d552e9d3bf0b98cf2a30029c2c1759e9b3f1ece2f676748f1fdb6361', 1, 1, 'Personal Access Token', '[]', 0, '2021-07-19 02:24:35', '2021-07-19 02:24:35', '2022-07-19 02:24:35');
COMMIT;

-- ----------------------------
-- Table structure for oauth_auth_codes
-- ----------------------------
DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oauth_auth_codes
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for oauth_clients
-- ----------------------------
DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE `oauth_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oauth_clients
-- ----------------------------
BEGIN;
INSERT INTO `oauth_clients` VALUES (1, NULL, 'admin', 'cqaoIFbsHmtZwf6qSyTnYPzLwgrTHFKE7eUPvTee', NULL, 'http://localhost', 1, 0, 0, '2021-07-18 09:25:44', '2021-07-18 09:25:44');
COMMIT;

-- ----------------------------
-- Table structure for oauth_personal_access_clients
-- ----------------------------
DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oauth_personal_access_clients
-- ----------------------------
BEGIN;
INSERT INTO `oauth_personal_access_clients` VALUES (1, 1, '2021-07-18 09:25:44', '2021-07-18 09:25:44');
COMMIT;

-- ----------------------------
-- Table structure for oauth_refresh_tokens
-- ----------------------------
DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oauth_refresh_tokens
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_nr` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `upgrade_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `amount` int(11) NOT NULL DEFAULT '1000',
  `expiration` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_user_id_foreign` (`user_id`),
  KEY `orders_upgrade_id_foreign` (`upgrade_id`),
  CONSTRAINT `orders_upgrade_id_foreign` FOREIGN KEY (`upgrade_id`) REFERENCES `upgrades` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of orders
-- ----------------------------
BEGIN;
INSERT INTO `orders` VALUES (18, '27082117MWZCU', 1, 1, 1000, '2021-09-27 06:52:13', '2021-08-27 06:52:13', '2021-08-27 07:56:35', 1);
INSERT INTO `orders` VALUES (19, '27082118HRIU1', 3, 16, 3000, '2021-09-27 07:33:03', '2021-08-27 07:33:03', '2021-08-27 07:53:57', 1);
INSERT INTO `orders` VALUES (33, '27082119FQQCQ', 2, 16, 2000, '2021-09-27 07:55:13', '2021-08-27 07:55:13', '2021-08-27 07:56:29', 1);
INSERT INTO `orders` VALUES (34, '27082133ZIBRW', 1, 1, 1000, '2021-09-27 13:50:38', '2021-08-27 13:50:38', '2021-08-27 13:50:38', 0);
INSERT INTO `orders` VALUES (35, '28082134SGJNO', 3, 16, 3000, '2021-09-28 14:28:23', '2021-08-28 14:28:23', '2021-08-28 14:28:23', 1);
COMMIT;

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of password_resets
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of permissions
-- ----------------------------
BEGIN;
INSERT INTO `permissions` VALUES (1, 'edit challenges', 'api', '2021-07-18 08:31:53', '2021-07-18 08:31:53');
INSERT INTO `permissions` VALUES (2, 'delete challenges', 'api', '2021-07-18 08:31:53', '2021-07-18 08:31:53');
INSERT INTO `permissions` VALUES (5, 'edit categories', 'api', '2021-07-18 08:31:53', '2021-07-18 08:31:53');
INSERT INTO `permissions` VALUES (6, 'delete categories', 'api', '2021-07-18 08:31:53', '2021-07-18 08:31:53');
INSERT INTO `permissions` VALUES (8, 'login admin', 'api', '2021-07-18 08:31:53', '2021-07-18 08:31:53');
INSERT INTO `permissions` VALUES (9, 'edit users', 'api', '2021-08-06 15:36:11', '2021-08-06 15:36:11');
INSERT INTO `permissions` VALUES (10, 'delete users', 'api', '2021-08-06 15:36:25', '2021-08-06 15:36:25');
INSERT INTO `permissions` VALUES (11, 'edit roles', 'api', '2021-08-06 15:36:39', '2021-08-06 15:36:39');
INSERT INTO `permissions` VALUES (12, 'delete roles', 'api', '2021-08-06 15:36:50', '2021-08-06 15:36:50');
INSERT INTO `permissions` VALUES (13, 'create roles', 'api', '2021-08-06 15:37:04', '2021-08-06 15:37:04');
INSERT INTO `permissions` VALUES (14, 'create users', 'api', '2021-08-06 15:37:18', '2021-08-06 15:37:18');
INSERT INTO `permissions` VALUES (15, 'create permissions', 'api', '2021-08-06 15:37:35', '2021-08-06 15:37:35');
INSERT INTO `permissions` VALUES (16, 'edit permissions', 'api', '2021-08-06 15:37:44', '2021-08-06 15:37:44');
INSERT INTO `permissions` VALUES (17, 'delete permissions', 'api', '2021-08-06 15:37:57', '2021-08-06 15:38:10');
INSERT INTO `permissions` VALUES (18, 'create categories', 'api', '2021-08-06 15:38:38', '2021-08-06 15:38:38');
INSERT INTO `permissions` VALUES (19, 'create challenges', 'api', '2021-08-06 15:38:48', '2021-08-06 15:38:48');
INSERT INTO `permissions` VALUES (20, 'edit solutions', 'api', '2021-08-06 15:39:14', '2021-08-06 15:39:14');
INSERT INTO `permissions` VALUES (21, 'delete solutions', 'api', '2021-08-06 15:39:24', '2021-08-06 15:39:24');
INSERT INTO `permissions` VALUES (22, 'chat', 'api', '2021-08-06 15:42:03', '2021-08-06 15:42:03');
INSERT INTO `permissions` VALUES (23, 'create solutions', 'api', '2021-08-06 15:42:43', '2021-08-06 15:42:43');
INSERT INTO `permissions` VALUES (24, 'create upgrades', 'api', '2021-08-12 21:34:23', '2021-08-12 21:34:34');
INSERT INTO `permissions` VALUES (25, 'delete upgrades', 'api', '2021-08-12 21:54:09', '2021-08-12 21:54:09');
INSERT INTO `permissions` VALUES (26, 'edit upgrades', 'api', '2021-08-12 21:55:02', '2021-08-12 21:55:02');
INSERT INTO `permissions` VALUES (27, 'edit orders', 'api', '2021-08-12 21:56:30', '2021-08-12 21:56:30');
INSERT INTO `permissions` VALUES (28, 'delete orders', 'api', '2021-08-12 22:01:02', '2021-08-12 22:01:02');
INSERT INTO `permissions` VALUES (29, 'user vip1', 'api', '2021-08-26 09:38:23', '2021-08-26 09:38:23');
INSERT INTO `permissions` VALUES (30, 'user vip2', 'api', '2021-08-26 09:38:29', '2021-08-26 09:38:29');
INSERT INTO `permissions` VALUES (31, 'user vip3', 'api', '2021-08-26 09:38:35', '2021-08-26 09:38:35');
INSERT INTO `permissions` VALUES (32, 'user', 'api', '2021-08-27 07:14:09', '2021-08-27 07:14:09');
COMMIT;

-- ----------------------------
-- Table structure for role_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_has_permissions
-- ----------------------------
BEGIN;
INSERT INTO `role_has_permissions` VALUES (22, 1);
INSERT INTO `role_has_permissions` VALUES (23, 1);
INSERT INTO `role_has_permissions` VALUES (32, 1);
INSERT INTO `role_has_permissions` VALUES (1, 2);
INSERT INTO `role_has_permissions` VALUES (2, 2);
INSERT INTO `role_has_permissions` VALUES (5, 2);
INSERT INTO `role_has_permissions` VALUES (6, 2);
INSERT INTO `role_has_permissions` VALUES (8, 2);
INSERT INTO `role_has_permissions` VALUES (9, 2);
INSERT INTO `role_has_permissions` VALUES (10, 2);
INSERT INTO `role_has_permissions` VALUES (11, 2);
INSERT INTO `role_has_permissions` VALUES (12, 2);
INSERT INTO `role_has_permissions` VALUES (13, 2);
INSERT INTO `role_has_permissions` VALUES (14, 2);
INSERT INTO `role_has_permissions` VALUES (15, 2);
INSERT INTO `role_has_permissions` VALUES (16, 2);
INSERT INTO `role_has_permissions` VALUES (17, 2);
INSERT INTO `role_has_permissions` VALUES (18, 2);
INSERT INTO `role_has_permissions` VALUES (19, 2);
INSERT INTO `role_has_permissions` VALUES (20, 2);
INSERT INTO `role_has_permissions` VALUES (21, 2);
INSERT INTO `role_has_permissions` VALUES (22, 2);
INSERT INTO `role_has_permissions` VALUES (23, 2);
INSERT INTO `role_has_permissions` VALUES (24, 2);
INSERT INTO `role_has_permissions` VALUES (25, 2);
INSERT INTO `role_has_permissions` VALUES (26, 2);
INSERT INTO `role_has_permissions` VALUES (27, 2);
INSERT INTO `role_has_permissions` VALUES (28, 2);
INSERT INTO `role_has_permissions` VALUES (22, 4);
INSERT INTO `role_has_permissions` VALUES (23, 4);
INSERT INTO `role_has_permissions` VALUES (29, 4);
INSERT INTO `role_has_permissions` VALUES (32, 4);
INSERT INTO `role_has_permissions` VALUES (22, 5);
INSERT INTO `role_has_permissions` VALUES (23, 5);
INSERT INTO `role_has_permissions` VALUES (29, 5);
INSERT INTO `role_has_permissions` VALUES (30, 5);
INSERT INTO `role_has_permissions` VALUES (32, 5);
INSERT INTO `role_has_permissions` VALUES (22, 6);
INSERT INTO `role_has_permissions` VALUES (23, 6);
INSERT INTO `role_has_permissions` VALUES (29, 6);
INSERT INTO `role_has_permissions` VALUES (30, 6);
INSERT INTO `role_has_permissions` VALUES (31, 6);
INSERT INTO `role_has_permissions` VALUES (32, 6);
COMMIT;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of roles
-- ----------------------------
BEGIN;
INSERT INTO `roles` VALUES (1, 'User', 'api', '2021-07-18 08:31:54', '2021-08-26 09:41:33');
INSERT INTO `roles` VALUES (2, 'Admin', 'api', '2021-07-18 08:31:54', '2021-08-26 09:41:26');
INSERT INTO `roles` VALUES (4, 'UserVip1', 'api', '2021-08-26 09:41:54', '2021-08-26 09:41:54');
INSERT INTO `roles` VALUES (5, 'UserVip2', 'api', '2021-08-26 09:42:13', '2021-08-26 09:42:13');
INSERT INTO `roles` VALUES (6, 'UserVip3', 'api', '2021-08-26 09:42:35', '2021-08-26 09:42:35');
COMMIT;

-- ----------------------------
-- Table structure for solutions
-- ----------------------------
DROP TABLE IF EXISTS `solutions`;
CREATE TABLE `solutions` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `link_github` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `demo_url` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `challen_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `solutions_link_github_unique` (`link_github`),
  UNIQUE KEY `solutions_demo_url_unique` (`demo_url`),
  KEY `solutions_user_id_foreign` (`user_id`),
  KEY `solutions_challen_id_foreign` (`challen_id`),
  CONSTRAINT `solutions_challen_id_foreign` FOREIGN KEY (`challen_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `solutions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of solutions
-- ----------------------------
BEGIN;
INSERT INTO `solutions` VALUES ('a3cfe3d7-cfb9-433e-ae72-06199a55d643', 'My Unsplash', '<p>My Unsplash</p>', 'Abc', 'https://my-unsplash-manucasares.netlify.app/', 1, 4, '2021-08-27 08:03:05', '2021-08-27 18:52:05');
COMMIT;

-- ----------------------------
-- Table structure for upgrades
-- ----------------------------
DROP TABLE IF EXISTS `upgrades`;
CREATE TABLE `upgrades` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `price` int(11) NOT NULL DEFAULT '1000',
  `period` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of upgrades
-- ----------------------------
BEGIN;
INSERT INTO `upgrades` VALUES (1, 'Premium VIP1', '<p>Premium 1 th&aacute;ng</p>', 1000, 1, '2021-08-13 23:24:22', '2021-08-27 07:18:51');
INSERT INTO `upgrades` VALUES (2, 'Premium VIP2', '<p>G&oacute;i vip 2</p>', 2000, 1, '2021-08-27 07:19:26', '2021-08-27 07:19:26');
INSERT INTO `upgrades` VALUES (3, 'Premium VIP3', '<p>G&oacute;i vip 3</p>', 3000, 1, '2021-08-27 07:19:44', '2021-08-27 07:19:44');
COMMIT;

-- ----------------------------
-- Table structure for upvote_feedbacks
-- ----------------------------
DROP TABLE IF EXISTS `upvote_feedbacks`;
CREATE TABLE `upvote_feedbacks` (
  `user_id` int(10) unsigned NOT NULL,
  `feedback_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`feedback_id`),
  KEY `upvote_feedbacks_feedback_id_foreign` (`feedback_id`),
  CONSTRAINT `upvote_feedbacks_feedback_id_foreign` FOREIGN KEY (`feedback_id`) REFERENCES `feedbacks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `upvote_feedbacks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of upvote_feedbacks
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for upvotes
-- ----------------------------
DROP TABLE IF EXISTS `upvotes`;
CREATE TABLE `upvotes` (
  `user_id` int(10) unsigned NOT NULL,
  `solution_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`solution_id`),
  KEY `upvotes_solution_id_foreign` (`solution_id`),
  CONSTRAINT `upvotes_solution_id_foreign` FOREIGN KEY (`solution_id`) REFERENCES `solutions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `upvotes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of upvotes
-- ----------------------------
BEGIN;
INSERT INTO `upvotes` VALUES (1, 'a3cfe3d7-cfb9-433e-ae72-06199a55d643', '2021-08-27 13:53:08', '2021-08-27 13:53:08');
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` int(11) DEFAULT '1',
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(191) DEFAULT '0',
  `github_url` varchar(191) DEFAULT NULL,
  `provider_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `verify_token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_username_unique` (`username`),
  UNIQUE KEY `users_phone_unique` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES (1, 'admin', 'Quản trị viên', 'admin123@gmail.com', 1, 'Hà Nội', '0387897456', 'files/1630064788-admin.png', '0', NULL, NULL, 1, NULL, NULL, '$2a$09$0Vz0CugF2LbWYKeKl9FRMON0p4nNOBtbB5.rbovJONjPoKaM1ct1m', NULL, '2021-07-18 09:00:25', '2021-08-27 18:56:06');
INSERT INTO `users` VALUES (16, 'User', 'User', 'User@gmail.com', 1, 'Ha noi', '090615122', 'files/1630023357-df5dc62c686d4da48f62057932a0b04b (1).png', '0', NULL, NULL, 1, NULL, NULL, '$2y$10$8HUjySum2brl3bc2HtJX0.7LkcjEMUKdHMRndR1AjcfRw8YZldupq', NULL, '2021-08-27 07:15:57', '2021-08-27 07:15:57');
INSERT INTO `users` VALUES (17, NULL, 'NINH%@%', 'tnngithub525@gmail.com', 1, NULL, NULL, 'files/avatar-163012585465867519.jpg', 'github', 'https://github.com/use-525', '65867519', 0, NULL, NULL, NULL, 'kVt2BIjKm4R6HPEfOyn29OvOgTAWJtKhRpsOdTVjZuWqE9LbwGUYVqQCFBjN', '2021-08-27 13:45:06', '2021-08-28 11:44:14');
INSERT INTO `users` VALUES (18, NULL, 'TA ninh', 'admin@gmail.com', 1, NULL, NULL, NULL, '0', NULL, NULL, 0, NULL, NULL, '$2y$10$OeynreHu9/PxJR8xCUJlmO5fvnzOXncW/jSXXWUkxxD/udGEtO0ni', NULL, '2021-08-27 13:55:00', '2021-08-27 13:55:00');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
