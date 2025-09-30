-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 30, 2025 at 06:52 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `witsnote`
--

-- --------------------------------------------------------

--
-- Table structure for table `authtoken_token`
--

CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add users', 7, 'add_users'),
(26, 'Can change users', 7, 'change_users'),
(27, 'Can delete users', 7, 'delete_users'),
(28, 'Can view users', 7, 'view_users'),
(29, 'Can add user', 7, 'add_user'),
(30, 'Can change user', 7, 'change_user'),
(31, 'Can delete user', 7, 'delete_user'),
(32, 'Can view user', 7, 'view_user'),
(33, 'Can add user profile', 8, 'add_userprofile'),
(34, 'Can change user profile', 8, 'change_userprofile'),
(35, 'Can delete user profile', 8, 'delete_userprofile'),
(36, 'Can view user profile', 8, 'view_userprofile'),
(37, 'Can add post', 9, 'add_post'),
(38, 'Can change post', 9, 'change_post'),
(39, 'Can delete post', 9, 'delete_post'),
(40, 'Can view post', 9, 'view_post'),
(41, 'Can add post', 10, 'add_post'),
(42, 'Can change post', 10, 'change_post'),
(43, 'Can delete post', 10, 'delete_post'),
(44, 'Can view post', 10, 'view_post'),
(45, 'Can add post image', 11, 'add_postimage'),
(46, 'Can change post image', 11, 'change_postimage'),
(47, 'Can delete post image', 11, 'delete_postimage'),
(48, 'Can view post image', 11, 'view_postimage'),
(49, 'Can add post collection', 12, 'add_postcollection'),
(50, 'Can change post collection', 12, 'change_postcollection'),
(51, 'Can delete post collection', 12, 'delete_postcollection'),
(52, 'Can view post collection', 12, 'view_postcollection'),
(53, 'Can add listicle subheading', 13, 'add_listiclesubheading'),
(54, 'Can change listicle subheading', 13, 'change_listiclesubheading'),
(55, 'Can delete listicle subheading', 13, 'delete_listiclesubheading'),
(56, 'Can view listicle subheading', 13, 'view_listiclesubheading'),
(57, 'Can add infographic section', 14, 'add_infographicsection'),
(58, 'Can change infographic section', 14, 'change_infographicsection'),
(59, 'Can delete infographic section', 14, 'delete_infographicsection'),
(60, 'Can view infographic section', 14, 'view_infographicsection'),
(61, 'Can add Token', 15, 'add_token'),
(62, 'Can change Token', 15, 'change_token'),
(63, 'Can delete Token', 15, 'delete_token'),
(64, 'Can view Token', 15, 'view_token'),
(65, 'Can add Token', 16, 'add_tokenproxy'),
(66, 'Can change Token', 16, 'change_tokenproxy'),
(67, 'Can delete Token', 16, 'delete_tokenproxy'),
(68, 'Can view Token', 16, 'view_tokenproxy');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$720000$iJWLI6qgfIMLr1wGed50oU$RycWOMmRO7uTEdziONpVFUpZAzLVTnbqALeluT3h9qM=', '2025-05-22 17:03:50.098909', 1, 'vince', '', '', 'vince@mail.com', 1, 1, '2025-05-22 17:03:22.034984'),
(3, 'argon2$argon2id$v=19$m=102400,t=2,p=8$Nzd2V3ZPNTlzWWJidTZQYTBibXU4NQ$4McDCwWO/88J0pNxf9oXGsizNcGjScXGBO/3zOH58OM', '2025-09-29 12:49:09.929851', 0, 'testuser', 'Test', 'User', 'testuser@mail.com', 0, 1, '2025-06-07 08:10:02.108556'),
(4, 'argon2$argon2id$v=19$m=102400,t=2,p=8$WVU3bFZQZTBRNkZJdEJvZFVBTjVhNQ$UoioPPoXQREUB4yIy/K94qvIYD1ZfkUw1AEPT3T/GWA', '2025-09-24 18:52:30.272797', 0, 'jasonch32', 'Jason', 'Chan', 'jsonch@mail.com', 0, 1, '2025-06-07 09:29:19.390504'),
(5, 'argon2$argon2id$v=19$m=102400,t=2,p=8$WmFwQVJodzM0STlVNzhEWWFYUTV3Mw$U61/RuMUzcJTi8VU8u0ryUr6EM30xjYFlLSZjJdXuac', '2025-09-24 19:12:08.635471', 0, 'jbb22q', 'Jake', 'Benedemin', 'jbb33@mail.com', 0, 1, '2025-06-08 04:54:10.778402'),
(6, 'argon2$argon2id$v=19$m=102400,t=2,p=8$NmZGS0JHMnVma3dXWThjQUkzVnpqcA$OS3vEUP5n7FgLcnNMSlOvoS58oDjF0kmABk2tJEzw4w', '2025-09-25 21:50:42.533401', 0, 'xm123', 'Xiao', 'Ming', 'xmin@mail.com', 0, 1, '2025-06-08 05:10:05.154585'),
(7, 'argon2$argon2id$v=19$m=102400,t=2,p=8$ZnU5RWRBZWRJYmtSelc2TThGNGd0Sw$p/ZRErrzAtw+pief4T8u1/tB3JXul+uWY3ESgxBAhZ8', '2025-07-15 08:25:55.329278', 0, 'jasBn', 'Jasmine', 'Brown', 'jasmine223@mail.com', 0, 1, '2025-06-09 03:06:30.932431'),
(8, 'argon2$argon2id$v=19$m=102400,t=2,p=8$aXdzaEJEcFJ0enZvZzJ4dG9KS0xmMA$Wo07nk4npM/O+qGEYqs7Psh9jz/x1U1PMFaw7Iknn7s', '2025-08-17 11:35:09.418270', 0, 'browie321', 'Brownie', 'Iceberg', 'broice@mail.com', 0, 1, '2025-06-09 03:28:50.878514'),
(9, 'argon2$argon2id$v=19$m=102400,t=2,p=8$V2Jvd1lsUVJZOGpSM0ZqRmRGR1Z4MA$W9lJS7j0lhPpc/1tee0xChC8SIrVgLLz0JoGmbdFqXc', '2025-08-29 04:25:29.695640', 0, 'Mr Bean', 'Bob', 'Bean', 'bean123@gmail.com', 0, 1, '2025-08-29 04:25:10.718006'),
(10, 'argon2$argon2id$v=19$m=102400,t=2,p=8$WGI3U2pDdUtnTENSUjFzbVJjWXRJWg$KcjKHm+akjNK6GR8qFUj0ERsx97XKq0pCvSVtYfL0Q0', '2025-08-29 05:35:13.918005', 0, 'bobbyy2', 'Bobby', 'Ivan', 'boyb@gmail.com', 0, 1, '2025-08-29 05:34:54.034146'),
(11, 'argon2$argon2id$v=19$m=102400,t=2,p=8$alRhY2lwUU5KSUxsdEhNR0EzSE9rUQ$+8OC18MYpbnyCiC/L8sDyGz4XFkamBVRxTSHL1SnZzo', '2025-09-29 09:03:05.550170', 0, 'warugiqq', 'Kaoruko', 'Waguri', 'warugiqq@gmail.com', 0, 1, '2025-08-29 07:05:00.876765'),
(12, 'argon2$argon2id$v=19$m=102400,t=2,p=8$R1AyaEVYWkxLdlZKSW5SWXViRnAxeA$FG08/V3dqFZX5keumbMuX+sQ41bTisZsi8Sf5rtl7zo', '2025-09-29 13:57:10.979701', 1, 'dbadmin', '', '', 'dbadmin@mail.com', 1, 1, '2025-08-31 20:36:16.139620'),
(13, 'argon2$argon2id$v=19$m=102400,t=2,p=8$U25BUGdIRmFSM1lIM09nYjBaOTJPYg$7+7Ljz5TylSQJ/zn3sgE/12mYi1at8Rf6Ai+6KH+QWI', '2025-09-24 16:45:42.963480', 0, 'user1', 'Random', 'User', 'user1@mail.com', 0, 1, '2025-09-24 16:03:20.683147'),
(15, 'argon2$argon2id$v=19$m=102400,t=2,p=8$UXBLb0hLUzJJdkhrVGtKV01Jd1BYTQ$MTOpPxo7Seitz0ed6852z/Z8UtNKwx48NgKL9NOmk1A', '2025-09-26 01:36:52.051566', 0, 'ken1234', 'Ken', 'Young', 'ken321@mail.com', 0, 1, '2025-09-25 23:12:30.588953'),
(16, 'argon2$argon2id$v=19$m=102400,t=2,p=8$OGlDWVA0Z1BXNElDQVJEVzNpZmltUg$wd7h8Sj5cZpxgVusLj0pWXtic8qZ/d4hQ5o4OgUtyWo', '2025-09-26 02:16:38.795275', 0, 'george123', 'George', 'Young', 'george123@mail.com', 0, 1, '2025-09-26 02:13:20.042186'),
(20, 'argon2$argon2id$v=19$m=102400,t=2,p=8$d2dGSkRKcnlBdG96cEdTWTNjTTZsMg$ibjN19s9caW1KDYfNR5c6brL5yIj2RTGdrObKe2T9Do', '2025-09-29 13:39:32.006179', 0, 'username', 'User', 'Name', 'username@mail.com', 0, 1, '2025-09-29 13:39:26.583137');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2025-09-25 21:16:15.038716', '2', 'Testing Images by jasBn.', 3, '', 10, 12),
(2, '2025-09-25 21:23:42.551711', '30', 'Section Testing by jbb22q.', 2, '[{\"changed\": {\"name\": \"infographic section\", \"object\": \"2. Section Title1\", \"fields\": [\"Content\"]}}]', 10, 12),
(3, '2025-09-25 23:12:00.382250', '14', 'ken1234', 3, '', 4, 12);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(15, 'authtoken', 'token'),
(16, 'authtoken', 'tokenproxy'),
(5, 'contenttypes', 'contenttype'),
(9, 'Post', 'post'),
(6, 'sessions', 'session'),
(12, 'users', 'postcollection'),
(7, 'users', 'user'),
(8, 'users', 'userprofile'),
(14, 'WitsNote', 'infographicsection'),
(13, 'WitsNote', 'listiclesubheading'),
(10, 'WitsNote', 'post'),
(11, 'WitsNote', 'postimage');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-05-22 16:53:24.816828'),
(2, 'auth', '0001_initial', '2025-05-22 16:53:25.234311'),
(3, 'admin', '0001_initial', '2025-05-22 16:53:25.317833'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-05-22 16:53:25.333531'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-05-22 16:53:25.354621'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-05-22 16:53:25.402635'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-05-22 16:53:25.442350'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-05-22 16:53:25.457129'),
(9, 'auth', '0004_alter_user_username_opts', '2025-05-22 16:53:25.462113'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-05-22 16:53:25.487968'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-05-22 16:53:25.489652'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-05-22 16:53:25.495704'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-05-22 16:53:25.505106'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-05-22 16:53:25.513061'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-05-22 16:53:25.518758'),
(16, 'auth', '0011_update_proxy_permissions', '2025-05-22 16:53:25.528796'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-05-22 16:53:25.532770'),
(18, 'sessions', '0001_initial', '2025-05-22 16:53:25.555630'),
(19, 'users', '0001_initial', '2025-05-22 16:53:25.560856'),
(20, 'users', '0002_alter_users_email', '2025-05-22 16:53:25.569987'),
(21, 'users', '0003_rename_users_user', '2025-05-22 17:15:48.132636'),
(22, 'users', '0004_userprofile_delete_user', '2025-05-30 05:30:28.012895'),
(23, 'users', '0005_remove_userprofile_first_name_and_more', '2025-06-05 15:40:20.403611'),
(24, 'users', '0006_remove_userprofile_first_name_and_more', '2025-06-09 04:03:14.928921'),
(25, 'users', '0007_alter_userprofile_phone', '2025-06-09 04:32:58.352206'),
(26, 'Post', '0001_initial', '2025-06-14 06:05:23.872199'),
(27, 'users', '0008_alter_userprofile_user', '2025-06-14 06:05:23.879419'),
(28, 'WitsNote', '0001_initial', '2025-06-26 18:12:10.498071'),
(29, 'WitsNote', '0002_alter_post_table', '2025-06-26 18:18:25.507931'),
(30, 'WitsNote', '0003_post_conclusion_post_introduction', '2025-07-05 18:44:47.511932'),
(31, 'WitsNote', '0004_post_images', '2025-07-17 06:08:51.960804'),
(32, 'WitsNote', '0005_postimage_remove_post_images', '2025-07-17 09:05:07.317628'),
(33, 'WitsNote', '0006_postimage_image_postimage_post', '2025-07-17 09:44:27.499006'),
(34, 'WitsNote', '0007_post_post_type', '2025-08-11 16:58:33.169105'),
(35, 'WitsNote', '0008_alter_post_post_type', '2025-08-11 16:58:33.179434'),
(36, 'users', '0009_postcollection', '2025-08-16 17:43:38.388953'),
(37, 'users', '0010_userprofile_profile_picture_alter_userprofile_table', '2025-09-24 15:29:12.553674'),
(38, 'users', '0011_alter_userprofile_work_link', '2025-09-24 16:38:48.858860'),
(39, 'users', '0012_alter_userprofile_work_link', '2025-09-24 18:51:51.203572'),
(40, 'users', '0013_alter_userprofile_work_link', '2025-09-24 19:10:12.979870'),
(41, 'users', '0014_alter_userprofile_work_link', '2025-09-24 19:10:12.992421'),
(42, 'WitsNote', '0009_listiclesubheading', '2025-09-25 15:21:54.313419'),
(43, 'WitsNote', '0010_listiclesubheading_content_and_more', '2025-09-25 15:33:06.258162'),
(44, 'WitsNote', '0011_infographicsection', '2025-09-25 17:36:24.105802'),
(45, 'WitsNote', '0012_alter_post_conclusion_alter_post_content_and_more', '2025-09-25 21:19:23.413223'),
(46, 'WitsNote', '0013_alter_post_conclusion_alter_post_content_and_more', '2025-09-25 21:22:43.572229'),
(47, 'WitsNote', '0014_alter_post_thumbnail', '2025-09-25 21:23:38.724302'),
(48, 'authtoken', '0001_initial', '2025-09-27 08:38:01.519187'),
(49, 'authtoken', '0002_auto_20160226_1747', '2025-09-27 08:38:01.574288'),
(50, 'authtoken', '0003_tokenproxy', '2025-09-27 08:38:01.584207'),
(51, 'authtoken', '0004_alter_tokenproxy_options', '2025-09-27 08:38:01.592586');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('09pb43ocdw1bkv5ipc4yrejg2pa8xwd0', '.eJxVjDsOwyAQRO9CHSHA5pcyvc-AdmEJTiIsGbuKcvdgyUXSTPHmzbxZgH0rYW-0hjmxKzPs8ssQ4pPqUaQH1PvC41K3dUZ-KPxsG5-WRK_b6f4dFGilr5UeNI6SdLQK0AppCZPrUCkX0ZhROacjkEU1aE3Jm5xzj-QFeEmCfb7Q-Te1:1v1trO:fMhuN4OQnHXXItz3BrzfkdyfRoE143ljxqNoH9L4K10', '2025-10-09 21:50:42.540133'),
('1szveatl8utbkwdyug2szvu7xlxr2roq', '.eJxVjEEOwiAQRe_C2hAQyqBL956hmRkGqRpISrsy3l2bdKHb_977LzXiupRx7TKPU1JnZdXhdyPkh9QNpDvWW9Pc6jJPpDdF77Tra0vyvOzu30HBXr61EEMGBgfJR84DIQGcACITmcQ2IxMKReOtpyMOJohzJkCKGJ1wUO8PGcE48Q:1uI9Kg:S9B-OgFajZKRHZRppVnputkFQk2x54HGbqG__mCRWnQ', '2025-06-05 17:03:50.102842'),
('24hgfcv8n4xs68tx1fu2bamvdhqjv2z3', '.eJxVjMsOwiAQRf-FtSFQGB4u3fsNZIahUjU0Ke3K-O_apAvd3nPOfYmE21rT1suSJhZnYcTpdyPMj9J2wHdst1nmua3LRHJX5EG7vM5cnpfD_Tuo2Ou3Vhpd8NpwoAiWgJSFkSPkOFjPUMioUWWPEZ3OBAzRQ8EQaPBkgmPx_gDSuTey:1v1y3d:DCkrLhyWCTUbGwhsvM-EVBdI-kOnC8F8UqjYl6ppxwY', '2025-10-10 02:19:37.807252'),
('3i9krzhyixxltdje58cur9it5gjck0gp', '.eJxVjEEOwiAQRe_C2hCgQBmX7j0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kTiLIE6_W8L84LYDumO7zTLPbV2mJHdFHrTL60z8vBzu30HFXr-1BgNs0lg0W-e4JCwUyPkBPAwBCbgoZ6y3efRETmNBIGshJ2VVSFq8P_IrOB4:1unbfJ:5PEjbNFltaPyR2ZFKq8eRUamCCqNO6kvoxWBn94_D0s', '2025-08-31 11:35:09.418270'),
('3jnitm3wqu1qtt33mh7zns6d458jhsng', '.eJxVjEEOwiAQRe_C2hAYENGl-56hmRkGqRpISrsy3l2bdKHb_977LzXiupRx7TKPU1IXZUEdfkdCfkjdSLpjvTXNrS7zRHpT9E67HlqS53V3_w4K9vKt8XiOQIRgKLPLxgBH66Mh9hAwiFjBk4MUXcjeBfIC2XH24pAjiVXvDxL_OKk:1v1qzC:jpuWHLV7DGGadbTwi2jbqRh9KF4oKen8C97PEB2-IbA', '2025-10-09 18:46:34.937402'),
('5ah8f4gbguec5wvasspv3x4tacid2mvr', '.eJxVjDsOwjAQBe_iGlnedWwcSvqcIfJ-ggMolvKpEHeHSCmgfTPzXqbP21r6bdG5H8VcTGtOvxtlfui0A7nn6VYt12mdR7K7Yg-62K6KPq-H-3dQ8lK-9Zk9Jh0cE2DwiSUQQKs5AEBMQkRemDNiGpy4JjA3ERpEdYnigGreH-7YOBY:1urqg5:hnm0bE-GemotTsbDIb9zY2TC2ohMaGAHqd5GlHL37m8', '2025-09-12 04:25:29.703520'),
('9z6enuom6bcsj5nag3w2idqw4n7p15ah', '.eJxVjDsOwyAQRO9CHSHALJ-U6X0GxLIQnERYMnYV5e6xJRdJNdK8N_NmIW5rDVvPS5iIXZlml98OY3rmdgB6xHafeZrbukzID4WftPNxpvy6ne7fQY297uucjHfCei89oYSsnQBNFvYQyioAm8gMEkQaFCVXhAEE0IgZIZZY2OcLtDs3TQ:1uhO8h:MLQ-eWcFEobbCJCQNB-b2wn01RBK2eL-EluXVhTO8kY', '2025-08-14 07:55:47.303924'),
('dnudo9fam08n050t6w6trx85w0x89p3k', '.eJxVjEEOwiAQRe_C2hCKMIBL9z0DmYFBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4ZXERTpx-N8L04LaDfMd2m2Wa27pMJHdFHrTLcc78vB7u30HFXr81B6Oyt55SyB4HDsRYLGiPpgyFGZSh4jU49qCVtfYMoWRUAMSOnBLvD_vnOCQ:1ubaz5:I89AQrsq6eLJ0thf4bBHBZ8Y0Tk_emgKCGZkJ0WoTR4', '2025-07-29 08:25:55.334502'),
('dt7k10z3nmh0l0ugj9e1bcr841qissgo', '.eJxVjMsOwiAQRf-FtSGlA4O4dN9vIMMMlaqBpI-V8d-1SRe6veec-1KRtrXEbclznERdlEF1-h0T8SPXncid6q1pbnWdp6R3RR900UOT_Lwe7t9BoaV8a9eTRQyI6IzxABAcpw6cocC-A-Eu955GHuXMXiywJGOF2GUL5AKq9wfgwzfS:1v1y0k:dXRGrnIrEdGVku2dVhQ_MUcF-ZP7ulZ3_VdN4Jh5Vrs', '2025-10-10 02:16:38.803823'),
('f15vkn2n8i7ku2lsemm53jc4apmwp32e', '.eJxVjEEOwiAQRe_C2hCgQBmX7j0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kTiLIE6_W8L84LYDumO7zTLPbV2mJHdFHrTL60z8vBzu30HFXr-1BgNs0lg0W-e4JCwUyPkBPAwBCbgoZ6y3efRETmNBIGshJ2VVSFq8P_IrOB4:1uOTBz:1BBfV5a-A5NrpambFG3YUkMODIYYUe2_SIgEEqabAyk', '2025-06-23 03:28:59.289928'),
('f5jx8ya8q31uj72lg30t200us43ttdlj', '.eJxVjEEOwiAQRe_C2hAYENGl-56hmRkGqRpISrsy3l2bdKHb_977LzXiupRx7TKPU1IXZUEdfkdCfkjdSLpjvTXNrS7zRHpT9E67HlqS53V3_w4K9vKt8XiOQIRgKLPLxgBH66Mh9hAwiFjBk4MUXcjeBfIC2XH24pAjiVXvDxL_OKk:1v3ENK:v-ne9c1D-fzmSEuMOwtQLQ9_QZ7KSbqfv6PjB5dUIik', '2025-10-13 13:57:10.984228'),
('hw3q5fno9n96yulahoaldtsoq6cpyuoy', '.eJxVjEEOwiAQRe_C2hCgQBmX7j0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kTiLIE6_W8L84LYDumO7zTLPbV2mJHdFHrTL60z8vBzu30HFXr-1BgNs0lg0W-e4JCwUyPkBPAwBCbgoZ6y3efRETmNBIGshJ2VVSFq8P_IrOB4:1uQJLG:px57vS6s7cis_qMz3IYDZghpv0410-TaWcgih0HqwJY', '2025-06-28 05:22:10.830330'),
('ivvcrjipfm7gpi2v0k5f13gxwo74equf', '.eJxVjDsOwyAQRO9CHSHA5pcyvc-AdmEJTiIsGbuKcvdgyUXSTPHmzbxZgH0rYW-0hjmxKzPs8ssQ4pPqUaQH1PvC41K3dUZ-KPxsG5-WRK_b6f4dFGilr5UeNI6SdLQK0AppCZPrUCkX0ZhROacjkEU1aE3Jm5xzj-QFeEmCfb7Q-Te1:1uojgt:fYe16aAIMm_XIwBtbInSGRH6mRwjgoNSjc_verpCIc8', '2025-09-03 14:21:27.876070'),
('nhg1bq7kn50z3puf9d81o0ntqbapcxip', '.eJxVjEEOwiAQRe_C2hAYENGl-56hmRkGqRpISrsy3l2bdKHb_977LzXiupRx7TKPU1IXZUEdfkdCfkjdSLpjvTXNrS7zRHpT9E67HlqS53V3_w4K9vKt8XiOQIRgKLPLxgBH66Mh9hAwiFjBk4MUXcjeBfIC2XH24pAjiVXvDxL_OKk:1usxTW:KUm3EijrgpfhPiEzfnygwtCBB1YlQ1OffWbfpEDfEkc', '2025-09-15 05:53:06.155586'),
('nkgltqh563i0iw2tlp4fu8tpib3dlftw', '.eJxVjMsOwiAQRf-FtSFQGB4u3fsNZIahUjU0Ke3K-O_apAvd3nPOfYmE21rT1suSJhZnYcTpdyPMj9J2wHdst1nmua3LRHJX5EG7vM5cnpfD_Tuo2Ou3Vhpd8NpwoAiWgJSFkSPkOFjPUMioUWWPEZ3OBAzRQ8EQaPBkgmPx_gDSuTey:1uWqDH:zFpYWATNcCJUt8j-0omH3pYZj5vvgKMunJrh20sWEhE', '2025-07-16 05:40:55.683613'),
('qsvfkoot2buauhb6ksgfp3ihy6quylzd', '.eJxVjE0OwiAYBe_C2hAolVKX7nsG8v0hVQNJaVfGu2uTLnT7Zua9VIRtzXFrssSZ1UWd1el3Q6CHlB3wHcqtaqplXWbUu6IP2vRUWZ7Xw_07yNDyt5YR2QTEYMl3fUpkwTAgJ3Z29GQNW3Y9oXeAHUBwAglkGEIyHEhAvT8gxDnJ:1unZyF:mrLP8lnEJ3bHxTs-9bh1t4CE1bJ4WA_WgUJFybtwgns', '2025-08-31 09:46:35.302998'),
('v63umliono5opnr7gx78wahpq5x71gxb', '.eJxVjDsOwyAQRO9CHSHALJ-U6X0GxLIQnERYMnYV5e6xJRdJNdK8N_NmIW5rDVvPS5iIXZlml98OY3rmdgB6xHafeZrbukzID4WftPNxpvy6ne7fQY297uucjHfCei89oYSsnQBNFvYQyioAm8gMEkQaFCVXhAEE0IgZIZZY2OcLtDs3TQ:1unDxT:g6WlepaIjqYiHJQsAgcwO5wj1ulkZUYlOjlrlzrdP1k', '2025-08-30 10:16:19.255815'),
('wq7yo3vs6dchd8d6g1sxzvdfvwt07841', '.eJxVjDsOwyAQRO9CHSHA5pcyvc-AdmEJTiIsGbuKcvdgyUXSTPHmzbxZgH0rYW-0hjmxKzPs8ssQ4pPqUaQH1PvC41K3dUZ-KPxsG5-WRK_b6f4dFGilr5UeNI6SdLQK0AppCZPrUCkX0ZhROacjkEU1aE3Jm5xzj-QFeEmCfb7Q-Te1:1uokjo:l596kPSOsN5jtwWvTrkfD1aQikxXJcEnpo81IT58pmw', '2025-09-03 15:28:32.954626'),
('ytr2nkp2ot4azc3e4c3lxb6pmluv954m', '.eJxVjEEOwiAQRe_C2hAYENGl-56hmRkGqRpISrsy3l2bdKHb_977LzXiupRx7TKPU1IXZUEdfkdCfkjdSLpjvTXNrS7zRHpT9E67HlqS53V3_w4K9vKt8XiOQIRgKLPLxgBH66Mh9hAwiFjBk4MUXcjeBfIC2XH24pAjiVXvDxL_OKk:1uszbc:FIMe6mAMcC7nCmhS0uKk4MYfp5vi4lBee94vKMc1b18', '2025-09-15 08:09:36.190266');

-- --------------------------------------------------------

--
-- Table structure for table `users_postcollection`
--

CREATE TABLE `users_postcollection` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_postcollection`
--

INSERT INTO `users_postcollection` (`id`, `created_at`, `user_id`) VALUES
(1, '2025-08-16 17:47:13.699301', 4),
(2, '2025-08-17 09:44:15.316039', 3),
(3, '2025-09-24 16:45:51.185691', 13),
(4, '2025-09-25 18:53:42.761421', 5),
(5, '2025-09-29 09:19:51.918066', 11);

-- --------------------------------------------------------

--
-- Table structure for table `users_postcollection_posts`
--

CREATE TABLE `users_postcollection_posts` (
  `id` bigint(20) NOT NULL,
  `postcollection_id` bigint(20) NOT NULL,
  `post_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_postcollection_posts`
--

INSERT INTO `users_postcollection_posts` (`id`, `postcollection_id`, `post_id`) VALUES
(5, 1, 1),
(4, 1, 7),
(3, 1, 8),
(1, 1, 9),
(9, 2, 9),
(13, 2, 31),
(11, 3, 17),
(10, 3, 18),
(12, 4, 30),
(14, 5, 35);

-- --------------------------------------------------------

--
-- Table structure for table `users_userprofile`
--

CREATE TABLE `users_userprofile` (
  `id` bigint(20) NOT NULL,
  `profession` varchar(40) NOT NULL,
  `work_link` longtext NOT NULL,
  `skills` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  `phone` varchar(200) NOT NULL,
  `profile_picture` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_userprofile`
--

INSERT INTO `users_userprofile` (`id`, `profession`, `work_link`, `skills`, `created_at`, `user_id`, `phone`, `profile_picture`) VALUES
(1, 'Website Tester', '[{\"id\": \"0f026131-4aac-455f-859e-43922333ce1d\", \"title\": \"GitHub\", \"url\": \"http://www.github.com\"}]', 'Penetration Testing\r\nSecurity Analyst\r\nWeb designer\r\nC\r\nC++', '2025-06-07 16:19:51.000000', 3, 'gAAAAABo0-kyaER4W--3BL8wGtMlxR5uxjhNoIuF3HYmRnr2AI_z4875StCavXmwu5-j5S4gwax95uiFMaBukmudIn__DAxeKQ==', 'profile_pics/images.jpeg'),
(2, 'Lecturer', '[{\"id\": \"56bd5f7a-a250-406a-8100-52675639d57e\", \"title\": \"WordPress template\", \"url\": \"http://wordpress.com\"}]', 'PHP', '2025-06-07 10:39:03.890978', 4, 'gAAAAABoRmOcjxpphSevnZXjGw0MaB45hwgSlECu4JEqpD2hVFTe_jLeJ40vJYt5sq06r8yhK9h9qKEAKOVJxV-yqjM7CGj78g==', ''),
(3, 'Educator', '[{\"id\": \"521009c8-c32e-4b34-9107-e1ef590d4cba\", \"title\": \"Duolingo\", \"url\": \"https://www.duolingo.com/\"}]', 'Public Speaking\nFrench\nSpanish', '2025-06-08 04:57:16.675907', 5, 'gAAAAABoRmQukD2Z6e-pFSzQfRMQNnszmRuORtOa1MKDjdjFzGdrmRkuTJmhlfK5p3_GAEsOZPPeix-XTxGVW5IprbOB_P5qZg==', 'profile_pics/clock.png'),
(4, 'Student', '[]', 'Python\nJavaScript\nBootStrap', '2025-06-08 05:10:58.552640', 6, 'gAAAAABoRmRnk9vJrY49pLOKt9rPcFk3ZFEQwdSB45-la7kVH8LTSyg5d16AJ66jHl0YvgnZvpIM-KkDOJf9hczdVrVyXylwbQ==', ''),
(5, 'Network Engineer', '[]', 'Server Maintenance, ERP Network Configuration', '2025-06-09 03:08:25.027062', 7, 'gAAAAABoRmSNlUJjN-ml4Wqt7AQDT6UwaODjaRA6qr4m3vjUGkwoUahJY8jIrEeAJicYjNp2nBqHMT-yCL4Fb6dw0xX2ZdZODw==', NULL),
(6, 'Cook', '[]', 'Java bean', '2025-08-29 04:25:48.896705', 9, 'gAAAAABosSvM8Qlc4u9q-J7vs875mIydMiD50G7egj1mT0ZEhIrw2SfUHHo4ROdoxwQQ02rrBAItMW_V2ZeqoGAIzim9wWBzVQ==', NULL),
(7, 'AWS Architect', '[]', 'Cloud architecture', '2025-08-29 05:36:04.318368', 10, 'gAAAAABosTxEVBhVMXrpyBJawEpoKjhFUp6XITzVW1P_8N3bR2CprkFwiUuz-N8axlAIKgrCRBudbLdNLI4r1ujyUMUL6xNYdg==', NULL),
(8, 'Graphic Programmer', '[{\"id\": \"574d9412-17d8-45b5-9918-8b2779e15097\", \"title\": \"Vocaloids\", \"url\": \"https://www.vocaloid.com/en/?srsltid=AfmBOorizcbovqJhI0kTX1bG4AROjROpGv6Ej3zUXj_DKPeYnrlu436N\"}, {\"id\": \"79ce467b-e5da-42f0-a49a-6d6af746921e\", \"title\": \"My WebApp\", \"url\": \"http://127.0.0.1:8000/\"}]', 'Illustration\nAnimatic\nVoice acting', '2025-08-29 07:06:18.971740', 11, 'gAAAAABosVFq70wEnT6mgYCK6Bfb6Y5q2Q9R44tdNZCngg9-mSC0g-sgEfrQS68GOS4A292eB_BkMjqS3o4ENvrL31On_u6qYA==', ''),
(9, 'Student', '[{\"id\": \"39e34795-e70c-46de-9ba6-1e4d61a91348\", \"title\": \"School Website\", \"url\": \"http://www.tarc.edu.my\"}]', 'Organic Chemistry', '2025-09-24 16:05:36.590618', 13, 'gAAAAABo1BbQmUFibA2HoCdiIB_W7xfGnfU1AxRBJ3DXZSJZFaEISmUTN3TAThSa4jAuUj8BP8PJ0ad5MldEMnh6PVke8ed4Fg==', 'profile_pics/Texturelabs_Sky_146S.jpg'),
(11, 'Student', '[{\"id\": \"532bf688-1ef8-4cf1-b736-9c0574d8d1ef\", \"title\": \"TARUMT Website\", \"url\": \"http://www.tarc.edu.my\"}]', 'Slide Design\r\nExcel\r\nWord', '2025-09-25 23:13:58.067249', 15, 'gAAAAABo1cy2GBfQmxAYRCTfdnC_wrST8zmC7SSVHVTG2ZEGQknL4v_YtYvX7qSR4hiUFvXDJokxLFY8iyXk3ugxyLiWHG0Qsw==', 'profile_pics/stsmall507x507-pad600x600f8f8f8_91rQMMV.jpg'),
(12, 'Intern', '', 'Python\r\nDjango\r\nBootStrap\nCooking', '2025-09-26 02:13:55.726720', 16, 'gAAAAABo1fdnAtplKAApKl096s39ctiaqQgz9LM3JMkJu05JN3m44EIMqjl0Npe2o6hv1zTRlvIbNJv4F6OfJ5IbbFW39p0i8g==', 'profile_pics/WhatsApp_Image_2025-09-22_at_13.20.31_7b15c82a.jpg'),
(14, 'Student', 'http://www.tarc.edu.my', 'Python', '2025-09-26 02:19:19.073960', 12, 'gAAAAABo1fgngCkO1XHNsUABb6GrBk9kqyse_3-AM7Y3lG7wkrocJXa4emXsIOcqJTiy_ZacODnE8BRYYJqvqcd3CO5nKF7yag==', ''),
(17, 'Student', '[]', 'Literature Writing', '2025-09-29 13:40:57.771456', 20, 'gAAAAABo2oxpUxZ6QWRxT3sMESeBcIRKLvU5kAd9u5YuzqSwk_t6czYR8RXCfOc7OgJH6jicABFGLbv3zZ5SVF8hiRbd_2M2xQ==', '');

-- --------------------------------------------------------

--
-- Table structure for table `witsnote_infographicsection`
--

CREATE TABLE `witsnote_infographicsection` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `order` int(10) UNSIGNED NOT NULL CHECK (`order` >= 0),
  `post_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `witsnote_infographicsection`
--

INSERT INTO `witsnote_infographicsection` (`id`, `title`, `content`, `order`, `post_id`) VALUES
(1, 'Set Clear Expectations', '...........', 2, 27),
(2, 'Check All Technical Requirements', '..............', 3, 27),
(3, 'Set Clear Expectations', '...........', 2, 28),
(4, 'Check All Technical Requirements', '..............', 3, 28),
(5, 'Set Clear Expectations', '.........', 2, 29),
(6, 'Check All Technical Requirements', '............', 3, 29),
(7, '', '..............', 4, 29),
(8, 'Section Title1', 'section1\r\n\r\nModified by dbadmin', 2, 30),
(9, 'Section Title2', 'section2', 3, 30),
(10, 'Section Title3', 'section3', 4, 30),
(11, 'Section 1', 'type your contents here', 2, 35),
(12, 'Section 2', 'your content jrngkdmvd', 3, 35),
(13, 'Section title 3', 'content here', 4, 35);

-- --------------------------------------------------------

--
-- Table structure for table `witsnote_listiclesubheading`
--

CREATE TABLE `witsnote_listiclesubheading` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `order` int(10) UNSIGNED NOT NULL CHECK (`order` >= 0),
  `post_id` bigint(20) NOT NULL,
  `content` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `witsnote_listiclesubheading`
--

INSERT INTO `witsnote_listiclesubheading` (`id`, `title`, `order`, `post_id`, `content`) VALUES
(1, 'Second subheading', 0, 22, 'Content of the second subheading'),
(2, 'Subheading 1', 0, 31, 'Ensure the analytics in admin page works'),
(3, 'Subheading 1', 0, 34, 'Type your contents here'),
(4, 'Subheading 2', 1, 34, 'Tpype your contents here');

-- --------------------------------------------------------

--
-- Table structure for table `witsnote_post`
--

CREATE TABLE `witsnote_post` (
  `id` bigint(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `thumbnail` varchar(100) NOT NULL,
  `content` longtext DEFAULT NULL,
  `slug` varchar(200) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `author_id` int(11) NOT NULL,
  `conclusion` longtext DEFAULT NULL,
  `introduction` longtext DEFAULT NULL,
  `post_type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `witsnote_post`
--

INSERT INTO `witsnote_post` (`id`, `title`, `thumbnail`, `content`, `slug`, `created_at`, `updated_at`, `author_id`, `conclusion`, `introduction`, `post_type`) VALUES
(1, 'Test Blog', '', 'Nothing here.', 'test-blog', '2025-07-05 18:50:18.348762', '2025-07-05 18:50:18.351048', 3, 'End testing here.', 'This is a blog post for testing purpose', 'Standard'),
(3, 'Testing Images', '', 'There are three images in total, please have a look!', 'testing-images-1', '2025-07-17 09:44:56.922740', '2025-07-17 09:44:56.934700', 7, 'End testing here.', 'Nothing important. This is just a testing to examine if the images will be saved to the database', 'Standard'),
(4, 'Testing Images', '', 'There are three images in total, please have a look!', 'testing-images-2', '2025-07-17 09:46:36.497478', '2025-07-17 09:46:36.505832', 7, 'End testing here.', 'Nothing important. This is just a testing to examine if the images will be saved to the database', 'Standard'),
(5, 'Another Test Case for Saving Images to DB', '', 'Test', 'another-test-case-for-saving-images-to-db', '2025-07-17 09:48:06.426885', '2025-07-17 09:48:06.437903', 7, 'tested', 'Testing purpose.', 'Standard'),
(6, 'Testing for Saving Uploaded Images', '', 'test', 'testing-for-saving-uploaded-images', '2025-07-17 09:55:49.951315', '2025-07-17 09:55:49.951315', 7, 'test', 'test', 'Standard'),
(7, 'Testing for Saving Uploaded Images', '', 'test', 'testing-for-saving-uploaded-images-1', '2025-07-17 09:57:35.109718', '2025-07-17 09:57:35.109718', 7, 'test', 'teset', 'Standard'),
(8, 'Testing again', '', 'test', 'testing-again', '2025-07-17 10:02:20.496056', '2025-07-17 10:02:20.496056', 7, 'test', 'test', 'Standard'),
(9, 'Final Testing, please...', '', 'test', 'final-testing-please', '2025-07-17 10:09:50.974768', '2025-07-17 10:09:50.974768', 7, 'test', 'test', 'Standard'),
(10, 'Tips to Increase Your Productivity', '', 'Increase productivity, you said? When the word, productivity comes into your mind, how do you define it and how can you related to someone qualified to be referred to as a productive person? In this article, I would like to share my several viewpoints and walk you through on the fact that how broad the term can relate to every little detail in your life.', 'tips-to-increase-your-productivity', '2025-08-17 09:56:22.069125', '2025-08-17 09:56:22.069125', 5, 'In short, the term \"productivity\" always leverages between self-discipline and effectiveness. It also involves various indispensable moral values that you can\'t get rid of in your real life.', 'My post might be dull or boring, but I bet you\'d like it at the end finish reading the article!', 'Standard'),
(11, 'Animal Wiki', '', 'The animal kingdom is divided into five major clades, namely Porifera, Ctenophora, Placozoa, Cnidaria and Bilateria. Most living animal species belong to the clade Bilateria, a highly proliferative clade whose members have a bilaterally symmetric and significantly cephalised body plan, and the vast majority of bilaterians belong to two large clades: the protostomes, which includes organisms such as arthropods, molluscs, flatworms, annelids and nematodes; and the deuterostomes, which include echinoderms, hemichordates and chordates, the latter of which contains the vertebrates. The much smaller basal phylum Xenacoelomorpha have an uncertain position within Bilateria.\r\n\r\nAnimals first appeared in the fossil record in the late Cryogenian period and diversified in the subsequent Ediacaran period in what is known as the Avalon explosion. Earlier evidence of animals is still controversial; the sponge-like organism Otavia has been dated back to the Tonian period at the start of the Neoproterozoic, but its identity as an animal is heavily contested.[5] Nearly all modern animal phyla first appeared in the fossil record as marine species during the Cambrian explosion, which began around 539 million years ago (Mya), and most classes during the Ordovician radiation 485.4 Mya. Common to all living animals, 6,331 groups of genes have been identified that may have arisen from a single common ancestor that lived about 650 Mya during the Cryogenian period.\r\n\r\nHistorically, Aristotle divided animals into those with blood and those without. Carl Linnaeus created the first hierarchical biological classification for animals in 1758 with his Systema Naturae, which Jean-Baptiste Lamarck expanded into 14 phyla by 1809. In 1874, Ernst Haeckel divided the animal kingdom into the multicellular Metazoa (now synonymous with Animalia) and the Protozoa, single-celled organisms no longer considered animals. In modern times, the biological classification of animals relies on advanced techniques, such as molecular phylogenetics, which are effective at demonstrating the evolutionary relationships between taxa.', 'animal-wiki', '2025-08-22 20:32:01.339668', '2025-08-22 20:32:01.339668', 6, 'Humans make use of many other animal species for food (including meat, eggs, and dairy products), for materials (such as leather, fur, and wool), as pets and as working animals for transportation, and services. Dogs, the first domesticated animal, have been used in hunting, in security and in warfare, as have horses, pigeons and birds of prey; while other terrestrial and aquatic animals are hunted for sports, trophies or profits. Non-human animals are also an important cultural element of human evolution, having appeared in cave arts and totems since the earliest times, and are frequently featured in mythology, religion, arts, literature, heraldry, politics, and sports.', 'Animals are multicellular, eukaryotic organisms comprising the biological kingdom Animalia (/ˌænɪˈmeɪliə/[4]). With few exceptions, animals consume organic material, breathe oxygen, have myocytes and are able to move, can reproduce sexually, and grow from a hollow sphere of cells, the blastula, during embryonic development. Animals form a clade, meaning that they arose from a single common ancestor. Over 1.5 million living animal species have been described, of which around 1.05 million are insects, over 85,000 are molluscs, and around 65,000 are vertebrates. It has been estimated there are as many as 7.77 million animal species on Earth. Animal body lengths range from 8.5 μm (0.00033 in) to 33.6 m (110 ft). They have complex ecologies and interactions with each other and their environments, forming intricate food webs. The scientific study of animals is known as zoology, and the study of animal behaviour is known as ethology.', 'Standard'),
(12, 'Turkey on Bean', '', 'Bbb', 'turkey-on-bean', '2025-08-29 04:26:57.502805', '2025-08-29 04:26:57.502805', 9, 'ccc :3', 'Aaa', 'Standard'),
(13, 'Bochi is testing', '', 'mainnnn', 'bochi-is-testing', '2025-08-29 05:37:55.955153', '2025-08-29 05:37:55.955153', 10, 'Filifala', 'intro', 'Standard'),
(14, 'Bochi is testing', '', 'mainnnn', 'bochi-is-testing-1', '2025-08-29 05:45:32.901856', '2025-08-29 05:45:32.901856', 10, 'Filifala', 'intro', 'Standard'),
(15, 'Bochi is testing', '', 'mainnnn', 'bochi-is-testing-2', '2025-08-29 05:46:23.936763', '2025-08-29 05:46:23.936763', 10, 'Filifala', 'intro', 'Standard'),
(16, 'Bochi is testing', '', 'mainnnn', 'bochi-is-testing-3', '2025-08-29 06:06:29.646019', '2025-08-29 06:06:29.646019', 10, 'Filifala', 'intro', 'Standard'),
(17, 'Bobbyy is testing', '', 'm', 'bobbyy-is-testing', '2025-08-29 06:21:09.540744', '2025-08-29 06:21:09.540744', 10, 'c', 'in', 'Standard'),
(18, 'Testing the Paragraph Separation', '', 'First of all, I would like to test if all the paragraph will be separated accordingly based on the paragraphs composed during editing.\r\n\r\n        Now, let\'s see if it will separate to second paragraph', 'testing-the-paragraph-separation', '2025-09-01 06:17:35.092097', '2025-09-01 06:17:35.092097', 11, 'That\'s all for the testing. Thank you!', 'This is an introduction of the blog post.', 'Standard'),
(19, 'The Starry Sky: Hoshizora', '', 'Main Content', 'the-starry-sky-hoshizora', '2025-09-25 13:31:55.309935', '2025-09-25 13:31:55.309935', 5, 'Conclusion', 'Introduction', 'Standard'),
(20, 'Types of AWS Cloud Architecture\r\n', '', 'Now I would like to talk about the usage of Cloud Architecture...\r\n\r\n        This paragraph introduces the pros and cons of using three-tier architecture for our web application...', 'types-of-aws-cloud-architecture', '2025-09-25 15:02:27.618003', '2025-09-25 15:02:27.618003', 5, 'To sum up, cloud architecture is a long way to explore but it does not only limit to three-tier and serverless architectures...', 'Introduction about Cloud Architecture.', 'Standard'),
(21, 'AWS Cloud Architectures', '', 'In this paragraph, I would like to cover the usage of cloud architecture...\r\n\r\n        Next, I\'ll be addressing the pros and cons of cloud architecture...', 'aws-cloud-architectures', '2025-09-25 15:10:35.301005', '2025-09-25 15:10:35.301005', 5, 'To sum up, the types of cloud architectures still a long way to explore because it does not merely limit to three-tier and serverless...', 'Introduction to Cloud Architecture.', 'Standard'),
(22, 'Testing Subheadings', '', 'Go go go', 'testing-subheadings', '2025-09-25 15:34:03.322855', '2025-09-25 15:34:03.322855', 5, 'Testing until here', 'Do you think subheading will successfully be stored?', 'Listicle'),
(24, 'Set Clear Expectations', '', '...........', 'set-clear-expectations', '2025-09-25 17:20:15.092295', '2025-09-25 17:20:15.094304', 5, '', '', 'Standard'),
(25, 'Check All Technical Requirements', '', '..............', 'check-all-technical-requirements', '2025-09-25 17:20:15.103955', '2025-09-25 17:20:15.104955', 5, '', '', 'Standard'),
(27, 'Info Post', '', '', 'info-post', '2025-09-25 17:37:08.309402', '2025-09-25 17:37:08.309402', 5, '', '', 'Infographic'),
(28, 'Info Post', '', '', 'info-post-1', '2025-09-25 17:41:00.993035', '2025-09-25 17:41:00.993035', 5, '', '', 'Infographic'),
(29, 'Testing infographic post', '', '', 'testing-infographic-post', '2025-09-25 17:53:48.562081', '2025-09-25 17:53:48.562081', 5, '', '', 'Infographic'),
(30, 'Section Testing', '', '', 'section-testing', '2025-09-25 18:09:43.026459', '2025-09-25 21:23:42.545637', 5, '', '', 'Infographic'),
(31, 'Test the analytic', '', 'Ensure the analytics in admin page works', 'test-the-analytic', '2025-09-25 22:03:59.582663', '2025-09-25 22:03:59.582663', 6, 'Ensure the analytics in admin page works', 'Ensure the analytics in admin page works', 'Listicle'),
(32, 'Blog Title', '', 'Main content is here blahblablah', 'blog-title', '2025-09-26 02:23:54.466334', '2025-09-26 02:23:54.466334', 3, 'Conclusion', 'The dog (Canis familiaris or Canis lupus familiaris) is a domesticated descendant of the gray wolf. Also called the domestic dog, it was selectively bred from a population of wolves during the Late Pleistocene by hunter-gatherers. The dog was the first species to be domesticated by humans, over 14,000 years ago and before the development of agriculture. Due to their long association with humans, dogs have gained the ability to thrive on a starch-rich diet that would be inadequate for other canids.', 'Standard'),
(33, 'BLog title', '', 'Main contents.................', 'blog-title-1', '2025-09-26 02:28:51.947476', '2025-09-26 02:28:51.947476', 3, 'Conclusions', 'The dog (Canis familiaris or Canis lupus familiaris) is a domesticated descendant of the gray wolf. Also called the domestic dog, it was selectively bred from a population of wolves during the Late Pleistocene by hunter-gatherers. The dog was the first species to be domesticated by humans, over 14,000 years ago and before the development of agriculture. Due to their long association with humans, dogs have gained the ability to thrive on a starch-rich diet that would be inadequate for other canids.', 'Standard'),
(34, 'Listicle Blog Post', '', '........................', 'listicle-blog-post', '2025-09-26 02:31:04.174595', '2025-09-26 02:31:04.174595', 3, '........................', '....................', 'Listicle'),
(35, 'Infographic', '', '', 'infographic', '2025-09-26 02:32:12.977468', '2025-09-26 02:32:12.977468', 3, '', '', 'Infographic');

-- --------------------------------------------------------

--
-- Table structure for table `witsnote_postimage`
--

CREATE TABLE `witsnote_postimage` (
  `id` bigint(20) NOT NULL,
  `section` varchar(50) NOT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `image` varchar(100) NOT NULL,
  `post_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `witsnote_postimage`
--

INSERT INTO `witsnote_postimage` (`id`, `section`, `uploaded_at`, `image`, `post_id`) VALUES
(1, 'introduction', '2025-07-17 10:09:51.054775', 'post_images/Cartethyia.jpg', 9),
(2, 'main_content', '2025-07-17 10:09:51.088338', 'post_images/Screenshot_251.png', 9),
(3, 'main_content', '2025-07-17 10:09:51.132258', 'post_images/Screenshot_252.png', 9),
(4, 'main_content', '2025-07-17 10:09:51.174269', 'post_images/Screenshot_253.png', 9),
(5, 'conclusion', '2025-07-17 10:09:51.192808', 'post_images/WhatsApp_Image_2025-05-18_at_19.18.57_d22232f2.jpg', 9),
(6, 'conclusion', '2025-07-17 10:09:51.292102', 'post_images/WhatsApp_Image_2025-05-18_at_19.18.57_d22232f2_upscayl_4x_realesrgan-x4plus-anime.png', 9),
(7, 'conclusion', '2025-07-17 10:09:51.357323', 'post_images/WhatsApp_Image_2025-07-12_at_18.57.13_34318d36_3840x2115-1.png', 9),
(8, 'introduction', '2025-09-25 13:31:55.331156', 'post_images/Stars.bmp', 19),
(9, 'introduction', '2025-09-25 15:10:35.313636', 'post_images/AWS_Cloud_Architecture_-_AWS_Cloud_Architecture_1.png', 21),
(10, 'introduction', '2025-09-25 15:10:35.323228', 'post_images/AWS_Cloud_Architecture_-_AWS_Cloud_Architecture.png', 21),
(11, 'main_content', '2025-09-25 15:10:35.330573', 'post_images/AWS_Cloud_Architecture_-_AWS_Cloud_Architecture_3.png', 21),
(12, 'main_content', '2025-09-25 15:10:35.339618', 'post_images/AWS_Cloud_Architecture_-_AWS_Cloud_Architecture_2.png', 21),
(13, 'conclusion', '2025-09-25 15:10:35.349064', 'post_images/AWS_Cloud_Architecture_-_AWS_Cloud_Architecture_4.png', 21),
(14, 'conclusion', '2025-09-25 15:10:35.359891', 'post_images/AWS_Cloud_Architecture_-_AWS_Cloud_Architecture_3_9CnabJZ.png', 21),
(15, 'conclusion', '2025-09-25 15:10:35.366455', 'post_images/AWS_Course_Outline.png', 21),
(16, 'introduction', '2025-09-26 02:23:54.478377', 'post_images/textual-image.png', 32),
(17, 'introduction', '2025-09-26 02:28:51.955552', 'post_images/WhatsApp_Image_2025-09-22_at_13.20.31_7b15c82a.jpg', 33),
(18, 'introduction', '2025-09-26 02:28:51.968621', 'post_images/Install__changing_Size_.jpg', 33),
(19, 'introduction', '2025-09-26 02:31:04.200845', 'post_images/textual-image_xPdXGQP.png', 34),
(20, 'main_content', '2025-09-26 02:31:04.209426', 'post_images/WhatsApp_Image_2025-09-22_at_13.20.31_7b15c82a_8oXvKsc.jpg', 34),
(21, 'main_content', '2025-09-26 02:31:04.223063', 'post_images/Install__changing_Size__FFujpkl.jpg', 34),
(22, 'conclusion', '2025-09-26 02:31:04.233119', 'post_images/Stars_S3vluvc.bmp', 34);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD PRIMARY KEY (`key`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `users_postcollection`
--
ALTER TABLE `users_postcollection`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_postcollection_user_id_72d0d569_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `users_postcollection_posts`
--
ALTER TABLE `users_postcollection_posts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_postcollection_pos_postcollection_id_post_i_f83b5140_uniq` (`postcollection_id`,`post_id`),
  ADD KEY `users_postcollection_posts_post_id_8206e35c_fk_witsnote_post_id` (`post_id`);

--
-- Indexes for table `users_userprofile`
--
ALTER TABLE `users_userprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `witsnote_infographicsection`
--
ALTER TABLE `witsnote_infographicsection`
  ADD PRIMARY KEY (`id`),
  ADD KEY `WitsNote_infographicsection_post_id_3724a453_fk_witsnote_post_id` (`post_id`);

--
-- Indexes for table `witsnote_listiclesubheading`
--
ALTER TABLE `witsnote_listiclesubheading`
  ADD PRIMARY KEY (`id`),
  ADD KEY `WitsNote_listiclesubheading_post_id_a704c70f_fk_witsnote_post_id` (`post_id`);

--
-- Indexes for table `witsnote_post`
--
ALTER TABLE `witsnote_post`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `Post_post_author_id_f4fab33d_fk_auth_user_id` (`author_id`);

--
-- Indexes for table `witsnote_postimage`
--
ALTER TABLE `witsnote_postimage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `WitsNote_postimage_post_id_2ad0a4a8_fk_witsnote_post_id` (`post_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `users_postcollection`
--
ALTER TABLE `users_postcollection`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users_postcollection_posts`
--
ALTER TABLE `users_postcollection_posts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users_userprofile`
--
ALTER TABLE `users_userprofile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `witsnote_infographicsection`
--
ALTER TABLE `witsnote_infographicsection`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `witsnote_listiclesubheading`
--
ALTER TABLE `witsnote_listiclesubheading`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `witsnote_post`
--
ALTER TABLE `witsnote_post`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `witsnote_postimage`
--
ALTER TABLE `witsnote_postimage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `users_postcollection`
--
ALTER TABLE `users_postcollection`
  ADD CONSTRAINT `users_postcollection_user_id_72d0d569_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `users_postcollection_posts`
--
ALTER TABLE `users_postcollection_posts`
  ADD CONSTRAINT `users_postcollection_postcollection_id_0322fc77_fk_users_pos` FOREIGN KEY (`postcollection_id`) REFERENCES `users_postcollection` (`id`),
  ADD CONSTRAINT `users_postcollection_posts_post_id_8206e35c_fk_witsnote_post_id` FOREIGN KEY (`post_id`) REFERENCES `witsnote_post` (`id`);

--
-- Constraints for table `users_userprofile`
--
ALTER TABLE `users_userprofile`
  ADD CONSTRAINT `users_userprofile_user_id_87251ef1_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `witsnote_infographicsection`
--
ALTER TABLE `witsnote_infographicsection`
  ADD CONSTRAINT `WitsNote_infographicsection_post_id_3724a453_fk_witsnote_post_id` FOREIGN KEY (`post_id`) REFERENCES `witsnote_post` (`id`);

--
-- Constraints for table `witsnote_listiclesubheading`
--
ALTER TABLE `witsnote_listiclesubheading`
  ADD CONSTRAINT `WitsNote_listiclesubheading_post_id_a704c70f_fk_witsnote_post_id` FOREIGN KEY (`post_id`) REFERENCES `witsnote_post` (`id`);

--
-- Constraints for table `witsnote_post`
--
ALTER TABLE `witsnote_post`
  ADD CONSTRAINT `Post_post_author_id_f4fab33d_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `witsnote_postimage`
--
ALTER TABLE `witsnote_postimage`
  ADD CONSTRAINT `WitsNote_postimage_post_id_2ad0a4a8_fk_witsnote_post_id` FOREIGN KEY (`post_id`) REFERENCES `witsnote_post` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
