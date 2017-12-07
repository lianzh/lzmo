/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.5.53 : Database - lianzh_mo
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `{db_table_prefix}asset_downloads` */

DROP TABLE IF EXISTS `{db_table_prefix}asset_downloads`;

CREATE TABLE `{db_table_prefix}asset_downloads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(11) DEFAULT NULL,
  `ip_id` int(11) NOT NULL,
  `lead_id` int(11) DEFAULT NULL,
  `email_id` int(11) DEFAULT NULL,
  `date_download` datetime NOT NULL,
  `code` int(11) NOT NULL,
  `referer` longtext COLLATE utf8_unicode_ci,
  `tracking_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `source` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_FD988F0B5DA1941` (`asset_id`),
  KEY `IDX_FD988F0BA03F5E9F` (`ip_id`),
  KEY `IDX_FD988F0B55458D` (`lead_id`),
  KEY `IDX_FD988F0BA832C1C9` (`email_id`),
  KEY `{db_table_prefix}download_tracking_search` (`tracking_id`),
  KEY `{db_table_prefix}download_source_search` (`source`,`source_id`),
  KEY `{db_table_prefix}asset_date_download` (`date_download`),
  CONSTRAINT `FK_FD988F0B55458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_FD988F0B5DA1941` FOREIGN KEY (`asset_id`) REFERENCES `{db_table_prefix}assets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_FD988F0BA03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `{db_table_prefix}ip_addresses` (`id`),
  CONSTRAINT `FK_FD988F0BA832C1C9` FOREIGN KEY (`email_id`) REFERENCES `{db_table_prefix}emails` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}assets` */

DROP TABLE IF EXISTS `{db_table_prefix}assets`;

CREATE TABLE `{db_table_prefix}assets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `alias` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `storage_location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remote_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `original_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lang` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `download_count` int(11) NOT NULL,
  `unique_download_count` int(11) NOT NULL,
  `revision` int(11) NOT NULL,
  `extension` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mime` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7C40AE3512469DE2` (`category_id`),
  KEY `{db_table_prefix}asset_alias_search` (`alias`),
  CONSTRAINT `FK_7C40AE3512469DE2` FOREIGN KEY (`category_id`) REFERENCES `{db_table_prefix}categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}audit_log` */

DROP TABLE IF EXISTS `{db_table_prefix}audit_log`;

CREATE TABLE `{db_table_prefix}audit_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `bundle` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `object` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `object_id` int(11) NOT NULL,
  `action` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `details` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `date_added` datetime NOT NULL,
  `ip_address` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `{db_table_prefix}object_search` (`object`,`object_id`),
  KEY `{db_table_prefix}timeline_search` (`bundle`,`object`,`action`,`object_id`),
  KEY `{db_table_prefix}date_added_index` (`date_added`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}cache_items` */

DROP TABLE IF EXISTS `{db_table_prefix}cache_items`;

CREATE TABLE `{db_table_prefix}cache_items` (
  `item_id` varbinary(255) NOT NULL,
  `item_data` longblob NOT NULL,
  `item_lifetime` int(10) unsigned DEFAULT NULL,
  `item_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}campaign_events` */

DROP TABLE IF EXISTS `{db_table_prefix}campaign_events`;

CREATE TABLE `{db_table_prefix}campaign_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `campaign_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `event_type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `event_order` int(11) NOT NULL,
  `properties` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `trigger_date` datetime DEFAULT NULL,
  `trigger_interval` int(11) DEFAULT NULL,
  `trigger_interval_unit` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `trigger_mode` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `decision_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `temp_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D515ED63F639F774` (`campaign_id`),
  KEY `IDX_D515ED63727ACA70` (`parent_id`),
  KEY `{db_table_prefix}campaign_event_search` (`type`,`event_type`),
  KEY `{db_table_prefix}campaign_event_type` (`event_type`),
  KEY `{db_table_prefix}campaign_event_channel` (`channel`,`channel_id`),
  CONSTRAINT `FK_D515ED63727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `{db_table_prefix}campaign_events` (`id`),
  CONSTRAINT `FK_D515ED63F639F774` FOREIGN KEY (`campaign_id`) REFERENCES `{db_table_prefix}campaigns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}campaign_form_xref` */

DROP TABLE IF EXISTS `{db_table_prefix}campaign_form_xref`;

CREATE TABLE `{db_table_prefix}campaign_form_xref` (
  `campaign_id` int(11) NOT NULL,
  `form_id` int(11) NOT NULL,
  PRIMARY KEY (`campaign_id`,`form_id`),
  KEY `IDX_C7777D7AF639F774` (`campaign_id`),
  KEY `IDX_C7777D7A5FF69B7D` (`form_id`),
  CONSTRAINT `FK_C7777D7A5FF69B7D` FOREIGN KEY (`form_id`) REFERENCES `{db_table_prefix}forms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_C7777D7AF639F774` FOREIGN KEY (`campaign_id`) REFERENCES `{db_table_prefix}campaigns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}campaign_lead_event_failed_log` */

DROP TABLE IF EXISTS `{db_table_prefix}campaign_lead_event_failed_log`;

CREATE TABLE `{db_table_prefix}campaign_lead_event_failed_log` (
  `log_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  `reason` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`log_id`),
  KEY `{db_table_prefix}campaign_event_failed_date` (`date_added`),
  CONSTRAINT `FK_A6C98923EA675D86` FOREIGN KEY (`log_id`) REFERENCES `{db_table_prefix}campaign_lead_event_log` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}campaign_lead_event_log` */

DROP TABLE IF EXISTS `{db_table_prefix}campaign_lead_event_log`;

CREATE TABLE `{db_table_prefix}campaign_lead_event_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `campaign_id` int(11) DEFAULT NULL,
  `ip_id` int(11) DEFAULT NULL,
  `rotation` int(11) NOT NULL,
  `date_triggered` datetime DEFAULT NULL,
  `is_scheduled` tinyint(1) NOT NULL,
  `trigger_date` datetime DEFAULT NULL,
  `system_triggered` tinyint(1) NOT NULL,
  `metadata` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `channel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel_id` int(11) DEFAULT NULL,
  `non_action_path_taken` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `{db_table_prefix}campaign_rotation` (`event_id`,`lead_id`,`rotation`),
  KEY `IDX_B6734C771F7E88B` (`event_id`),
  KEY `IDX_B6734C755458D` (`lead_id`),
  KEY `IDX_B6734C7F639F774` (`campaign_id`),
  KEY `IDX_B6734C7A03F5E9F` (`ip_id`),
  KEY `{db_table_prefix}campaign_event_upcoming_search` (`is_scheduled`,`lead_id`),
  KEY `{db_table_prefix}campaign_date_triggered` (`date_triggered`),
  KEY `{db_table_prefix}campaign_leads` (`lead_id`,`campaign_id`,`rotation`),
  KEY `{db_table_prefix}campaign_log_channel` (`channel`,`channel_id`,`lead_id`),
  CONSTRAINT `FK_B6734C755458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_B6734C771F7E88B` FOREIGN KEY (`event_id`) REFERENCES `{db_table_prefix}campaign_events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_B6734C7A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `{db_table_prefix}ip_addresses` (`id`),
  CONSTRAINT `FK_B6734C7F639F774` FOREIGN KEY (`campaign_id`) REFERENCES `{db_table_prefix}campaigns` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}campaign_leadlist_xref` */

DROP TABLE IF EXISTS `{db_table_prefix}campaign_leadlist_xref`;

CREATE TABLE `{db_table_prefix}campaign_leadlist_xref` (
  `campaign_id` int(11) NOT NULL,
  `leadlist_id` int(11) NOT NULL,
  PRIMARY KEY (`campaign_id`,`leadlist_id`),
  KEY `IDX_273C799FF639F774` (`campaign_id`),
  KEY `IDX_273C799FB9FC8874` (`leadlist_id`),
  CONSTRAINT `FK_273C799FB9FC8874` FOREIGN KEY (`leadlist_id`) REFERENCES `{db_table_prefix}lead_lists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_273C799FF639F774` FOREIGN KEY (`campaign_id`) REFERENCES `{db_table_prefix}campaigns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}campaign_leads` */

DROP TABLE IF EXISTS `{db_table_prefix}campaign_leads`;

CREATE TABLE `{db_table_prefix}campaign_leads` (
  `campaign_id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  `manually_removed` tinyint(1) NOT NULL,
  `manually_added` tinyint(1) NOT NULL,
  `date_last_exited` datetime DEFAULT NULL,
  `rotation` int(11) NOT NULL,
  PRIMARY KEY (`campaign_id`,`lead_id`),
  KEY `IDX_56F8B882F639F774` (`campaign_id`),
  KEY `IDX_56F8B88255458D` (`lead_id`),
  KEY `{db_table_prefix}campaign_leads_date_added` (`date_added`),
  KEY `{db_table_prefix}campaign_leads_date_exited` (`date_last_exited`),
  KEY `{db_table_prefix}campaign_leads` (`campaign_id`,`manually_removed`,`lead_id`,`rotation`),
  CONSTRAINT `FK_56F8B88255458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_56F8B882F639F774` FOREIGN KEY (`campaign_id`) REFERENCES `{db_table_prefix}campaigns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}campaigns` */

DROP TABLE IF EXISTS `{db_table_prefix}campaigns`;

CREATE TABLE `{db_table_prefix}campaigns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `canvas_settings` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_765508A12469DE2` (`category_id`),
  CONSTRAINT `FK_765508A12469DE2` FOREIGN KEY (`category_id`) REFERENCES `{db_table_prefix}categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}categories` */

DROP TABLE IF EXISTS `{db_table_prefix}categories`;

