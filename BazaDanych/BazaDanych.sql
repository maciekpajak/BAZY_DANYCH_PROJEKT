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

-- Zrzut struktury tabela dziennik szkolny.adres
CREATE TABLE IF NOT EXISTS `adres` (
  `ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `ulica_id` int(3) unsigned zerofill DEFAULT NULL,
  `nr_domu` varchar(6) COLLATE ucs2_polish_ci NOT NULL,
  `nr_mieszkania` varchar(4) COLLATE ucs2_polish_ci DEFAULT NULL,
  `kod` int(5) unsigned NOT NULL,
  `miejscowosc_id` int(3) unsigned zerofill NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `FK_adres_ulica` (`ulica_id`),
  KEY `FK_adres_miejscowosc` (`miejscowosc_id`),
  CONSTRAINT `FK_adres_miejscowosc` FOREIGN KEY (`miejscowosc_id`) REFERENCES `miejscowosc` (`ID`),
  CONSTRAINT `FK_adres_ulica` FOREIGN KEY (`ulica_id`) REFERENCES `ulica` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.adres: ~0 rows (około)
DELETE FROM `adres`;
/*!40000 ALTER TABLE `adres` DISABLE KEYS */;
/*!40000 ALTER TABLE `adres` ENABLE KEYS */;

-- Zrzut struktury tabela dziennik szkolny.czas_lekcji
CREATE TABLE IF NOT EXISTS `czas_lekcji` (
  `ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL DEFAULT '0000-00-00',
  `godz_start` time NOT NULL DEFAULT '00:00:00',
  `godz_koniec` time NOT NULL DEFAULT '00:00:00',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.czas_lekcji: ~0 rows (około)
DELETE FROM `czas_lekcji`;
/*!40000 ALTER TABLE `czas_lekcji` DISABLE KEYS */;
/*!40000 ALTER TABLE `czas_lekcji` ENABLE KEYS */;

-- Zrzut struktury tabela dziennik szkolny.grupa_lekcji
CREATE TABLE IF NOT EXISTS `grupa_lekcji` (
  `ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `klasa_id` int(2) unsigned zerofill NOT NULL,
  `przedmiot_id` varchar(32) COLLATE ucs2_polish_ci NOT NULL DEFAULT '',
  `nauczyciel_id` int(2) unsigned zerofill NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `FK_grupa_lekcji_klasa` (`klasa_id`),
  KEY `FK_grupa_lekcji_nauczyciel` (`nauczyciel_id`),
  KEY `FK_grupa_lekcji_przedmiot` (`przedmiot_id`),
  CONSTRAINT `FK_grupa_lekcji_klasa` FOREIGN KEY (`klasa_id`) REFERENCES `klasa` (`ID`),
  CONSTRAINT `FK_grupa_lekcji_nauczyciel` FOREIGN KEY (`nauczyciel_id`) REFERENCES `nauczyciel` (`ID`),
  CONSTRAINT `FK_grupa_lekcji_przedmiot` FOREIGN KEY (`przedmiot_id`) REFERENCES `przedmiot` (`nazwa`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.grupa_lekcji: ~0 rows (około)
DELETE FROM `grupa_lekcji`;
/*!40000 ALTER TABLE `grupa_lekcji` DISABLE KEYS */;
/*!40000 ALTER TABLE `grupa_lekcji` ENABLE KEYS */;

-- Zrzut struktury tabela dziennik szkolny.klasa
CREATE TABLE IF NOT EXISTS `klasa` (
  `ID` int(2) unsigned zerofill NOT NULL,
  `oddzial` char(3) COLLATE ucs2_polish_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.klasa: ~16 rows (około)
DELETE FROM `klasa`;
/*!40000 ALTER TABLE `klasa` DISABLE KEYS */;
INSERT INTO `klasa` (`ID`, `oddzial`) VALUES
	(01, '1a\r'),
	(02, '1b\r'),
	(03, '1c\r'),
	(04, '1d\r'),
	(05, '2a\r'),
	(06, '2b\r'),
	(07, '2c\r'),
	(08, '2d\r'),
	(09, '3a\r'),
	(10, '3b\r'),
	(11, '3c\r'),
	(12, '3d\r'),
	(13, '4a\r'),
	(14, '4b\r'),
	(15, '4c\r'),
	(16, '4d\r');
/*!40000 ALTER TABLE `klasa` ENABLE KEYS */;

-- Zrzut struktury tabela dziennik szkolny.lekcja
CREATE TABLE IF NOT EXISTS `lekcja` (
  `ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `temat` varchar(250) COLLATE ucs2_polish_ci NOT NULL,
  `sala` int(2) unsigned NOT NULL,
  `grupa_lekcji_id` int(3) unsigned zerofill NOT NULL,
  `czas_lekcji_id` int(5) unsigned zerofill NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `lekcja_id` (`ID`),
  KEY `FK_lekcja_grupa_lekcji` (`grupa_lekcji_id`),
  KEY `FK_lekcja_czas_lekcji` (`czas_lekcji_id`),
  CONSTRAINT `FK_lekcja_czas_lekcji` FOREIGN KEY (`czas_lekcji_id`) REFERENCES `czas_lekcji` (`ID`),
  CONSTRAINT `FK_lekcja_grupa_lekcji` FOREIGN KEY (`grupa_lekcji_id`) REFERENCES `grupa_lekcji` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=45201 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.lekcja: ~0 rows (około)
DELETE FROM `lekcja`;
/*!40000 ALTER TABLE `lekcja` DISABLE KEYS */;
/*!40000 ALTER TABLE `lekcja` ENABLE KEYS */;

-- Zrzut struktury tabela dziennik szkolny.miejscowosc
CREATE TABLE IF NOT EXISTS `miejscowosc` (
  `ID` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(30) COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.miejscowosc: ~0 rows (około)
DELETE FROM `miejscowosc`;
/*!40000 ALTER TABLE `miejscowosc` DISABLE KEYS */;
/*!40000 ALTER TABLE `miejscowosc` ENABLE KEYS */;

-- Zrzut struktury tabela dziennik szkolny.nauczyciel
CREATE TABLE IF NOT EXISTS `nauczyciel` (
  `ID` int(2) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `nr_tel` char(50) COLLATE ucs2_polish_ci NOT NULL,
  `czy_wych` enum('Y','N') COLLATE ucs2_polish_ci NOT NULL DEFAULT 'N',
  `uzytkownik_login` varchar(16) COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `FK_nauczyciel_uzytkownik_2` (`uzytkownik_login`),
  CONSTRAINT `FK_nauczyciel_uzytkownik_2` FOREIGN KEY (`uzytkownik_login`) REFERENCES `uzytkownik` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.nauczyciel: ~0 rows (około)
DELETE FROM `nauczyciel`;
/*!40000 ALTER TABLE `nauczyciel` DISABLE KEYS */;
/*!40000 ALTER TABLE `nauczyciel` ENABLE KEYS */;

-- Zrzut struktury tabela dziennik szkolny.nauczyciel_przedmiotu
CREATE TABLE IF NOT EXISTS `nauczyciel_przedmiotu` (
  `ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `nauczyciel_id` int(2) unsigned zerofill NOT NULL,
  `przedmiot_nazwa` varchar(32) COLLATE ucs2_polish_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `FK_nauczyciel_przedmiotu_przedmiot` (`przedmiot_nazwa`),
  KEY `FK_nauczyciel_przedmiotu_nauczyciel` (`nauczyciel_id`),
  CONSTRAINT `FK_nauczyciel_przedmiotu_nauczyciel` FOREIGN KEY (`nauczyciel_id`) REFERENCES `nauczyciel` (`ID`),
  CONSTRAINT `FK_nauczyciel_przedmiotu_przedmiot` FOREIGN KEY (`przedmiot_nazwa`) REFERENCES `przedmiot` (`nazwa`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.nauczyciel_przedmiotu: ~0 rows (około)
DELETE FROM `nauczyciel_przedmiotu`;
/*!40000 ALTER TABLE `nauczyciel_przedmiotu` DISABLE KEYS */;
/*!40000 ALTER TABLE `nauczyciel_przedmiotu` ENABLE KEYS */;

-- Zrzut struktury tabela dziennik szkolny.obecnosc
CREATE TABLE IF NOT EXISTS `obecnosc` (
  `ID` int(7) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `status` enum('obecny','nieobecny','spozniony') COLLATE ucs2_polish_ci NOT NULL DEFAULT 'obecny',
  `uczen` int(3) unsigned zerofill NOT NULL,
  `lekcja` int(5) unsigned zerofill NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `obecność_id` (`ID`),
  KEY `uczen` (`uczen`),
  KEY `lekcja` (`lekcja`),
  CONSTRAINT `FK_obecnosc_lekcja` FOREIGN KEY (`lekcja`) REFERENCES `lekcja` (`ID`),
  CONSTRAINT `FK_obecnosc_uczen` FOREIGN KEY (`uczen`) REFERENCES `uczen` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4768 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.obecnosc: ~0 rows (około)
DELETE FROM `obecnosc`;
/*!40000 ALTER TABLE `obecnosc` DISABLE KEYS */;
/*!40000 ALTER TABLE `obecnosc` ENABLE KEYS */;

-- Zrzut struktury tabela dziennik szkolny.ocena
CREATE TABLE IF NOT EXISTS `ocena` (
  `ID` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `stopien` enum('brak','ndst','dop','dst','db','bdb','cel') NOT NULL,
  `waga` int(1) unsigned NOT NULL DEFAULT 1,
  `opis` varchar(100) NOT NULL DEFAULT '',
  `data` date NOT NULL,
  `uczen` int(3) unsigned zerofill NOT NULL,
  `nauczyciel_przedmiotu` int(3) unsigned zerofill NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Indeks 1` (`ID`),
  KEY `uczen` (`uczen`),
  KEY `nauczyciel` (`nauczyciel_przedmiotu`),
  CONSTRAINT `FK_ocena_uczen` FOREIGN KEY (`uczen`) REFERENCES `uczen` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2401 DEFAULT CHARSET=latin1;

-- Zrzucanie danych dla tabeli dziennik szkolny.ocena: ~0 rows (około)
DELETE FROM `ocena`;
/*!40000 ALTER TABLE `ocena` DISABLE KEYS */;
/*!40000 ALTER TABLE `ocena` ENABLE KEYS */;

-- Zrzut struktury tabela dziennik szkolny.opiekunowie
CREATE TABLE IF NOT EXISTS `opiekunowie` (
  `ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=481 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.opiekunowie: ~0 rows (około)
DELETE FROM `opiekunowie`;
/*!40000 ALTER TABLE `opiekunowie` DISABLE KEYS */;
/*!40000 ALTER TABLE `opiekunowie` ENABLE KEYS */;

-- Zrzut struktury widok dziennik szkolny.podzial_klas
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `podzial_klas` 
) ENGINE=MyISAM;

-- Zrzut struktury tabela dziennik szkolny.przedmiot
CREATE TABLE IF NOT EXISTS `przedmiot` (
  `nazwa` varchar(32) COLLATE ucs2_polish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`nazwa`),
  UNIQUE KEY `przedmiot_nazwa` (`nazwa`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.przedmiot: ~11 rows (około)
DELETE FROM `przedmiot`;
/*!40000 ALTER TABLE `przedmiot` DISABLE KEYS */;
INSERT INTO `przedmiot` (`nazwa`) VALUES
	('biologia\r'),
	('chemia\r'),
	('fizyka\r'),
	('geografia\r'),
	('historia\r'),
	('j.angielski\r'),
	('j.niemiecki\r'),
	('j.polski\r'),
	('matematyka\r'),
	('wf\r'),
	('WOS\r');
/*!40000 ALTER TABLE `przedmiot` ENABLE KEYS */;

-- Zrzut struktury tabela dziennik szkolny.rodzic
CREATE TABLE IF NOT EXISTS `rodzic` (
  `ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `nr_telefonu` varchar(12) COLLATE ucs2_polish_ci DEFAULT NULL,
  `opiekunowie_id` int(3) unsigned zerofill NOT NULL,
  `uzytkownik_login` varchar(16) COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `powiazanie` (`opiekunowie_id`),
  KEY `FK_rodzic_uzytkownik_2` (`uzytkownik_login`),
  CONSTRAINT `FK_rodzic_powiazanie` FOREIGN KEY (`opiekunowie_id`) REFERENCES `opiekunowie` (`ID`),
  CONSTRAINT `FK_rodzic_uzytkownik_2` FOREIGN KEY (`uzytkownik_login`) REFERENCES `uzytkownik` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=961 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.rodzic: ~0 rows (około)
DELETE FROM `rodzic`;
/*!40000 ALTER TABLE `rodzic` DISABLE KEYS */;
/*!40000 ALTER TABLE `rodzic` ENABLE KEYS */;

-- Zrzut struktury tabela dziennik szkolny.uczen
CREATE TABLE IF NOT EXISTS `uczen` (
  `ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `pesel` char(11) NOT NULL,
  `adres` int(3) unsigned zerofill NOT NULL,
  `klasa` int(2) unsigned zerofill NOT NULL,
  `opiekunowie_id` int(3) unsigned zerofill NOT NULL,
  `uzytkownik_login` varchar(16) CHARACTER SET ucs2 COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`,`pesel`),
  KEY `powiazanie` (`opiekunowie_id`),
  KEY `uzytkownik` (`uzytkownik_login`),
  KEY `klasa` (`klasa`),
  CONSTRAINT `FK_uczen_klasa` FOREIGN KEY (`klasa`) REFERENCES `klasa` (`ID`),
  CONSTRAINT `FK_uczen_powiazanie` FOREIGN KEY (`opiekunowie_id`) REFERENCES `opiekunowie` (`ID`),
  CONSTRAINT `FK_uczen_uzytkownik` FOREIGN KEY (`uzytkownik_login`) REFERENCES `uzytkownik` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=481 DEFAULT CHARSET=latin1;

-- Zrzucanie danych dla tabeli dziennik szkolny.uczen: ~0 rows (około)
DELETE FROM `uczen`;
/*!40000 ALTER TABLE `uczen` DISABLE KEYS */;
/*!40000 ALTER TABLE `uczen` ENABLE KEYS */;

-- Zrzut struktury tabela dziennik szkolny.ulica
CREATE TABLE IF NOT EXISTS `ulica` (
  `ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(30) COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.ulica: ~0 rows (około)
DELETE FROM `ulica`;
/*!40000 ALTER TABLE `ulica` DISABLE KEYS */;
/*!40000 ALTER TABLE `ulica` ENABLE KEYS */;

-- Zrzut struktury tabela dziennik szkolny.ulice_miejscowosci
CREATE TABLE IF NOT EXISTS `ulice_miejscowosci` (
  `ID` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `miejscowosc_id` int(3) unsigned zerofill NOT NULL,
  `ulica_id` int(3) unsigned zerofill NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `FK_ulice_miejscowosci_miejscowosc` (`miejscowosc_id`),
  KEY `FK_ulice_miejscowosci_ulica` (`ulica_id`),
  CONSTRAINT `FK_ulice_miejscowosci_miejscowosc` FOREIGN KEY (`miejscowosc_id`) REFERENCES `miejscowosc` (`ID`),
  CONSTRAINT `FK_ulice_miejscowosci_ulica` FOREIGN KEY (`ulica_id`) REFERENCES `ulica` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.ulice_miejscowosci: ~0 rows (około)
DELETE FROM `ulice_miejscowosci`;
/*!40000 ALTER TABLE `ulice_miejscowosci` DISABLE KEYS */;
/*!40000 ALTER TABLE `ulice_miejscowosci` ENABLE KEYS */;

-- Zrzut struktury tabela dziennik szkolny.uzytkownik
CREATE TABLE IF NOT EXISTS `uzytkownik` (
  `login` varchar(16) COLLATE ucs2_polish_ci NOT NULL,
  `imie` varchar(20) COLLATE ucs2_polish_ci NOT NULL,
  `nazwisko` varchar(30) COLLATE ucs2_polish_ci NOT NULL,
  `haslo` char(32) COLLATE ucs2_polish_ci NOT NULL,
  `rodzaj` enum('U','N','R','I') COLLATE ucs2_polish_ci NOT NULL,
  `email` varchar(32) COLLATE ucs2_polish_ci DEFAULT NULL,
  PRIMARY KEY (`login`),
  UNIQUE KEY `login` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.uzytkownik: ~0 rows (około)
DELETE FROM `uzytkownik`;
/*!40000 ALTER TABLE `uzytkownik` DISABLE KEYS */;
/*!40000 ALTER TABLE `uzytkownik` ENABLE KEYS */;

-- Zrzut struktury widok dziennik szkolny.podzial_klas
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `podzial_klas`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `podzial_klas` AS select `kl`.`oddzial` AS `oddzial`,`ucz`.`imie` AS `imie`,`ucz`.`nazwisko` AS `nazwisko` from (`klasa` `kl` join `uczen` `ucz` on(`kl`.`ID` = `ucz`.`klasa`)) order by `kl`.`oddzial`,`ucz`.`nazwisko`;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
