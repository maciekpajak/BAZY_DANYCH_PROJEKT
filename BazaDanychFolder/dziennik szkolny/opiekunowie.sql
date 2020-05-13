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

-- Zrzut struktury tabela dziennik szkolny.opiekunowie
CREATE TABLE IF NOT EXISTS `opiekunowie` (
  `opiekunowie_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`opiekunowie_ID`),
  UNIQUE KEY `ID` (`opiekunowie_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.opiekunowie: ~6 rows (około)
DELETE FROM `opiekunowie`;
/*!40000 ALTER TABLE `opiekunowie` DISABLE KEYS */;
INSERT INTO `opiekunowie` (`opiekunowie_ID`) VALUES
	(001),
	(002),
	(003),
	(004),
	(005),
	(006);
/*!40000 ALTER TABLE `opiekunowie` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