CREATE TABLE `{db_table_prefix}categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `alias` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `color` varchar(7) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bundle` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `{db_table_prefix}category_alias_search` (`alias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}channel_url_trackables` */

DROP TABLE IF EXISTS `{db_table_prefix}channel_url_trackables`;

CREATE TABLE `{db_table_prefix}channel_url_trackables` (
  `redirect_id` int(11) NOT NULL,
  `channel_id` int(11) NOT NULL,
  `channel` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hits` int(11) NOT NULL,
  `unique_hits` int(11) NOT NULL,
  PRIMARY KEY (`redirect_id`,`channel_id`),
  KEY `IDX_6C3DD8ACB42D874D` (`redirect_id`),
  KEY `{db_table_prefix}channel_url_trackable_search` (`channel`,`channel_id`),
  CONSTRAINT `FK_6C3DD8ACB42D874D` FOREIGN KEY (`redirect_id`) REFERENCES `{db_table_prefix}page_redirects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}companies` */

DROP TABLE IF EXISTS `{db_table_prefix}companies`;

CREATE TABLE `{db_table_prefix}companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `social_cache` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `score` int(11) DEFAULT NULL,
  `companyemail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `companyaddress1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `companyaddress2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `companyphone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `companycity` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `companystate` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `companyzipcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `companycountry` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `companyname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `companywebsite` longtext COLLATE utf8_unicode_ci,
  `companyindustry` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `companydescription` longtext COLLATE utf8_unicode_ci,
  `companynumber_of_employees` double DEFAULT NULL,
  `companyfax` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `companyannual_revenue` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_66528EC07E3C61F9` (`owner_id`),
  KEY `{db_table_prefix}companyaddress1_search` (`companyaddress1`),
  KEY `{db_table_prefix}companyaddress2_search` (`companyaddress2`),
  KEY `{db_table_prefix}companyemail_search` (`companyemail`),
  KEY `{db_table_prefix}companyphone_search` (`companyphone`),
  KEY `{db_table_prefix}companycity_search` (`companycity`),
  KEY `{db_table_prefix}companystate_search` (`companystate`),
  KEY `{db_table_prefix}companyzipcode_search` (`companyzipcode`),
  KEY `{db_table_prefix}companycountry_search` (`companycountry`),
  KEY `{db_table_prefix}companyname_search` (`companyname`),
  KEY `{db_table_prefix}companynumber_of_employees_search` (`companynumber_of_employees`),
  KEY `{db_table_prefix}companyfax_search` (`companyfax`),
  KEY `{db_table_prefix}companyannual_revenue_search` (`companyannual_revenue`),
  KEY `{db_table_prefix}companyindustry_search` (`companyindustry`),
  KEY `{db_table_prefix}company_filter` (`companyname`,`companyemail`),
  KEY `{db_table_prefix}company_match` (`companyname`,`companycity`,`companycountry`,`companystate`),
  CONSTRAINT `FK_66528EC07E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `{db_table_prefix}users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}companies_leads` */

DROP TABLE IF EXISTS `{db_table_prefix}companies_leads`;

CREATE TABLE `{db_table_prefix}companies_leads` (
  `company_id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  `is_primary` tinyint(1) DEFAULT NULL,
  `manually_removed` tinyint(1) NOT NULL,
  `manually_added` tinyint(1) NOT NULL,
  PRIMARY KEY (`company_id`,`lead_id`),
  KEY `IDX_AFC8C932979B1AD6` (`company_id`),
  KEY `IDX_AFC8C93255458D` (`lead_id`),
  CONSTRAINT `FK_AFC8C93255458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_AFC8C932979B1AD6` FOREIGN KEY (`company_id`) REFERENCES `{db_table_prefix}companies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}contact_merge_records` */

DROP TABLE IF EXISTS `{db_table_prefix}contact_merge_records`;

CREATE TABLE `{db_table_prefix}contact_merge_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  `merged_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C2129D7E7A1254A` (`contact_id`),
  KEY `{db_table_prefix}contact_merge_date_added` (`date_added`),
  KEY `{db_table_prefix}contact_merge_ids` (`merged_id`),
  CONSTRAINT `FK_C2129D7E7A1254A` FOREIGN KEY (`contact_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}dynamic_content` */

DROP TABLE IF EXISTS `{db_table_prefix}dynamic_content`;

CREATE TABLE `{db_table_prefix}dynamic_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `translation_parent_id` int(11) DEFAULT NULL,
  `variant_parent_id` int(11) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `sent_count` int(11) NOT NULL,
  `content` longtext COLLATE utf8_unicode_ci,
  `lang` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `variant_settings` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `variant_start_date` datetime DEFAULT NULL,
  `filters` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `is_campaign_based` tinyint(1) NOT NULL DEFAULT '1',
  `slot_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7B681D3612469DE2` (`category_id`),
  KEY `IDX_7B681D369091A2FB` (`translation_parent_id`),
  KEY `IDX_7B681D3691861123` (`variant_parent_id`),
  KEY `{db_table_prefix}is_campaign_based_index` (`is_campaign_based`),
  KEY `{db_table_prefix}slot_name_index` (`slot_name`),
  CONSTRAINT `FK_7B681D3612469DE2` FOREIGN KEY (`category_id`) REFERENCES `{db_table_prefix}categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_7B681D369091A2FB` FOREIGN KEY (`translation_parent_id`) REFERENCES `{db_table_prefix}dynamic_content` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_7B681D3691861123` FOREIGN KEY (`variant_parent_id`) REFERENCES `{db_table_prefix}dynamic_content` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}dynamic_content_lead_data` */

DROP TABLE IF EXISTS `{db_table_prefix}dynamic_content_lead_data`;

CREATE TABLE `{db_table_prefix}dynamic_content_lead_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lead_id` int(11) NOT NULL,
  `dynamic_content_id` int(11) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `slot` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D49A7F2255458D` (`lead_id`),
  KEY `IDX_D49A7F22D9D0CD7` (`dynamic_content_id`),
  CONSTRAINT `FK_D49A7F2255458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_D49A7F22D9D0CD7` FOREIGN KEY (`dynamic_content_id`) REFERENCES `{db_table_prefix}dynamic_content` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}dynamic_content_stats` */

DROP TABLE IF EXISTS `{db_table_prefix}dynamic_content_stats`;

CREATE TABLE `{db_table_prefix}dynamic_content_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dynamic_content_id` int(11) DEFAULT NULL,
  `lead_id` int(11) DEFAULT NULL,
  `date_sent` datetime NOT NULL,
  `source` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `tokens` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `sent_count` int(11) DEFAULT NULL,
  `last_sent` datetime DEFAULT NULL,
  `sent_details` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_311A64E8D9D0CD7` (`dynamic_content_id`),
  KEY `IDX_311A64E855458D` (`lead_id`),
  KEY `{db_table_prefix}stat_dynamic_content_search` (`dynamic_content_id`,`lead_id`),
  KEY `{db_table_prefix}stat_dynamic_content_source_search` (`source`,`source_id`),
  CONSTRAINT `FK_311A64E855458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_311A64E8D9D0CD7` FOREIGN KEY (`dynamic_content_id`) REFERENCES `{db_table_prefix}dynamic_content` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}email_assets_xref` */

DROP TABLE IF EXISTS `{db_table_prefix}email_assets_xref`;

CREATE TABLE `{db_table_prefix}email_assets_xref` (
  `email_id` int(11) NOT NULL,
  `asset_id` int(11) NOT NULL,
  PRIMARY KEY (`email_id`,`asset_id`),
  KEY `IDX_97B3C2ECA832C1C9` (`email_id`),
  KEY `IDX_97B3C2EC5DA1941` (`asset_id`),
  CONSTRAINT `FK_97B3C2EC5DA1941` FOREIGN KEY (`asset_id`) REFERENCES `{db_table_prefix}assets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_97B3C2ECA832C1C9` FOREIGN KEY (`email_id`) REFERENCES `{db_table_prefix}emails` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}email_copies` */

DROP TABLE IF EXISTS `{db_table_prefix}email_copies`;

