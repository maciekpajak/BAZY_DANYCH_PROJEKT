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

-- Zrzut struktury tabela dziennik szkolny.ulice_miejscowosci
CREATE TABLE IF NOT EXISTS `ulice_miejscowosci` (
  `ulice_miejscowosci_ID` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `miejscowosc_id` int(3) unsigned zerofill NOT NULL,
  `ulica_id` int(3) unsigned zerofill NOT NULL,
  `kod` int(5) unsigned NOT NULL,
  PRIMARY KEY (`ulice_miejscowosci_ID`),
  UNIQUE KEY `ID` (`ulice_miejscowosci_ID`) USING BTREE,
  KEY `FK_ulice_miejscowosci_miejscowosc` (`miejscowosc_id`),
  KEY `FK_ulice_miejscowosci_ulica` (`ulica_id`),
  CONSTRAINT `FK_ulice_miejscowosci_miejscowosc` FOREIGN KEY (`miejscowosc_id`) REFERENCES `miejscowosc` (`miejscowosc_ID`),
  CONSTRAINT `FK_ulice_miejscowosci_ulica` FOREIGN KEY (`ulica_id`) REFERENCES `ulica` (`ulica_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.ulice_miejscowosci: ~15 rows (około)
DELETE FROM `ulice_miejscowosci`;
/*!40000 ALTER TABLE `ulice_miejscowosci` DISABLE KEYS */;
INSERT INTO `ulice_miejscowosci` (`ulice_miejscowosci_ID`, `miejscowosc_id`, `ulica_id`, `kod`) VALUES
	(000001, 001, 002, 50500),
	(000002, 004, 006, 50123),
	(000003, 005, 004, 50123),
	(000004, 003, 006, 50123),
	(000005, 002, 004, 50234),
	(000006, 004, 009, 50123),
	(000007, 003, 001, 50123),
	(000008, 006, 001, 50123),
	(000009, 004, 006, 50123),
	(000010, 001, 006, 50123),
	(000011, 004, 006, 50123),
	(000012, 002, 008, 50123),
	(000013, 006, 010, 50123),
	(000014, 004, 013, 50123),
	(000015, 002, 006, 50123);
/*!40000 ALTER TABLE `ulice_miejscowosci` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
