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

-- Zrzut struktury tabela dziennik szkolny.ulica
CREATE TABLE IF NOT EXISTS `ulica` (
  `ulica_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(30) COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`ulica_ID`),
  UNIQUE KEY `ID` (`ulica_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.ulica: ~14 rows (około)
DELETE FROM `ulica`;
/*!40000 ALTER TABLE `ulica` DISABLE KEYS */;
INSERT INTO `ulica` (`ulica_ID`, `nazwa`) VALUES
	(001, 'Mickiewicza'),
	(002, 'Afgańska'),
	(003, 'Agatowa'),
	(004, 'Alpejska'),
	(005, 'Ananasowa'),
	(006, 'Bazaltowa'),
	(007, 'Belgijska'),
	(008, 'Bema'),
	(009, 'Bolesława Prusa'),
	(010, 'Cicha'),
	(011, 'Dworcowa'),
	(012, 'Grunwaldzka'),
	(013, 'Grzybowa'),
	(014, 'Dwóch Mieczy');
/*!40000 ALTER TABLE `ulica` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