CREATE TABLE `{db_table_prefix}email_copies` (
  `id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `date_created` datetime NOT NULL,
  `body` longtext COLLATE utf8_unicode_ci,
  `subject` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}email_list_xref` */

DROP TABLE IF EXISTS `{db_table_prefix}email_list_xref`;

CREATE TABLE `{db_table_prefix}email_list_xref` (
  `email_id` int(11) NOT NULL,
  `leadlist_id` int(11) NOT NULL,
  PRIMARY KEY (`email_id`,`leadlist_id`),
  KEY `IDX_75F53398A832C1C9` (`email_id`),
  KEY `IDX_75F53398B9FC8874` (`leadlist_id`),
  CONSTRAINT `FK_75F53398A832C1C9` FOREIGN KEY (`email_id`) REFERENCES `{db_table_prefix}emails` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_75F53398B9FC8874` FOREIGN KEY (`leadlist_id`) REFERENCES `{db_table_prefix}lead_lists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}email_stat_replies` */

DROP TABLE IF EXISTS `{db_table_prefix}email_stat_replies`;

CREATE TABLE `{db_table_prefix}email_stat_replies` (
  `id` char(36) COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:guid)',
  `stat_id` int(11) NOT NULL,
  `date_replied` datetime NOT NULL,
  `message_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E6D623289502F0B` (`stat_id`),
  KEY `{db_table_prefix}email_replies` (`stat_id`,`message_id`),
  KEY `{db_table_prefix}date_email_replied` (`date_replied`),
  CONSTRAINT `FK_E6D623289502F0B` FOREIGN KEY (`stat_id`) REFERENCES `{db_table_prefix}email_stats` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}email_stats` */

DROP TABLE IF EXISTS `{db_table_prefix}email_stats`;

CREATE TABLE `{db_table_prefix}email_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email_id` int(11) DEFAULT NULL,
  `lead_id` int(11) DEFAULT NULL,
  `list_id` int(11) DEFAULT NULL,
  `ip_id` int(11) DEFAULT NULL,
  `copy_id` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_sent` datetime NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `is_failed` tinyint(1) NOT NULL,
  `viewed_in_browser` tinyint(1) NOT NULL,
  `date_read` datetime DEFAULT NULL,
  `tracking_hash` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `retry_count` int(11) DEFAULT NULL,
  `source` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `tokens` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `open_count` int(11) DEFAULT NULL,
  `last_opened` datetime DEFAULT NULL,
  `open_details` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_185A2FD5A832C1C9` (`email_id`),
  KEY `IDX_185A2FD555458D` (`lead_id`),
  KEY `IDX_185A2FD53DAE168B` (`list_id`),
  KEY `IDX_185A2FD5A03F5E9F` (`ip_id`),
  KEY `IDX_185A2FD5A8752772` (`copy_id`),
  KEY `{db_table_prefix}stat_email_search` (`email_id`,`lead_id`),
  KEY `{db_table_prefix}stat_email_search2` (`lead_id`,`email_id`),
  KEY `{db_table_prefix}stat_email_failed_search` (`is_failed`),
  KEY `{db_table_prefix}stat_email_read_search` (`is_read`),
  KEY `{db_table_prefix}stat_email_hash_search` (`tracking_hash`),
  KEY `{db_table_prefix}stat_email_source_search` (`source`,`source_id`),
  KEY `{db_table_prefix}email_date_sent` (`date_sent`),
  KEY `{db_table_prefix}email_date_read` (`date_read`),
  CONSTRAINT `FK_185A2FD53DAE168B` FOREIGN KEY (`list_id`) REFERENCES `{db_table_prefix}lead_lists` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_185A2FD555458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_185A2FD5A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `{db_table_prefix}ip_addresses` (`id`),
  CONSTRAINT `FK_185A2FD5A832C1C9` FOREIGN KEY (`email_id`) REFERENCES `{db_table_prefix}emails` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_185A2FD5A8752772` FOREIGN KEY (`copy_id`) REFERENCES `{db_table_prefix}email_copies` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}email_stats_devices` */

DROP TABLE IF EXISTS `{db_table_prefix}email_stats_devices`;

CREATE TABLE `{db_table_prefix}email_stats_devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` int(11) DEFAULT NULL,
  `stat_id` int(11) DEFAULT NULL,
  `ip_id` int(11) DEFAULT NULL,
  `date_opened` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_EFC2693894A4C7D4` (`device_id`),
  KEY `IDX_EFC269389502F0B` (`stat_id`),
  KEY `IDX_EFC26938A03F5E9F` (`ip_id`),
  KEY `{db_table_prefix}date_opened_search` (`date_opened`),
  CONSTRAINT `FK_EFC2693894A4C7D4` FOREIGN KEY (`device_id`) REFERENCES `{db_table_prefix}lead_devices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_EFC269389502F0B` FOREIGN KEY (`stat_id`) REFERENCES `{db_table_prefix}email_stats` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_EFC26938A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `{db_table_prefix}ip_addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}emails` */

DROP TABLE IF EXISTS `{db_table_prefix}emails`;

CREATE TABLE `{db_table_prefix}emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `translation_parent_id` int(11) DEFAULT NULL,
  `variant_parent_id` int(11) DEFAULT NULL,
  `unsubscribeform_id` int(11) DEFAULT NULL,
  `preference_center_id` int(11) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `subject` longtext COLLATE utf8_unicode_ci,
  `from_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `from_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reply_to_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bcc_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `template` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `utm_tags` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `plain_text` longtext COLLATE utf8_unicode_ci,
  `custom_html` longtext COLLATE utf8_unicode_ci,
  `email_type` longtext COLLATE utf8_unicode_ci,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `read_count` int(11) NOT NULL,
  `sent_count` int(11) NOT NULL,
  `revision` int(11) NOT NULL,
  `lang` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `variant_settings` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `variant_start_date` datetime DEFAULT NULL,
  `dynamic_content` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `variant_sent_count` int(11) NOT NULL,
  `variant_read_count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_49103BE912469DE2` (`category_id`),
  KEY `IDX_49103BE99091A2FB` (`translation_parent_id`),
  KEY `IDX_49103BE991861123` (`variant_parent_id`),
  KEY `IDX_49103BE92DC494F6` (`unsubscribeform_id`),
  KEY `IDX_49103BE9834F9C5B` (`preference_center_id`),
  CONSTRAINT `FK_49103BE912469DE2` FOREIGN KEY (`category_id`) REFERENCES `{db_table_prefix}categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_49103BE92DC494F6` FOREIGN KEY (`unsubscribeform_id`) REFERENCES `{db_table_prefix}forms` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_49103BE9834F9C5B` FOREIGN KEY (`preference_center_id`) REFERENCES `{db_table_prefix}pages` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_49103BE99091A2FB` FOREIGN KEY (`translation_parent_id`) REFERENCES `{db_table_prefix}emails` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_49103BE991861123` FOREIGN KEY (`variant_parent_id`) REFERENCES `{db_table_prefix}emails` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}focus` */

DROP TABLE IF EXISTS `{db_table_prefix}focus`;

CREATE TABLE `{db_table_prefix}focus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `focus_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `style` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `properties` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `utm_tags` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `form_id` int(11) DEFAULT NULL,
  `cache` longtext COLLATE utf8_unicode_ci,
  `html_mode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `editor` longtext COLLATE utf8_unicode_ci,
  `html` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_F344E22E12469DE2` (`category_id`),
  KEY `{db_table_prefix}focus_type` (`focus_type`),
  KEY `{db_table_prefix}focus_style` (`style`),
  KEY `{db_table_prefix}focus_form` (`form_id`),
  CONSTRAINT `FK_F344E22E12469DE2` FOREIGN KEY (`category_id`) REFERENCES `{db_table_prefix}categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}focus_stats` */

DROP TABLE IF EXISTS `{db_table_prefix}focus_stats`;

CREATE TABLE `{db_table_prefix}focus_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `focus_id` int(11) NOT NULL,
  `lead_id` int(11) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type_id` int(11) DEFAULT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_1139792C51804B42` (`focus_id`),
  KEY `IDX_1139792C55458D` (`lead_id`),
  KEY `{db_table_prefix}focus_type` (`type`),
  KEY `{db_table_prefix}focus_type_id` (`type`,`type_id`),
  KEY `{db_table_prefix}focus_date_added` (`date_added`),
  CONSTRAINT `FK_1139792C51804B42` FOREIGN KEY (`focus_id`) REFERENCES `{db_table_prefix}focus` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_1139792C55458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}form_actions` */

DROP TABLE IF EXISTS `{db_table_prefix}form_actions`;

CREATE TABLE `{db_table_prefix}form_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `action_order` int(11) NOT NULL,
  `properties` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_894B33C15FF69B7D` (`form_id`),
  KEY `{db_table_prefix}form_action_type_search` (`type`),
  CONSTRAINT `FK_894B33C15FF69B7D` FOREIGN KEY (`form_id`) REFERENCES `{db_table_prefix}forms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}form_fields` */

DROP TABLE IF EXISTS `{db_table_prefix}form_fields`;

