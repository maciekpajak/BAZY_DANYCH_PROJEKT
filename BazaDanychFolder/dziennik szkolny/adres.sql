-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Wersja serwera:               10.4.12-MariaDB - mariadb.org binary distribution
-- Serwer OS:                    Win32
-- HeidiSQL Wersja:              10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Zrzut struktury tabela dziennik szkolny.adres
CREATE TABLE IF NOT EXISTS `adres` (
  `adres_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `ulice_miejscowosci_id` int(6) unsigned zerofill NOT NULL,
  `nr_domu` varchar(6) COLLATE ucs2_polish_ci NOT NULL,
  `nr_mieszkania` varchar(4) COLLATE ucs2_polish_ci DEFAULT NULL,
  PRIMARY KEY (`adres_ID`),
  UNIQUE KEY `ID` (`adres_ID`),
  KEY `FK_adres_ulice_miejscowosci` (`ulice_miejscowosci_id`),
  CONSTRAINT `FK_adres_ulice_miejscowosci` FOREIGN KEY (`ulice_miejscowosci_id`) REFERENCES `ulice_miejscowosci` (`ulice_miejscowosci_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.adres: ~11 rows (około)
DELETE FROM `adres`;
/*!40000 ALTER TABLE `adres` DISABLE KEYS */;
INSERT INTO `adres` (`adres_ID`, `ulice_miejscowosci_id`, `nr_domu`, `nr_mieszkania`) VALUES
	(001, 000006, '23', '12'),
	(002, 000005, '1', '123'),
	(003, 000012, '23', '3'),
	(004, 000006, '23', '33'),
	(005, 000014, '23', '12'),
	(006, 000001, '23', ''),
	(007, 000004, '1', '12'),
	(008, 000014, '23', '12'),
	(009, 000002, '1', '2'),
	(010, 000013, '23', '12'),
	(011, 000012, '23', '19');
/*!40000 ALTER TABLE `adres` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
