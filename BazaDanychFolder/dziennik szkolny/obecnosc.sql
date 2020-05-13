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

-- Zrzut struktury tabela dziennik szkolny.obecnosc
CREATE TABLE IF NOT EXISTS `obecnosc` (
  `obecnosc_ID` int(7) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `status` enum('obecny','nieobecny','spóźniony') COLLATE ucs2_polish_ci NOT NULL DEFAULT 'obecny',
  `uczen_id` int(3) unsigned zerofill NOT NULL,
  `lekcja_id` int(5) unsigned zerofill NOT NULL,
  PRIMARY KEY (`obecnosc_ID`),
  UNIQUE KEY `obecność_id` (`obecnosc_ID`) USING BTREE,
  KEY `uczen` (`uczen_id`),
  KEY `lekcja` (`lekcja_id`),
  CONSTRAINT `FK_obecnosc_lekcja` FOREIGN KEY (`lekcja_id`) REFERENCES `lekcja` (`lekcja_ID`),
  CONSTRAINT `FK_obecnosc_uczen` FOREIGN KEY (`uczen_id`) REFERENCES `uczen` (`uczen_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.obecnosc: ~11 rows (około)
DELETE FROM `obecnosc`;
/*!40000 ALTER TABLE `obecnosc` DISABLE KEYS */;
INSERT INTO `obecnosc` (`obecnosc_ID`, `status`, `uczen_id`, `lekcja_id`) VALUES
	(0000001, 'spóźniony', 001, 00001),
	(0000002, 'obecny', 001, 00002),
	(0000003, 'obecny', 001, 00003),
	(0000004, 'nieobecny', 001, 00004),
	(0000005, 'obecny', 002, 00001),
	(0000006, 'nieobecny', 002, 00002),
	(0000007, 'obecny', 002, 00003),
	(0000008, 'obecny', 003, 00001),
	(0000009, 'obecny', 003, 00002),
	(0000010, 'obecny', 003, 00003),
	(0000011, 'obecny', 003, 00004);
/*!40000 ALTER TABLE `obecnosc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