CREATE TABLE `{db_table_prefix}form_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL,
  `label` longtext COLLATE utf8_unicode_ci NOT NULL,
  `show_label` tinyint(1) DEFAULT NULL,
  `alias` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `is_custom` tinyint(1) NOT NULL,
  `custom_parameters` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `default_value` longtext COLLATE utf8_unicode_ci,
  `is_required` tinyint(1) NOT NULL,
  `validation_message` longtext COLLATE utf8_unicode_ci,
  `help_message` longtext COLLATE utf8_unicode_ci,
  `field_order` int(11) DEFAULT NULL,
  `properties` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `label_attr` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `input_attr` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `container_attr` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_field` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `save_result` tinyint(1) DEFAULT NULL,
  `is_auto_fill` tinyint(1) DEFAULT NULL,
  `show_when_value_exists` tinyint(1) DEFAULT NULL,
  `show_after_x_submissions` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_AE5B3ED65FF69B7D` (`form_id`),
  KEY `{db_table_prefix}form_field_type_search` (`type`),
  CONSTRAINT `FK_AE5B3ED65FF69B7D` FOREIGN KEY (`form_id`) REFERENCES `{db_table_prefix}forms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}form_submissions` */

DROP TABLE IF EXISTS `{db_table_prefix}form_submissions`;

CREATE TABLE `{db_table_prefix}form_submissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL,
  `ip_id` int(11) NOT NULL,
  `lead_id` int(11) DEFAULT NULL,
  `page_id` int(11) DEFAULT NULL,
  `tracking_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_submitted` datetime NOT NULL,
  `referer` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_22846F1C5FF69B7D` (`form_id`),
  KEY `IDX_22846F1CA03F5E9F` (`ip_id`),
  KEY `IDX_22846F1C55458D` (`lead_id`),
  KEY `IDX_22846F1CC4663E4` (`page_id`),
  KEY `{db_table_prefix}form_submission_tracking_search` (`tracking_id`),
  KEY `{db_table_prefix}form_date_submitted` (`date_submitted`),
  CONSTRAINT `FK_22846F1C55458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_22846F1C5FF69B7D` FOREIGN KEY (`form_id`) REFERENCES `{db_table_prefix}forms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_22846F1CA03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `{db_table_prefix}ip_addresses` (`id`),
  CONSTRAINT `FK_22846F1CC4663E4` FOREIGN KEY (`page_id`) REFERENCES `{db_table_prefix}pages` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}forms` */

DROP TABLE IF EXISTS `{db_table_prefix}forms`;

CREATE TABLE `{db_table_prefix}forms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `alias` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cached_html` longtext COLLATE utf8_unicode_ci,
  `post_action` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `post_action_property` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `template` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `in_kiosk_mode` tinyint(1) DEFAULT NULL,
  `render_style` tinyint(1) DEFAULT NULL,
  `form_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_6CBBB33012469DE2` (`category_id`),
  CONSTRAINT `FK_6CBBB33012469DE2` FOREIGN KEY (`category_id`) REFERENCES `{db_table_prefix}categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}imports` */

DROP TABLE IF EXISTS `{db_table_prefix}imports`;

CREATE TABLE `{db_table_prefix}imports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dir` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `file` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `original_file` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `line_count` int(11) NOT NULL,
  `inserted_count` int(11) NOT NULL,
  `updated_count` int(11) NOT NULL,
  `ignored_count` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `date_started` datetime DEFAULT NULL,
  `date_ended` datetime DEFAULT NULL,
  `object` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `properties` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`),
  KEY `{db_table_prefix}import_object` (`object`),
  KEY `{db_table_prefix}import_status` (`status`),
  KEY `{db_table_prefix}import_priority` (`priority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}integration_entity` */

DROP TABLE IF EXISTS `{db_table_prefix}integration_entity`;

CREATE TABLE `{db_table_prefix}integration_entity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_added` datetime NOT NULL,
  `integration` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `integration_entity` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `integration_entity_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `internal_entity` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `internal_entity_id` int(11) DEFAULT NULL,
  `last_sync_date` datetime DEFAULT NULL,
  `internal` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `{db_table_prefix}integration_external_entity` (`integration`,`integration_entity`,`integration_entity_id`),
  KEY `{db_table_prefix}integration_internal_entity` (`integration`,`internal_entity`,`internal_entity_id`),
  KEY `{db_table_prefix}integration_entity_match` (`integration`,`internal_entity`,`integration_entity`),
  KEY `{db_table_prefix}integration_last_sync_date` (`integration`,`last_sync_date`),
  KEY `{db_table_prefix}internal_integration_entity` (`internal_entity_id`,`integration_entity_id`,`internal_entity`,`integration_entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}ip_addresses` */

DROP TABLE IF EXISTS `{db_table_prefix}ip_addresses`;

CREATE TABLE `{db_table_prefix}ip_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `ip_details` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `{db_table_prefix}ip_search` (`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}lead_categories` */

DROP TABLE IF EXISTS `{db_table_prefix}lead_categories`;

CREATE TABLE `{db_table_prefix}lead_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  `manually_removed` tinyint(1) NOT NULL,
  `manually_added` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_49B99E7012469DE2` (`category_id`),
  KEY `IDX_49B99E7055458D` (`lead_id`),
  CONSTRAINT `FK_49B99E7012469DE2` FOREIGN KEY (`category_id`) REFERENCES `{db_table_prefix}categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_49B99E7055458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}lead_companies_change_log` */

DROP TABLE IF EXISTS `{db_table_prefix}lead_companies_change_log`;

CREATE TABLE `{db_table_prefix}lead_companies_change_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lead_id` int(11) NOT NULL,
  `type` tinytext COLLATE utf8_unicode_ci NOT NULL,
  `event_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `action_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `company_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_25F5952255458D` (`lead_id`),
  KEY `{db_table_prefix}company_date_added` (`date_added`),
  CONSTRAINT `FK_25F5952255458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}lead_devices` */

DROP TABLE IF EXISTS `{db_table_prefix}lead_devices`;

CREATE TABLE `{db_table_prefix}lead_devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lead_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  `client_info` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `device` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `device_os_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `device_os_shortname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `device_os_version` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `device_os_platform` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `device_brand` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `device_model` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `device_fingerprint` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F5A6B0E155458D` (`lead_id`),
  KEY `{db_table_prefix}date_added_search` (`date_added`),
  KEY `{db_table_prefix}device_search` (`device`),
  KEY `{db_table_prefix}device_os_name_search` (`device_os_name`),
  KEY `{db_table_prefix}device_os_shortname_search` (`device_os_shortname`),
  KEY `{db_table_prefix}device_os_version_search` (`device_os_version`),
  KEY `{db_table_prefix}device_os_platform_search` (`device_os_platform`),
  KEY `{db_table_prefix}device_brand_search` (`device_brand`),
  KEY `{db_table_prefix}device_model_search` (`device_model`),
  KEY `{db_table_prefix}device_fingerprint_search` (`device_fingerprint`),
  CONSTRAINT `FK_F5A6B0E155458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}lead_donotcontact` */

DROP TABLE IF EXISTS `{db_table_prefix}lead_donotcontact`;

CREATE TABLE `{db_table_prefix}lead_donotcontact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lead_id` int(11) DEFAULT NULL,
  `date_added` datetime NOT NULL,
  `reason` smallint(6) NOT NULL,
  `channel` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `channel_id` int(11) DEFAULT NULL,
  `comments` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_2C5E9E8955458D` (`lead_id`),
  KEY `{db_table_prefix}dnc_reason_search` (`reason`),
  CONSTRAINT `FK_2C5E9E8955458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}lead_event_log` */

DROP TABLE IF EXISTS `{db_table_prefix}lead_event_log`;

CREATE TABLE `{db_table_prefix}lead_event_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lead_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bundle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `object` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `action` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `object_id` int(11) DEFAULT NULL,
  `date_added` datetime NOT NULL,
  `properties` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`),
  KEY `{db_table_prefix}lead_id_index` (`lead_id`),
  KEY `{db_table_prefix}lead_object_index` (`object`,`object_id`),
  KEY `{db_table_prefix}lead_timeline_index` (`bundle`,`object`,`action`,`object_id`),
  KEY `{db_table_prefix}lead_date_added_index` (`date_added`),
  CONSTRAINT `FK_83E369155458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}lead_fields` */

DROP TABLE IF EXISTS `{db_table_prefix}lead_fields`;

CREATE TABLE `{db_table_prefix}lead_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `alias` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `field_group` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `default_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_required` tinyint(1) NOT NULL,
  `is_fixed` tinyint(1) NOT NULL,
  `is_visible` tinyint(1) NOT NULL,
  `is_short_visible` tinyint(1) NOT NULL,
  `is_listable` tinyint(1) NOT NULL,
  `is_publicly_updatable` tinyint(1) NOT NULL,
  `is_unique_identifer` tinyint(1) DEFAULT NULL,
  `field_order` int(11) DEFAULT NULL,
  `object` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `properties` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `{db_table_prefix}search_by_object` (`object`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}lead_frequencyrules` */

DROP TABLE IF EXISTS `{db_table_prefix}lead_frequencyrules`;

CREATE TABLE `{db_table_prefix}lead_frequencyrules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lead_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  `frequency_number` smallint(6) DEFAULT NULL,
  `frequency_time` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `preferred_channel` tinyint(1) NOT NULL,
  `pause_from_date` datetime DEFAULT NULL,
  `pause_to_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3FC222A355458D` (`lead_id`),
  KEY `{db_table_prefix}channel_frequency` (`channel`),
  CONSTRAINT `FK_3FC222A355458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}lead_ips_xref` */

DROP TABLE IF EXISTS `{db_table_prefix}lead_ips_xref`;

CREATE TABLE `{db_table_prefix}lead_ips_xref` (
  `lead_id` int(11) NOT NULL,
  `ip_id` int(11) NOT NULL,
  PRIMARY KEY (`lead_id`,`ip_id`),
  KEY `IDX_F38DF52F55458D` (`lead_id`),
  KEY `IDX_F38DF52FA03F5E9F` (`ip_id`),
  CONSTRAINT `FK_F38DF52F55458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_F38DF52FA03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `{db_table_prefix}ip_addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}lead_lists` */

DROP TABLE IF EXISTS `{db_table_prefix}lead_lists`;

CREATE TABLE `{db_table_prefix}lead_lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `alias` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `filters` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `is_global` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}lead_lists_leads` */

DROP TABLE IF EXISTS `{db_table_prefix}lead_lists_leads`;

CREATE TABLE `{db_table_prefix}lead_lists_leads` (
  `leadlist_id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  `manually_removed` tinyint(1) NOT NULL,
  `manually_added` tinyint(1) NOT NULL,
  PRIMARY KEY (`leadlist_id`,`lead_id`),
  KEY `IDX_1F7AEA86B9FC8874` (`leadlist_id`),
  KEY `IDX_1F7AEA8655458D` (`lead_id`),
  CONSTRAINT `FK_1F7AEA8655458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_1F7AEA86B9FC8874` FOREIGN KEY (`leadlist_id`) REFERENCES `{db_table_prefix}lead_lists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}lead_notes` */

DROP TABLE IF EXISTS `{db_table_prefix}lead_notes`;

CREATE TABLE `{db_table_prefix}lead_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lead_id` int(11) NOT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `text` longtext COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3A70662555458D` (`lead_id`),
  CONSTRAINT `FK_3A70662555458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}lead_points_change_log` */

DROP TABLE IF EXISTS `{db_table_prefix}lead_points_change_log`;

CREATE TABLE `{db_table_prefix}lead_points_change_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lead_id` int(11) NOT NULL,
  `ip_id` int(11) NOT NULL,
  `type` tinytext COLLATE utf8_unicode_ci NOT NULL,
  `event_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `action_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `delta` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D720507D55458D` (`lead_id`),
  KEY `IDX_D720507DA03F5E9F` (`ip_id`),
  KEY `{db_table_prefix}point_date_added` (`date_added`),
  CONSTRAINT `FK_D720507D55458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_D720507DA03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `{db_table_prefix}ip_addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}lead_stages_change_log` */

DROP TABLE IF EXISTS `{db_table_prefix}lead_stages_change_log`;

CREATE TABLE `{db_table_prefix}lead_stages_change_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lead_id` int(11) NOT NULL,
  `stage_id` int(11) DEFAULT NULL,
  `event_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `action_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3008524255458D` (`lead_id`),
  KEY `IDX_300852422298D193` (`stage_id`),
  CONSTRAINT `FK_300852422298D193` FOREIGN KEY (`stage_id`) REFERENCES `{db_table_prefix}stages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_3008524255458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}lead_tags` */

DROP TABLE IF EXISTS `{db_table_prefix}lead_tags`;

CREATE TABLE `{db_table_prefix}lead_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `{db_table_prefix}lead_tag_search` (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}lead_tags_xref` */

DROP TABLE IF EXISTS `{db_table_prefix}lead_tags_xref`;

