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

-- Zrzut struktury tabela dziennik szkolny.przedmiot
CREATE TABLE IF NOT EXISTS `przedmiot` (
  `przedmiot_nazwa` varchar(32) COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`przedmiot_nazwa`),
  UNIQUE KEY `przedmiot_nazwa` (`przedmiot_nazwa`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.przedmiot: ~14 rows (około)
DELETE FROM `przedmiot`;
/*!40000 ALTER TABLE `przedmiot` DISABLE KEYS */;
INSERT INTO `przedmiot` (`przedmiot_nazwa`) VALUES
	('angielski\r'),
	('biologia'),
	('chemia'),
	('fizyka\r'),
	('geografia'),
	('historia\r'),
	('historia'),
	('matematyka\r'),
	('matematyka'),
	('niemiecki\r'),
	('polski'),
	('wf\r'),
	('WOS\r'),
	('WOS');
/*!40000 ALTER TABLE `przedmiot` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
