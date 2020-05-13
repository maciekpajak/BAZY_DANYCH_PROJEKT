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

-- Zrzut struktury tabela dziennik szkolny.nauczyciel_przedmiotu
CREATE TABLE IF NOT EXISTS `nauczyciel_przedmiotu` (
  `nauczyciel_przedmiotu_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `nauczyciel_id` int(2) unsigned zerofill NOT NULL,
  `przedmiot_nazwa` varchar(32) COLLATE ucs2_polish_ci DEFAULT NULL,
  PRIMARY KEY (`nauczyciel_przedmiotu_ID`),
  UNIQUE KEY `ID` (`nauczyciel_przedmiotu_ID`),
  KEY `FK_nauczyciel_przedmiotu_przedmiot` (`przedmiot_nazwa`),
  KEY `FK_nauczyciel_przedmiotu_nauczyciel` (`nauczyciel_id`),
  CONSTRAINT `FK_nauczyciel_przedmiotu_nauczyciel` FOREIGN KEY (`nauczyciel_id`) REFERENCES `nauczyciel` (`nauczyciel_ID`),
  CONSTRAINT `FK_nauczyciel_przedmiotu_przedmiot` FOREIGN KEY (`przedmiot_nazwa`) REFERENCES `przedmiot` (`przedmiot_nazwa`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.nauczyciel_przedmiotu: ~3 rows (około)
DELETE FROM `nauczyciel_przedmiotu`;
/*!40000 ALTER TABLE `nauczyciel_przedmiotu` DISABLE KEYS */;
INSERT INTO `nauczyciel_przedmiotu` (`nauczyciel_przedmiotu_ID`, `nauczyciel_id`, `przedmiot_nazwa`) VALUES
	(001, 01, 'WOS'),
	(002, 01, 'historia'),
	(003, 02, 'matematyka');
/*!40000 ALTER TABLE `nauczyciel_przedmiotu` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