CREATE TABLE `{db_table_prefix}lead_tags_xref` (
  `lead_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`lead_id`,`tag_id`),
  KEY `IDX_FD88870955458D` (`lead_id`),
  KEY `IDX_FD888709BAD26311` (`tag_id`),
  CONSTRAINT `FK_FD88870955458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_FD888709BAD26311` FOREIGN KEY (`tag_id`) REFERENCES `{db_table_prefix}lead_tags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}lead_utmtags` */

DROP TABLE IF EXISTS `{db_table_prefix}lead_utmtags`;

CREATE TABLE `{db_table_prefix}lead_utmtags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lead_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  `query` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `referer` longtext COLLATE utf8_unicode_ci,
  `remote_host` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_agent` longtext COLLATE utf8_unicode_ci,
  `utm_campaign` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `utm_content` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `utm_medium` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `utm_source` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `utm_term` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7874699855458D` (`lead_id`),
  CONSTRAINT `FK_7874699855458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}leads` */

DROP TABLE IF EXISTS `{db_table_prefix}leads`;

CREATE TABLE `{db_table_prefix}leads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `stage_id` int(11) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `points` int(11) NOT NULL,
  `last_active` datetime DEFAULT NULL,
  `internal` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `social_cache` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `date_identified` datetime DEFAULT NULL,
  `preferred_profile_image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `firstname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zipcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timezone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fax` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `preferred_locale` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attribution_date` datetime DEFAULT NULL COMMENT '(DC2Type:datetime)',
  `attribution` double DEFAULT NULL,
  `website` longtext COLLATE utf8_unicode_ci,
  `facebook` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `foursquare` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `googleplus` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `instagram` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `linkedin` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `skype` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `twitter` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_8614ED957E3C61F9` (`owner_id`),
  KEY `IDX_8614ED952298D193` (`stage_id`),
  KEY `{db_table_prefix}lead_date_added` (`date_added`),
  KEY `{db_table_prefix}title_search` (`title`),
  KEY `{db_table_prefix}firstname_search` (`firstname`),
  KEY `{db_table_prefix}lastname_search` (`lastname`),
  KEY `{db_table_prefix}company_search` (`company`),
  KEY `{db_table_prefix}position_search` (`position`),
  KEY `{db_table_prefix}email_search` (`email`),
  KEY `{db_table_prefix}mobile_search` (`mobile`),
  KEY `{db_table_prefix}phone_search` (`phone`),
  KEY `{db_table_prefix}points_search` (`points`),
  KEY `{db_table_prefix}fax_search` (`fax`),
  KEY `{db_table_prefix}address1_search` (`address1`),
  KEY `{db_table_prefix}address2_search` (`address2`),
  KEY `{db_table_prefix}city_search` (`city`),
  KEY `{db_table_prefix}state_search` (`state`),
  KEY `{db_table_prefix}zipcode_search` (`zipcode`),
  KEY `{db_table_prefix}country_search` (`country`),
  KEY `{db_table_prefix}preferred_locale_search` (`preferred_locale`),
  KEY `{db_table_prefix}attribution_date_search` (`attribution_date`),
  KEY `{db_table_prefix}attribution_search` (`attribution`),
  KEY `{db_table_prefix}facebook_search` (`facebook`),
  KEY `{db_table_prefix}foursquare_search` (`foursquare`),
  KEY `{db_table_prefix}googleplus_search` (`googleplus`),
  KEY `{db_table_prefix}instagram_search` (`instagram`),
  KEY `{db_table_prefix}linkedin_search` (`linkedin`),
  KEY `{db_table_prefix}skype_search` (`skype`),
  KEY `{db_table_prefix}twitter_search` (`twitter`),
  KEY `{db_table_prefix}contact_attribution` (`attribution`,`attribution_date`),
  KEY `{db_table_prefix}date_added_country_index` (`date_added`,`country`),
  CONSTRAINT `FK_8614ED952298D193` FOREIGN KEY (`stage_id`) REFERENCES `{db_table_prefix}stages` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_8614ED957E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `{db_table_prefix}users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}message_channels` */

DROP TABLE IF EXISTS `{db_table_prefix}message_channels`;

CREATE TABLE `{db_table_prefix}message_channels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_id` int(11) NOT NULL,
  `channel` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `channel_id` int(11) DEFAULT NULL,
  `properties` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `is_enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `{db_table_prefix}channel_index` (`message_id`,`channel`),
  KEY `IDX_10BCB05D537A1329` (`message_id`),
  KEY `{db_table_prefix}channel_entity_index` (`channel`,`channel_id`),
  KEY `{db_table_prefix}channel_enabled_index` (`channel`,`is_enabled`),
  CONSTRAINT `FK_10BCB05D537A1329` FOREIGN KEY (`message_id`) REFERENCES `{db_table_prefix}messages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}message_queue` */

DROP TABLE IF EXISTS `{db_table_prefix}message_queue`;

CREATE TABLE `{db_table_prefix}message_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) DEFAULT NULL,
  `lead_id` int(11) NOT NULL,
  `channel` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `channel_id` int(11) NOT NULL,
  `priority` smallint(6) NOT NULL,
  `max_attempts` smallint(6) NOT NULL,
  `attempts` smallint(6) NOT NULL,
  `success` tinyint(1) NOT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_published` datetime DEFAULT NULL,
  `scheduled_date` datetime DEFAULT NULL,
  `last_attempt` datetime DEFAULT NULL,
  `date_sent` datetime DEFAULT NULL,
  `options` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_ED3B0BC171F7E88B` (`event_id`),
  KEY `IDX_ED3B0BC155458D` (`lead_id`),
  KEY `{db_table_prefix}message_status_search` (`status`),
  KEY `{db_table_prefix}message_date_sent` (`date_sent`),
  KEY `{db_table_prefix}message_scheduled_date` (`scheduled_date`),
  KEY `{db_table_prefix}message_priority` (`priority`),
  KEY `{db_table_prefix}message_success` (`success`),
  KEY `{db_table_prefix}message_channel_search` (`channel`,`channel_id`),
  CONSTRAINT `FK_ED3B0BC155458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_ED3B0BC171F7E88B` FOREIGN KEY (`event_id`) REFERENCES `{db_table_prefix}campaign_events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}messages` */

DROP TABLE IF EXISTS `{db_table_prefix}messages`;

CREATE TABLE `{db_table_prefix}messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C3E9EF1A12469DE2` (`category_id`),
  KEY `{db_table_prefix}date_message_added` (`date_added`),
  CONSTRAINT `FK_C3E9EF1A12469DE2` FOREIGN KEY (`category_id`) REFERENCES `{db_table_prefix}categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}monitor_post_count` */

DROP TABLE IF EXISTS `{db_table_prefix}monitor_post_count`;

CREATE TABLE `{db_table_prefix}monitor_post_count` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `monitor_id` int(11) DEFAULT NULL,
  `post_date` date NOT NULL,
  `post_count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_1493F5024CE1C902` (`monitor_id`),
  CONSTRAINT `FK_1493F5024CE1C902` FOREIGN KEY (`monitor_id`) REFERENCES `{db_table_prefix}monitoring` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}monitoring` */

DROP TABLE IF EXISTS `{db_table_prefix}monitoring`;

CREATE TABLE `{db_table_prefix}monitoring` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `lists` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `network_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `revision` int(11) NOT NULL,
  `stats` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `properties` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E7C39A7B12469DE2` (`category_id`),
  CONSTRAINT `FK_E7C39A7B12469DE2` FOREIGN KEY (`category_id`) REFERENCES `{db_table_prefix}categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}monitoring_leads` */

DROP TABLE IF EXISTS `{db_table_prefix}monitoring_leads`;

CREATE TABLE `{db_table_prefix}monitoring_leads` (
  `monitor_id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`monitor_id`,`lead_id`),
  KEY `IDX_AFAEECB04CE1C902` (`monitor_id`),
  KEY `IDX_AFAEECB055458D` (`lead_id`),
  CONSTRAINT `FK_AFAEECB04CE1C902` FOREIGN KEY (`monitor_id`) REFERENCES `{db_table_prefix}monitoring` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_AFAEECB055458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}notifications` */

DROP TABLE IF EXISTS `{db_table_prefix}notifications`;

CREATE TABLE `{db_table_prefix}notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `type` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `header` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message` longtext COLLATE utf8_unicode_ci NOT NULL,
  `date_added` datetime NOT NULL,
  `icon_class` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D603B9AA76ED395` (`user_id`),
  KEY `{db_table_prefix}notification_read_status` (`is_read`),
  KEY `{db_table_prefix}notification_type` (`type`),
  KEY `{db_table_prefix}notification_user_read_status` (`is_read`,`user_id`),
  CONSTRAINT `FK_D603B9AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `{db_table_prefix}users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}oauth1_access_tokens` */

DROP TABLE IF EXISTS `{db_table_prefix}oauth1_access_tokens`;

CREATE TABLE `{db_table_prefix}oauth1_access_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consumer_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `secret` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expires_at` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_36A0444037FDBD6D` (`consumer_id`),
  KEY `IDX_36A04440A76ED395` (`user_id`),
  KEY `{db_table_prefix}oauth1_access_token_search` (`token`),
  CONSTRAINT `FK_36A0444037FDBD6D` FOREIGN KEY (`consumer_id`) REFERENCES `{db_table_prefix}oauth1_consumers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_36A04440A76ED395` FOREIGN KEY (`user_id`) REFERENCES `{db_table_prefix}users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}oauth1_consumers` */

DROP TABLE IF EXISTS `{db_table_prefix}oauth1_consumers`;

