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

-- Zrzut struktury tabela dziennik szkolny.klasa
CREATE TABLE IF NOT EXISTS `klasa` (
  `klasa_ID` int(2) unsigned zerofill NOT NULL,
  `oddzial` varchar(3) COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`klasa_ID`),
  UNIQUE KEY `ID` (`klasa_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.klasa: ~16 rows (około)
DELETE FROM `klasa`;
/*!40000 ALTER TABLE `klasa` DISABLE KEYS */;
INSERT INTO `klasa` (`klasa_ID`, `oddzial`) VALUES
	(01, '1a'),
	(02, '1b'),
	(03, '1c'),
	(04, '1d'),
	(05, '2a'),
	(06, '2b'),
	(07, '2c'),
	(08, '2d'),
	(09, '3a'),
	(10, '3b'),
	(11, '3c'),
	(12, '3d'),
	(13, '4a'),
	(14, '4b'),
	(15, '4c'),
	(16, '4d');
/*!40000 ALTER TABLE `klasa` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
