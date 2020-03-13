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


-- Zrzut struktury bazy danych dziennik szkolny
CREATE DATABASE IF NOT EXISTS `dziennik szkolny` /*!40100 DEFAULT CHARACTER SET ucs2 COLLATE ucs2_polish_ci */;
USE `dziennik szkolny`;

-- Zrzut struktury tabela dziennik szkolny.klasa
CREATE TABLE IF NOT EXISTS `klasa` (
  `klasa_nr` char(2) COLLATE ucs2_polish_ci NOT NULL,
  `liczba_uczniow` int(2) unsigned NOT NULL,
  `wychowawca_id` int(6) unsigned zerofill NOT NULL,
  UNIQUE KEY `oddział` (`klasa_nr`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Eksport danych został odznaczony.

-- Zrzut struktury tabela dziennik szkolny.lekcja
CREATE TABLE IF NOT EXISTS `lekcja` (
  `lekcja_id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `temat` text COLLATE ucs2_polish_ci DEFAULT NULL,
  `data` date NOT NULL,
  `godz. rozp` time NOT NULL,
  `godz. zak` time NOT NULL,
  `klasa` char(2) COLLATE ucs2_polish_ci NOT NULL,
  `nauczyciel` int(6) unsigned zerofill NOT NULL,
  `przedmiot` char(50) COLLATE ucs2_polish_ci NOT NULL,
  UNIQUE KEY `lekcja_id` (`lekcja_id`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Eksport danych został odznaczony.

-- Zrzut struktury tabela dziennik szkolny.nauczyciel
CREATE TABLE IF NOT EXISTS `nauczyciel` (
  `nauczyciel_id` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `przedmiot_nazwa` char(50) COLLATE ucs2_polish_ci NOT NULL,
  `imię` char(50) COLLATE ucs2_polish_ci NOT NULL,
  `nazwisko` char(50) COLLATE ucs2_polish_ci NOT NULL,
  UNIQUE KEY `nauczyciel_id` (`nauczyciel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Eksport danych został odznaczony.

-- Zrzut struktury tabela dziennik szkolny.obecność
CREATE TABLE IF NOT EXISTS `obecność` (
  `obecność_id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `uczen_pesel` int(11) NOT NULL DEFAULT 0,
  `lekcja_id` int(10) unsigned zerofill NOT NULL,
  `status` enum('obecny','nieobecny','spóźniony') COLLATE ucs2_polish_ci NOT NULL DEFAULT 'obecny',
  UNIQUE KEY `obecność_id` (`obecność_id`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Eksport danych został odznaczony.

-- Zrzut struktury tabela dziennik szkolny.ocena
CREATE TABLE IF NOT EXISTS `ocena` (
  `ocena_id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `stopień` enum('ndst','dop','dst','db','bdb','cel') NOT NULL,
  `data` date NOT NULL,
  `waga` int(1) unsigned NOT NULL DEFAULT 1,
  `opis` text NOT NULL,
  `uczen` int(11) unsigned NOT NULL DEFAULT 0,
  `nauczyciel` int(6) unsigned zerofill NOT NULL DEFAULT 000000,
  `przedmiot` char(50) NOT NULL DEFAULT 'N',
  UNIQUE KEY `Indeks 1` (`ocena_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Eksport danych został odznaczony.

-- Zrzut struktury tabela dziennik szkolny.przedmiot
CREATE TABLE IF NOT EXISTS `przedmiot` (
  `przedmiot_nazwa` char(50) COLLATE ucs2_polish_ci NOT NULL,
  UNIQUE KEY `przedmiot_nazwa` (`przedmiot_nazwa`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Eksport danych został odznaczony.

-- Zrzut struktury tabela dziennik szkolny.rodzic
CREATE TABLE IF NOT EXISTS `rodzic` (
  `Kolumna 3` char(12) COLLATE ucs2_polish_ci DEFAULT NULL,
  `imie_i_nazwisko` char(50) COLLATE ucs2_polish_ci DEFAULT NULL,
  `nr_telefonu` char(12) COLLATE ucs2_polish_ci DEFAULT NULL,
  `e_mail` char(50) COLLATE ucs2_polish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Eksport danych został odznaczony.

-- Zrzut struktury tabela dziennik szkolny.uczen
CREATE TABLE IF NOT EXISTS `uczen` (
  `pesel` int(11) unsigned zerofill NOT NULL,
  `imie_i_nazwisko` char(50) NOT NULL,
  `oddział` enum('1','2','3','4') NOT NULL,
  `adres` char(50) DEFAULT NULL,
  `Kolumna 3` char(50) NOT NULL,
  `Kolumna 4` char(50) NOT NULL,
  `Kolumna 5` char(50) NOT NULL,
  UNIQUE KEY `pesel` (`pesel`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Eksport danych został odznaczony.

-- Zrzut struktury tabela dziennik szkolny.wychowawca
CREATE TABLE IF NOT EXISTS `wychowawca` (
  `ID` int(6) unsigned zerofill NOT NULL,
  `imie_i_nazwisko` char(50) COLLATE ucs2_polish_ci NOT NULL,
  `nr telefonu` char(12) COLLATE ucs2_polish_ci NOT NULL,
  `e_mail` char(50) COLLATE ucs2_polish_ci NOT NULL,
  `klasa_wychowawcza` char(3) COLLATE ucs2_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Eksport danych został odznaczony.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