CREATE TABLE `{db_table_prefix}oauth1_consumers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `consumer_key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `consumer_secret` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `callback` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `{db_table_prefix}consumer_search` (`consumer_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}oauth1_nonces` */

DROP TABLE IF EXISTS `{db_table_prefix}oauth1_nonces`;

CREATE TABLE `{db_table_prefix}oauth1_nonces` (
  `nonce` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`nonce`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}oauth1_request_tokens` */

DROP TABLE IF EXISTS `{db_table_prefix}oauth1_request_tokens`;

CREATE TABLE `{db_table_prefix}oauth1_request_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consumer_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `secret` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `verifier` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_55661D8237FDBD6D` (`consumer_id`),
  KEY `IDX_55661D82A76ED395` (`user_id`),
  KEY `{db_table_prefix}oauth1_request_token_search` (`token`),
  CONSTRAINT `FK_55661D8237FDBD6D` FOREIGN KEY (`consumer_id`) REFERENCES `{db_table_prefix}oauth1_consumers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_55661D82A76ED395` FOREIGN KEY (`user_id`) REFERENCES `{db_table_prefix}users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}oauth2_accesstokens` */

DROP TABLE IF EXISTS `{db_table_prefix}oauth2_accesstokens`;

CREATE TABLE `{db_table_prefix}oauth2_accesstokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expires_at` bigint(20) DEFAULT NULL,
  `scope` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_AF50BF0D5F37A13B` (`token`),
  KEY `IDX_AF50BF0D19EB6921` (`client_id`),
  KEY `IDX_AF50BF0DA76ED395` (`user_id`),
  KEY `{db_table_prefix}oauth2_access_token_search` (`token`),
  CONSTRAINT `FK_AF50BF0D19EB6921` FOREIGN KEY (`client_id`) REFERENCES `{db_table_prefix}oauth2_clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_AF50BF0DA76ED395` FOREIGN KEY (`user_id`) REFERENCES `{db_table_prefix}users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}oauth2_authcodes` */

DROP TABLE IF EXISTS `{db_table_prefix}oauth2_authcodes`;

CREATE TABLE `{db_table_prefix}oauth2_authcodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expires_at` bigint(20) DEFAULT NULL,
  `scope` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `redirect_uri` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_383A12815F37A13B` (`token`),
  KEY `IDX_383A128119EB6921` (`client_id`),
  KEY `IDX_383A1281A76ED395` (`user_id`),
  CONSTRAINT `FK_383A128119EB6921` FOREIGN KEY (`client_id`) REFERENCES `{db_table_prefix}oauth2_clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_383A1281A76ED395` FOREIGN KEY (`user_id`) REFERENCES `{db_table_prefix}users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}oauth2_clients` */

DROP TABLE IF EXISTS `{db_table_prefix}oauth2_clients`;

CREATE TABLE `{db_table_prefix}oauth2_clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `random_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `secret` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `redirect_uris` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `allowed_grant_types` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `{db_table_prefix}client_id_search` (`random_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}oauth2_refreshtokens` */

DROP TABLE IF EXISTS `{db_table_prefix}oauth2_refreshtokens`;

CREATE TABLE `{db_table_prefix}oauth2_refreshtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expires_at` bigint(20) DEFAULT NULL,
  `scope` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_C716D7395F37A13B` (`token`),
  KEY `IDX_C716D73919EB6921` (`client_id`),
  KEY `IDX_C716D739A76ED395` (`user_id`),
  KEY `{db_table_prefix}oauth2_refresh_token_search` (`token`),
  CONSTRAINT `FK_C716D73919EB6921` FOREIGN KEY (`client_id`) REFERENCES `{db_table_prefix}oauth2_clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_C716D739A76ED395` FOREIGN KEY (`user_id`) REFERENCES `{db_table_prefix}users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}oauth2_user_client_xref` */

DROP TABLE IF EXISTS `{db_table_prefix}oauth2_user_client_xref`;

CREATE TABLE `{db_table_prefix}oauth2_user_client_xref` (
  `client_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`client_id`,`user_id`),
  KEY `IDX_A6C67B7519EB6921` (`client_id`),
  KEY `IDX_A6C67B75A76ED395` (`user_id`),
  CONSTRAINT `FK_A6C67B7519EB6921` FOREIGN KEY (`client_id`) REFERENCES `{db_table_prefix}oauth2_clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_A6C67B75A76ED395` FOREIGN KEY (`user_id`) REFERENCES `{db_table_prefix}users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}page_hits` */

DROP TABLE IF EXISTS `{db_table_prefix}page_hits`;

CREATE TABLE `{db_table_prefix}page_hits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` int(11) DEFAULT NULL,
  `redirect_id` int(11) DEFAULT NULL,
  `email_id` int(11) DEFAULT NULL,
  `lead_id` int(11) DEFAULT NULL,
  `ip_id` int(11) NOT NULL,
  `device_id` int(11) DEFAULT NULL,
  `date_hit` datetime NOT NULL,
  `date_left` datetime DEFAULT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `region` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isp` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `organization` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` int(11) NOT NULL,
  `referer` longtext COLLATE utf8_unicode_ci,
  `url` longtext COLLATE utf8_unicode_ci,
  `url_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_agent` longtext COLLATE utf8_unicode_ci,
  `remote_host` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `page_language` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `browser_languages` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `tracking_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `source` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `query` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_795D540BC4663E4` (`page_id`),
  KEY `IDX_795D540BB42D874D` (`redirect_id`),
  KEY `IDX_795D540BA832C1C9` (`email_id`),
  KEY `IDX_795D540B55458D` (`lead_id`),
  KEY `IDX_795D540BA03F5E9F` (`ip_id`),
  KEY `IDX_795D540B94A4C7D4` (`device_id`),
  KEY `{db_table_prefix}page_hit_tracking_search` (`tracking_id`),
  KEY `{db_table_prefix}page_hit_code_search` (`code`),
  KEY `{db_table_prefix}page_hit_source_search` (`source`,`source_id`),
  KEY `{db_table_prefix}page_date_hit` (`date_hit`),
  KEY `{db_table_prefix}date_hit_left_index` (`date_hit`,`date_left`),
  CONSTRAINT `FK_795D540B55458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_795D540B94A4C7D4` FOREIGN KEY (`device_id`) REFERENCES `{db_table_prefix}lead_devices` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_795D540BA03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `{db_table_prefix}ip_addresses` (`id`),
  CONSTRAINT `FK_795D540BA832C1C9` FOREIGN KEY (`email_id`) REFERENCES `{db_table_prefix}emails` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_795D540BB42D874D` FOREIGN KEY (`redirect_id`) REFERENCES `{db_table_prefix}page_redirects` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_795D540BC4663E4` FOREIGN KEY (`page_id`) REFERENCES `{db_table_prefix}pages` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}page_redirects` */

DROP TABLE IF EXISTS `{db_table_prefix}page_redirects`;

CREATE TABLE `{db_table_prefix}page_redirects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `redirect_id` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `url` longtext COLLATE utf8_unicode_ci NOT NULL,
  `hits` int(11) NOT NULL,
  `unique_hits` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}pages` */

DROP TABLE IF EXISTS `{db_table_prefix}pages`;

CREATE TABLE `{db_table_prefix}pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `translation_parent_id` int(11) DEFAULT NULL,
  `variant_parent_id` int(11) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `alias` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `template` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `custom_html` longtext COLLATE utf8_unicode_ci,
  `content` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `hits` int(11) NOT NULL,
  `unique_hits` int(11) NOT NULL,
  `variant_hits` int(11) NOT NULL,
  `revision` int(11) NOT NULL,
  `meta_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `redirect_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `redirect_url` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_preference_center` tinyint(1) DEFAULT NULL,
  `lang` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `variant_settings` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `variant_start_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B1F04DB212469DE2` (`category_id`),
  KEY `IDX_B1F04DB29091A2FB` (`translation_parent_id`),
  KEY `IDX_B1F04DB291861123` (`variant_parent_id`),
  KEY `{db_table_prefix}page_alias_search` (`alias`),
  CONSTRAINT `FK_B1F04DB212469DE2` FOREIGN KEY (`category_id`) REFERENCES `{db_table_prefix}categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_B1F04DB29091A2FB` FOREIGN KEY (`translation_parent_id`) REFERENCES `{db_table_prefix}pages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_B1F04DB291861123` FOREIGN KEY (`variant_parent_id`) REFERENCES `{db_table_prefix}pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}permissions` */

DROP TABLE IF EXISTS `{db_table_prefix}permissions`;

