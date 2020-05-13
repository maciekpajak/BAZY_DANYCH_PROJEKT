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

-- Zrzut struktury tabela dziennik szkolny.uzytkownik
CREATE TABLE IF NOT EXISTS `uzytkownik` (
  `uzytkownik_login` varchar(16) COLLATE ucs2_polish_ci NOT NULL,
  `nazwisko` varchar(30) COLLATE ucs2_polish_ci NOT NULL,
  `imie` varchar(20) COLLATE ucs2_polish_ci NOT NULL,
  `haslo` char(32) COLLATE ucs2_polish_ci NOT NULL,
  `rodzaj` enum('U','N','R','I','A') COLLATE ucs2_polish_ci NOT NULL,
  `email` varchar(32) COLLATE ucs2_polish_ci DEFAULT NULL,
  PRIMARY KEY (`uzytkownik_login`),
  UNIQUE KEY `login` (`uzytkownik_login`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.uzytkownik: ~13 rows (około)
DELETE FROM `uzytkownik`;
/*!40000 ALTER TABLE `uzytkownik` DISABLE KEYS */;
INSERT INTO `uzytkownik` (`uzytkownik_login`, `nazwisko`, `imie`, `haslo`, `rodzaj`, `email`) VALUES
	('adad', 'adsasd', 'asdsad', 'asdasd', 'U', NULL),
	('N0001', 'Trąba', 'Wiktor', '897n23nx723', 'N', NULL),
	('N0002', 'Ameba', 'Adam', '189fb7613', 'N', NULL),
	('N0003', 'Koch', 'Paweł', 'afsgfsgrw', 'N', NULL),
	('R0001', 'Nowak', 'Ewelina', '21n83h3f', 'R', NULL),
	('R0002', 'Nowak', 'Wojciech', '120389f7fn', 'R', NULL),
	('R0003', 'Kowalski', 'Edward', 'm203ifn7', 'R', NULL),
	('R0004', 'Kowalska', 'Hanna', 'o1398nh7', 'R', NULL),
	('R0005', 'Grzyb', 'Adam', '1309ab8ds', 'R', NULL),
	('R0006', 'Grzyb', 'Natalia', '1833b7v64', 'R', NULL),
	('U0001', 'Nowak', 'Michał', 'ADOafgh', 'U', NULL),
	('U0002', 'Kowalski', 'Maksymilian', 'akjgfaify23', 'U', NULL),
	('U0003', 'Grzyb', 'Aleksander', 'haslo', 'U', NULL);
/*!40000 ALTER TABLE `uzytkownik` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
