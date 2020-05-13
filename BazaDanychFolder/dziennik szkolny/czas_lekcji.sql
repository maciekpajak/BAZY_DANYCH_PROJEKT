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

-- Zrzut struktury tabela dziennik szkolny.czas_lekcji
CREATE TABLE IF NOT EXISTS `czas_lekcji` (
  `czas_lekcji_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL DEFAULT '0000-00-00',
  `godz_start` time NOT NULL DEFAULT '00:00:00',
  `godz_koniec` time NOT NULL DEFAULT '00:00:00',
  PRIMARY KEY (`czas_lekcji_ID`),
  UNIQUE KEY `ID` (`czas_lekcji_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.czas_lekcji: ~5 rows (około)
DELETE FROM `czas_lekcji`;
/*!40000 ALTER TABLE `czas_lekcji` DISABLE KEYS */;
INSERT INTO `czas_lekcji` (`czas_lekcji_ID`, `data`, `godz_start`, `godz_koniec`) VALUES
	(00001, '2020-05-08', '14:00:00', '14:45:00'),
	(00002, '2020-05-08', '15:00:00', '15:45:00'),
	(00003, '2020-05-09', '14:00:00', '14:45:00'),
	(00004, '2020-05-09', '15:00:00', '15:45:00'),
	(00005, '2020-05-10', '14:00:00', '14:45:00');
/*!40000 ALTER TABLE `czas_lekcji` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