CREATE TABLE `{db_table_prefix}permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `bundle` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `bitwise` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `{db_table_prefix}unique_perm` (`bundle`,`name`,`role_id`),
  KEY `IDX_FFBDC59FD60322AC` (`role_id`),
  CONSTRAINT `FK_FFBDC59FD60322AC` FOREIGN KEY (`role_id`) REFERENCES `{db_table_prefix}roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}plugin_citrix_events` */

DROP TABLE IF EXISTS `{db_table_prefix}plugin_citrix_events`;

CREATE TABLE `{db_table_prefix}plugin_citrix_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lead_id` int(11) NOT NULL,
  `product` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `event_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `event_desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `event_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F8EDFF3255458D` (`lead_id`),
  KEY `{db_table_prefix}citrix_event_email` (`product`,`email`),
  KEY `{db_table_prefix}citrix_event_name` (`product`,`event_name`,`event_type`),
  KEY `{db_table_prefix}citrix_event_type` (`product`,`event_type`,`event_date`),
  KEY `{db_table_prefix}citrix_event_product` (`product`,`email`,`event_type`),
  KEY `{db_table_prefix}citrix_event_product_name` (`product`,`email`,`event_type`,`event_name`),
  KEY `{db_table_prefix}citrix_event_product_name_lead` (`product`,`event_type`,`event_name`,`lead_id`),
  KEY `{db_table_prefix}citrix_event_product_type_lead` (`product`,`event_type`,`lead_id`),
  KEY `{db_table_prefix}citrix_event_date` (`event_date`),
  CONSTRAINT `FK_F8EDFF3255458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}plugin_crm_pipedrive_owners` */

DROP TABLE IF EXISTS `{db_table_prefix}plugin_crm_pipedrive_owners`;

CREATE TABLE `{db_table_prefix}plugin_crm_pipedrive_owners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `{db_table_prefix}email` (`email`),
  KEY `{db_table_prefix}owner_id` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}plugin_integration_settings` */

DROP TABLE IF EXISTS `{db_table_prefix}plugin_integration_settings`;

CREATE TABLE `{db_table_prefix}plugin_integration_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plugin_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `is_published` tinyint(1) NOT NULL,
  `supported_features` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `api_keys` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `feature_settings` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_8F4409D2EC942BCF` (`plugin_id`),
  CONSTRAINT `FK_8F4409D2EC942BCF` FOREIGN KEY (`plugin_id`) REFERENCES `{db_table_prefix}plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}plugins` */

DROP TABLE IF EXISTS `{db_table_prefix}plugins`;

CREATE TABLE `{db_table_prefix}plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `is_missing` tinyint(1) NOT NULL,
  `bundle` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `author` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `{db_table_prefix}unique_bundle` (`bundle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}point_lead_action_log` */

DROP TABLE IF EXISTS `{db_table_prefix}point_lead_action_log`;

CREATE TABLE `{db_table_prefix}point_lead_action_log` (
  `point_id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `ip_id` int(11) DEFAULT NULL,
  `date_fired` datetime NOT NULL,
  PRIMARY KEY (`point_id`,`lead_id`),
  KEY `IDX_B86C913EC028CEA2` (`point_id`),
  KEY `IDX_B86C913E55458D` (`lead_id`),
  KEY `IDX_B86C913EA03F5E9F` (`ip_id`),
  CONSTRAINT `FK_B86C913E55458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_B86C913EA03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `{db_table_prefix}ip_addresses` (`id`),
  CONSTRAINT `FK_B86C913EC028CEA2` FOREIGN KEY (`point_id`) REFERENCES `{db_table_prefix}points` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}point_lead_event_log` */

DROP TABLE IF EXISTS `{db_table_prefix}point_lead_event_log`;

CREATE TABLE `{db_table_prefix}point_lead_event_log` (
  `event_id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `ip_id` int(11) DEFAULT NULL,
  `date_fired` datetime NOT NULL,
  PRIMARY KEY (`event_id`,`lead_id`),
  KEY `IDX_3739319871F7E88B` (`event_id`),
  KEY `IDX_3739319855458D` (`lead_id`),
  KEY `IDX_37393198A03F5E9F` (`ip_id`),
  CONSTRAINT `FK_3739319855458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_3739319871F7E88B` FOREIGN KEY (`event_id`) REFERENCES `{db_table_prefix}point_trigger_events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_37393198A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `{db_table_prefix}ip_addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}point_trigger_events` */

DROP TABLE IF EXISTS `{db_table_prefix}point_trigger_events`;

CREATE TABLE `{db_table_prefix}point_trigger_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trigger_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `action_order` int(11) NOT NULL,
  `properties` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_F8CCE57A5FDDDCD6` (`trigger_id`),
  KEY `{db_table_prefix}trigger_type_search` (`type`),
  CONSTRAINT `FK_F8CCE57A5FDDDCD6` FOREIGN KEY (`trigger_id`) REFERENCES `{db_table_prefix}point_triggers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}point_triggers` */

DROP TABLE IF EXISTS `{db_table_prefix}point_triggers`;

CREATE TABLE `{db_table_prefix}point_triggers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `points` int(11) NOT NULL,
  `color` varchar(7) COLLATE utf8_unicode_ci NOT NULL,
  `trigger_existing_leads` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_93C64A9012469DE2` (`category_id`),
  CONSTRAINT `FK_93C64A9012469DE2` FOREIGN KEY (`category_id`) REFERENCES `{db_table_prefix}categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}points` */

DROP TABLE IF EXISTS `{db_table_prefix}points`;

CREATE TABLE `{db_table_prefix}points` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `delta` int(11) NOT NULL,
  `properties` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_222B5D9212469DE2` (`category_id`),
  KEY `{db_table_prefix}point_type_search` (`type`),
  CONSTRAINT `FK_222B5D9212469DE2` FOREIGN KEY (`category_id`) REFERENCES `{db_table_prefix}categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}push_ids` */

DROP TABLE IF EXISTS `{db_table_prefix}push_ids`;

CREATE TABLE `{db_table_prefix}push_ids` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lead_id` int(11) DEFAULT NULL,
  `push_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `mobile` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_57C8626455458D` (`lead_id`),
  CONSTRAINT `FK_57C8626455458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}push_notification_list_xref` */

DROP TABLE IF EXISTS `{db_table_prefix}push_notification_list_xref`;

CREATE TABLE `{db_table_prefix}push_notification_list_xref` (
  `notification_id` int(11) NOT NULL,
  `leadlist_id` int(11) NOT NULL,
  PRIMARY KEY (`notification_id`,`leadlist_id`),
  KEY `IDX_5C673CDDEF1A9D84` (`notification_id`),
  KEY `IDX_5C673CDDB9FC8874` (`leadlist_id`),
  CONSTRAINT `FK_5C673CDDB9FC8874` FOREIGN KEY (`leadlist_id`) REFERENCES `{db_table_prefix}lead_lists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_5C673CDDEF1A9D84` FOREIGN KEY (`notification_id`) REFERENCES `{db_table_prefix}push_notifications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}push_notification_stats` */

DROP TABLE IF EXISTS `{db_table_prefix}push_notification_stats`;

CREATE TABLE `{db_table_prefix}push_notification_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_id` int(11) DEFAULT NULL,
  `lead_id` int(11) DEFAULT NULL,
  `list_id` int(11) DEFAULT NULL,
  `ip_id` int(11) DEFAULT NULL,
  `date_sent` datetime NOT NULL,
  `date_read` datetime DEFAULT NULL,
  `is_clicked` tinyint(1) NOT NULL,
  `date_clicked` datetime DEFAULT NULL,
  `tracking_hash` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `retry_count` int(11) DEFAULT NULL,
  `source` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `tokens` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `click_count` int(11) DEFAULT NULL,
  `last_clicked` datetime DEFAULT NULL,
  `click_details` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_62465638EF1A9D84` (`notification_id`),
  KEY `IDX_6246563855458D` (`lead_id`),
  KEY `IDX_624656383DAE168B` (`list_id`),
  KEY `IDX_62465638A03F5E9F` (`ip_id`),
  KEY `{db_table_prefix}stat_notification_search` (`notification_id`,`lead_id`),
  KEY `{db_table_prefix}stat_notification_clicked_search` (`is_clicked`),
  KEY `{db_table_prefix}stat_notification_hash_search` (`tracking_hash`),
  KEY `{db_table_prefix}stat_notification_source_search` (`source`,`source_id`),
  CONSTRAINT `FK_624656383DAE168B` FOREIGN KEY (`list_id`) REFERENCES `{db_table_prefix}lead_lists` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_6246563855458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_62465638A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `{db_table_prefix}ip_addresses` (`id`),
  CONSTRAINT `FK_62465638EF1A9D84` FOREIGN KEY (`notification_id`) REFERENCES `{db_table_prefix}push_notifications` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}push_notifications` */

DROP TABLE IF EXISTS `{db_table_prefix}push_notifications`;

CREATE TABLE `{db_table_prefix}push_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `lang` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url` longtext COLLATE utf8_unicode_ci,
  `heading` longtext COLLATE utf8_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8_unicode_ci NOT NULL,
  `button` longtext COLLATE utf8_unicode_ci,
  `utm_tags` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `notification_type` longtext COLLATE utf8_unicode_ci,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `read_count` int(11) NOT NULL,
  `sent_count` int(11) NOT NULL,
  `mobile` tinyint(1) NOT NULL,
  `mobileSettings` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_ACA4AB8712469DE2` (`category_id`),
  CONSTRAINT `FK_ACA4AB8712469DE2` FOREIGN KEY (`category_id`) REFERENCES `{db_table_prefix}categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}reports` */

DROP TABLE IF EXISTS `{db_table_prefix}reports`;

CREATE TABLE `{db_table_prefix}reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `system` tinyint(1) NOT NULL,
  `source` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `columns` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `filters` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `table_order` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `graphs` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `group_by` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `aggregators` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `settings` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  `is_scheduled` tinyint(1) NOT NULL,
  `schedule_unit` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `to_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `schedule_day` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `schedule_month_frequency` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}reports_schedulers` */

DROP TABLE IF EXISTS `{db_table_prefix}reports_schedulers`;

CREATE TABLE `{db_table_prefix}reports_schedulers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) NOT NULL,
  `schedule_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_307373704BD2A4C0` (`report_id`),
  CONSTRAINT `FK_307373704BD2A4C0` FOREIGN KEY (`report_id`) REFERENCES `{db_table_prefix}reports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}roles` */

DROP TABLE IF EXISTS `{db_table_prefix}roles`;

CREATE TABLE `{db_table_prefix}roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `is_admin` tinyint(1) NOT NULL,
  `readable_permissions` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}saml_id_entry` */

DROP TABLE IF EXISTS `{db_table_prefix}saml_id_entry`;

