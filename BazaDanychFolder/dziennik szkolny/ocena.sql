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

-- Zrzut struktury tabela dziennik szkolny.ocena
CREATE TABLE IF NOT EXISTS `ocena` (
  `ocena_ID` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `stopien` enum('brak','ndst','dop','dst','db','bdb','cel') COLLATE utf8_polish_ci NOT NULL,
  `waga` int(1) unsigned NOT NULL DEFAULT 1,
  `opis` varchar(100) COLLATE utf8_polish_ci NOT NULL DEFAULT '',
  `data` date NOT NULL,
  `uczen_id` int(3) unsigned zerofill NOT NULL,
  `nauczyciel_przedmiotu_id` int(3) unsigned zerofill NOT NULL,
  PRIMARY KEY (`ocena_ID`),
  UNIQUE KEY `Indeks 1` (`ocena_ID`) USING BTREE,
  KEY `nauczyciel` (`nauczyciel_przedmiotu_id`),
  KEY `uczen` (`uczen_id`),
  CONSTRAINT `FK_ocena_nauczyciel_przedmiotu` FOREIGN KEY (`nauczyciel_przedmiotu_id`) REFERENCES `nauczyciel_przedmiotu` (`nauczyciel_przedmiotu_ID`),
  CONSTRAINT `FK_ocena_uczen` FOREIGN KEY (`uczen_id`) REFERENCES `uczen` (`uczen_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.ocena: ~8 rows (około)
DELETE FROM `ocena`;
/*!40000 ALTER TABLE `ocena` DISABLE KEYS */;
INSERT INTO `ocena` (`ocena_ID`, `stopien`, `waga`, `opis`, `data`, `uczen_id`, `nauczyciel_przedmiotu_id`) VALUES
	(000001, 'dop', 3, '', '2020-04-29', 001, 001),
	(000002, 'db', 1, '', '2020-04-29', 003, 002),
	(000003, 'ndst', 2, '', '2020-04-29', 001, 003),
	(000004, 'cel', 1, '', '2020-04-29', 002, 001),
	(000005, 'dst', 1, '', '2020-04-29', 003, 002),
	(000006, 'db', 1, '', '2020-04-29', 001, 003),
	(000007, 'bdb', 8, '', '2020-04-29', 002, 003),
	(000008, 'db', 1, '', '2020-04-29', 003, 001);
/*!40000 ALTER TABLE `ocena` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
