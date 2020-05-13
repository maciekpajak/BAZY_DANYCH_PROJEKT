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

-- Zrzut struktury tabela dziennik szkolny.rodzic
CREATE TABLE IF NOT EXISTS `rodzic` (
  `rodzic_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `uzytkownik_login` varchar(16) COLLATE ucs2_polish_ci NOT NULL,
  `nr_telefonu` varchar(12) COLLATE ucs2_polish_ci DEFAULT NULL,
  `opiekunowie_id` int(3) unsigned zerofill NOT NULL,
  PRIMARY KEY (`rodzic_ID`),
  UNIQUE KEY `ID` (`rodzic_ID`),
  UNIQUE KEY `uzytkownik_login` (`uzytkownik_login`),
  KEY `powiazanie` (`opiekunowie_id`),
  CONSTRAINT `FK_rodzic_powiazanie` FOREIGN KEY (`opiekunowie_id`) REFERENCES `opiekunowie` (`opiekunowie_ID`),
  CONSTRAINT `FK_rodzic_uzytkownik` FOREIGN KEY (`uzytkownik_login`) REFERENCES `uzytkownik` (`uzytkownik_login`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.rodzic: ~6 rows (około)
DELETE FROM `rodzic`;
/*!40000 ALTER TABLE `rodzic` DISABLE KEYS */;
INSERT INTO `rodzic` (`rodzic_ID`, `uzytkownik_login`, `nr_telefonu`, `opiekunowie_id`) VALUES
	(001, 'R0001', '12313', 001),
	(002, 'R0002', '12313', 001),
	(003, 'R0003', '12313', 002),
	(004, 'R0004', '12313', 002),
	(005, 'R0005', '12313', 003),
	(006, 'R0006', '12313', 003);
/*!40000 ALTER TABLE `rodzic` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