CREATE TABLE `{db_table_prefix}saml_id_entry` (
  `id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `entity_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expiryTimestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`,`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}sms_message_list_xref` */

DROP TABLE IF EXISTS `{db_table_prefix}sms_message_list_xref`;

CREATE TABLE `{db_table_prefix}sms_message_list_xref` (
  `sms_id` int(11) NOT NULL,
  `leadlist_id` int(11) NOT NULL,
  PRIMARY KEY (`sms_id`,`leadlist_id`),
  KEY `IDX_65A72746BD5C7E60` (`sms_id`),
  KEY `IDX_65A72746B9FC8874` (`leadlist_id`),
  CONSTRAINT `FK_65A72746B9FC8874` FOREIGN KEY (`leadlist_id`) REFERENCES `{db_table_prefix}lead_lists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_65A72746BD5C7E60` FOREIGN KEY (`sms_id`) REFERENCES `{db_table_prefix}sms_messages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}sms_message_stats` */

DROP TABLE IF EXISTS `{db_table_prefix}sms_message_stats`;

CREATE TABLE `{db_table_prefix}sms_message_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sms_id` int(11) DEFAULT NULL,
  `lead_id` int(11) DEFAULT NULL,
  `list_id` int(11) DEFAULT NULL,
  `ip_id` int(11) DEFAULT NULL,
  `date_sent` datetime NOT NULL,
  `tracking_hash` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `tokens` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_52632F7DBD5C7E60` (`sms_id`),
  KEY `IDX_52632F7D55458D` (`lead_id`),
  KEY `IDX_52632F7D3DAE168B` (`list_id`),
  KEY `IDX_52632F7DA03F5E9F` (`ip_id`),
  KEY `{db_table_prefix}stat_sms_search` (`sms_id`,`lead_id`),
  KEY `{db_table_prefix}stat_sms_hash_search` (`tracking_hash`),
  KEY `{db_table_prefix}stat_sms_source_search` (`source`,`source_id`),
  CONSTRAINT `FK_52632F7D3DAE168B` FOREIGN KEY (`list_id`) REFERENCES `{db_table_prefix}lead_lists` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_52632F7D55458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_52632F7DA03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `{db_table_prefix}ip_addresses` (`id`),
  CONSTRAINT `FK_52632F7DBD5C7E60` FOREIGN KEY (`sms_id`) REFERENCES `{db_table_prefix}sms_messages` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}sms_messages` */

DROP TABLE IF EXISTS `{db_table_prefix}sms_messages`;

CREATE TABLE `{db_table_prefix}sms_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `lang` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8_unicode_ci NOT NULL,
  `sms_type` longtext COLLATE utf8_unicode_ci,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `sent_count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_9B9D8212469DE2` (`category_id`),
  CONSTRAINT `FK_9B9D8212469DE2` FOREIGN KEY (`category_id`) REFERENCES `{db_table_prefix}categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}stage_lead_action_log` */

DROP TABLE IF EXISTS `{db_table_prefix}stage_lead_action_log`;

CREATE TABLE `{db_table_prefix}stage_lead_action_log` (
  `stage_id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `ip_id` int(11) DEFAULT NULL,
  `date_fired` datetime NOT NULL,
  PRIMARY KEY (`stage_id`,`lead_id`),
  KEY `IDX_709374D62298D193` (`stage_id`),
  KEY `IDX_709374D655458D` (`lead_id`),
  KEY `IDX_709374D6A03F5E9F` (`ip_id`),
  CONSTRAINT `FK_709374D62298D193` FOREIGN KEY (`stage_id`) REFERENCES `{db_table_prefix}stages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_709374D655458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_709374D6A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `{db_table_prefix}ip_addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}stages` */

DROP TABLE IF EXISTS `{db_table_prefix}stages`;

CREATE TABLE `{db_table_prefix}stages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `weight` int(11) NOT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2A33B9DF12469DE2` (`category_id`),
  CONSTRAINT `FK_2A33B9DF12469DE2` FOREIGN KEY (`category_id`) REFERENCES `{db_table_prefix}categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}tweet_stats` */

DROP TABLE IF EXISTS `{db_table_prefix}tweet_stats`;

CREATE TABLE `{db_table_prefix}tweet_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tweet_id` int(11) DEFAULT NULL,
  `lead_id` int(11) DEFAULT NULL,
  `twitter_tweet_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_sent` datetime DEFAULT NULL,
  `is_failed` tinyint(1) DEFAULT NULL,
  `retry_count` int(11) DEFAULT NULL,
  `source` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `favorite_count` int(11) DEFAULT NULL,
  `retweet_count` int(11) DEFAULT NULL,
  `response_details` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`),
  KEY `IDX_19DCB3151041E39B` (`tweet_id`),
  KEY `IDX_19DCB31555458D` (`lead_id`),
  KEY `{db_table_prefix}stat_tweet_search` (`tweet_id`,`lead_id`),
  KEY `{db_table_prefix}stat_tweet_search2` (`lead_id`,`tweet_id`),
  KEY `{db_table_prefix}stat_tweet_failed_search` (`is_failed`),
  KEY `{db_table_prefix}stat_tweet_source_search` (`source`,`source_id`),
  KEY `{db_table_prefix}favorite_count_index` (`favorite_count`),
  KEY `{db_table_prefix}retweet_count_index` (`retweet_count`),
  KEY `{db_table_prefix}tweet_date_sent` (`date_sent`),
  KEY `{db_table_prefix}twitter_tweet_id_index` (`twitter_tweet_id`),
  CONSTRAINT `FK_19DCB3151041E39B` FOREIGN KEY (`tweet_id`) REFERENCES `{db_table_prefix}tweets` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_19DCB31555458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}tweets` */

DROP TABLE IF EXISTS `{db_table_prefix}tweets`;

CREATE TABLE `{db_table_prefix}tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `page_id` int(11) DEFAULT NULL,
  `asset_id` int(11) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `media_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `media_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sent_count` int(11) DEFAULT NULL,
  `favorite_count` int(11) DEFAULT NULL,
  `retweet_count` int(11) DEFAULT NULL,
  `lang` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_AFA9939E12469DE2` (`category_id`),
  KEY `IDX_AFA9939EC4663E4` (`page_id`),
  KEY `IDX_AFA9939E5DA1941` (`asset_id`),
  KEY `{db_table_prefix}tweet_text_index` (`text`),
  KEY `{db_table_prefix}sent_count_index` (`sent_count`),
  KEY `{db_table_prefix}favorite_count_index` (`favorite_count`),
  KEY `{db_table_prefix}retweet_count_index` (`retweet_count`),
  CONSTRAINT `FK_AFA9939E12469DE2` FOREIGN KEY (`category_id`) REFERENCES `{db_table_prefix}categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_AFA9939E5DA1941` FOREIGN KEY (`asset_id`) REFERENCES `{db_table_prefix}assets` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_AFA9939EC4663E4` FOREIGN KEY (`page_id`) REFERENCES `{db_table_prefix}pages` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}users` */

DROP TABLE IF EXISTS `{db_table_prefix}users`;

CREATE TABLE `{db_table_prefix}users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `position` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timezone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `last_active` datetime DEFAULT NULL,
  `online_status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `preferences` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `signature` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_85070D2EF85E0677` (`username`),
  UNIQUE KEY `UNIQ_85070D2EE7927C74` (`email`),
  KEY `IDX_85070D2ED60322AC` (`role_id`),
  CONSTRAINT `FK_85070D2ED60322AC` FOREIGN KEY (`role_id`) REFERENCES `{db_table_prefix}roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}video_hits` */

DROP TABLE IF EXISTS `{db_table_prefix}video_hits`;

CREATE TABLE `{db_table_prefix}video_hits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lead_id` int(11) DEFAULT NULL,
  `ip_id` int(11) NOT NULL,
  `date_hit` datetime NOT NULL,
  `date_left` datetime DEFAULT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `region` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isp` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `organization` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` int(11) NOT NULL,
  `referer` longtext COLLATE utf8_unicode_ci,
  `url` longtext COLLATE utf8_unicode_ci,
  `user_agent` longtext COLLATE utf8_unicode_ci,
  `remote_host` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `guid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `page_language` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `browser_languages` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `channel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel_id` int(11) DEFAULT NULL,
  `time_watched` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `query` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_40943CD155458D` (`lead_id`),
  KEY `IDX_40943CD1A03F5E9F` (`ip_id`),
  KEY `{db_table_prefix}video_date_hit` (`date_hit`),
  KEY `{db_table_prefix}video_channel_search` (`channel`,`channel_id`),
  KEY `{db_table_prefix}video_guid_lead_search` (`guid`,`lead_id`),
  CONSTRAINT `FK_40943CD155458D` FOREIGN KEY (`lead_id`) REFERENCES `{db_table_prefix}leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_40943CD1A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `{db_table_prefix}ip_addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}webhook_events` */

DROP TABLE IF EXISTS `{db_table_prefix}webhook_events`;

CREATE TABLE `{db_table_prefix}webhook_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `webhook_id` int(11) NOT NULL,
  `event_type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_75B9D7885C9BA60B` (`webhook_id`),
  CONSTRAINT `FK_75B9D7885C9BA60B` FOREIGN KEY (`webhook_id`) REFERENCES `{db_table_prefix}webhooks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}webhook_logs` */

DROP TABLE IF EXISTS `{db_table_prefix}webhook_logs`;

CREATE TABLE `{db_table_prefix}webhook_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `webhook_id` int(11) NOT NULL,
  `status_code` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `note` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `runtime` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F8CCF1525C9BA60B` (`webhook_id`),
  CONSTRAINT `FK_F8CCF1525C9BA60B` FOREIGN KEY (`webhook_id`) REFERENCES `{db_table_prefix}webhooks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}webhook_queue` */

DROP TABLE IF EXISTS `{db_table_prefix}webhook_queue`;

CREATE TABLE `{db_table_prefix}webhook_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `webhook_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `payload` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_984D11535C9BA60B` (`webhook_id`),
  KEY `IDX_984D115371F7E88B` (`event_id`),
  CONSTRAINT `FK_984D11535C9BA60B` FOREIGN KEY (`webhook_id`) REFERENCES `{db_table_prefix}webhooks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_984D115371F7E88B` FOREIGN KEY (`event_id`) REFERENCES `{db_table_prefix}webhook_events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}webhooks` */

DROP TABLE IF EXISTS `{db_table_prefix}webhooks`;

CREATE TABLE `{db_table_prefix}webhooks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `webhook_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `events_orderby_dir` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_8167BE5112469DE2` (`category_id`),
  CONSTRAINT `FK_8167BE5112469DE2` FOREIGN KEY (`category_id`) REFERENCES `{db_table_prefix}categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `{db_table_prefix}widgets` */

DROP TABLE IF EXISTS `{db_table_prefix}widgets`;

CREATE TABLE `{db_table_prefix}widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `cache_timeout` int(11) DEFAULT NULL,
  `ordering` int(11) DEFAULT NULL,
  `params` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
