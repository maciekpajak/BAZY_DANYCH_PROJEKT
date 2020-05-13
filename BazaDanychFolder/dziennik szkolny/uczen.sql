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

-- Zrzut struktury tabela dziennik szkolny.uczen
CREATE TABLE IF NOT EXISTS `uczen` (
  `uczen_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `pesel` char(11) NOT NULL,
  `adres_id` int(3) unsigned zerofill NOT NULL,
  `klasa_id` int(2) unsigned zerofill NOT NULL,
  `opiekunowie_id` int(3) unsigned zerofill NOT NULL,
  `uzytkownik_login` varchar(16) CHARACTER SET ucs2 COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`uczen_ID`),
  UNIQUE KEY `ID` (`uczen_ID`,`pesel`),
  UNIQUE KEY `uzytkownik_login` (`uzytkownik_login`),
  KEY `powiazanie` (`opiekunowie_id`),
  KEY `uzytkownik` (`uzytkownik_login`),
  KEY `klasa` (`klasa_id`),
  KEY `FK_uczen_adres` (`adres_id`),
  CONSTRAINT `FK_uczen_adres` FOREIGN KEY (`adres_id`) REFERENCES `adres` (`adres_ID`),
  CONSTRAINT `FK_uczen_klasa` FOREIGN KEY (`klasa_id`) REFERENCES `klasa` (`klasa_ID`),
  CONSTRAINT `FK_uczen_powiazanie` FOREIGN KEY (`opiekunowie_id`) REFERENCES `opiekunowie` (`opiekunowie_ID`),
  CONSTRAINT `FK_uczen_uzytkownik` FOREIGN KEY (`uzytkownik_login`) REFERENCES `uzytkownik` (`uzytkownik_login`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Zrzucanie danych dla tabeli dziennik szkolny.uczen: ~3 rows (około)
DELETE FROM `uczen`;
/*!40000 ALTER TABLE `uczen` DISABLE KEYS */;
INSERT INTO `uczen` (`uczen_ID`, `pesel`, `adres_id`, `klasa_id`, `opiekunowie_id`, `uzytkownik_login`) VALUES
	(001, '99999999999', 009, 07, 001, 'U0001'),
	(002, '99999999998', 009, 02, 002, 'U0002'),
	(003, '99999999997', 008, 07, 003, 'U0003');
/*!40000 ALTER TABLE `uczen` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
