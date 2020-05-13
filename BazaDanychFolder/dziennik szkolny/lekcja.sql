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

-- Zrzut struktury tabela dziennik szkolny.lekcja
CREATE TABLE IF NOT EXISTS `lekcja` (
  `lekcja_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `temat` varchar(250) COLLATE ucs2_polish_ci NOT NULL,
  `sala` int(2) unsigned NOT NULL,
  `grupa_lekcji_id` int(3) unsigned zerofill NOT NULL,
  `czas_lekcji_id` int(5) unsigned zerofill NOT NULL,
  PRIMARY KEY (`lekcja_ID`),
  UNIQUE KEY `lekcja_id` (`lekcja_ID`) USING BTREE,
  KEY `FK_lekcja_grupa_lekcji` (`grupa_lekcji_id`),
  KEY `FK_lekcja_czas_lekcji` (`czas_lekcji_id`),
  CONSTRAINT `FK_lekcja_czas_lekcji` FOREIGN KEY (`czas_lekcji_id`) REFERENCES `czaslekcji` (`czaslekcji_ID`),
  CONSTRAINT `FK_lekcja_grupa_lekcji` FOREIGN KEY (`grupa_lekcji_id`) REFERENCES `grupa_lekcji` (`grupa_lekcji_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.lekcja: ~7 rows (około)
DELETE FROM `lekcja`;
/*!40000 ALTER TABLE `lekcja` DISABLE KEYS */;
INSERT INTO `lekcja` (`lekcja_ID`, `temat`, `sala`, `grupa_lekcji_id`, `czas_lekcji_id`) VALUES
	(00001, 'To jest nowy temat lekcji wywołany przez procedurę zmiana_tematu_lekcji', 12, 001, 00001),
	(00002, 'Temat', 12, 002, 00001),
	(00003, 'Temat', 12, 003, 00001),
	(00004, 'Temat', 12, 001, 00002),
	(00005, 'Temat', 12, 002, 00002),
	(00006, 'Temat', 12, 003, 00002),
	(00007, 'Procedury, widoki, wyzwalacze i indeksy', 12, 002, 00004);
/*!40000 ALTER TABLE `lekcja` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
