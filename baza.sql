ALTER TABLE users 
ADD `org` varchar(50) COLLATE utf8mb4_polish_ci DEFAULT 'unemployed',
ADD  `org_grade` int(11) DEFAULT 0;

CREATE TABLE `addon_organizations` (
  `org` varchar(50) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `account` varchar(50) DEFAULT NULL,
  `wallet` varchar(50) DEFAULT NULL,
  `money` int(11) DEFAULT 0,
  `btc` int(11) DEFAULT 0,
  `doge` int(11) DEFAULT 0,
  `eth` int(11) DEFAULT 0,
  `exp` int(11) DEFAULT 0,
  `level` int(11) DEFAULT 1,
  `upgrade` int(11) DEFAULT 0,
  `medic` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `organizations_clothes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `owner` varchar(60) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `last_org` (
  `last` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


INSERT INTO `last_org` (`last`) VALUES
    (1);