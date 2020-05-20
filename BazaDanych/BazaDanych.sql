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
  `adres_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `ulice_miejscowosci_id` int(6) unsigned zerofill NOT NULL,
  `nr_domu` varchar(6) COLLATE ucs2_polish_ci NOT NULL,
  `nr_mieszkania` varchar(4) COLLATE ucs2_polish_ci DEFAULT NULL,
  PRIMARY KEY (`adres_ID`),
  UNIQUE KEY `ID` (`adres_ID`),
  KEY `FK_adres_ulice_miejscowosci` (`ulice_miejscowosci_id`),
  CONSTRAINT `FK_adres_ulice_miejscowosci` FOREIGN KEY (`ulice_miejscowosci_id`) REFERENCES `ulice_miejscowosci` (`ulice_miejscowosci_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Eksport danych został odznaczony.

-- Zrzut struktury widok dziennik szkolny.adres_info_lista
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `adres_info_lista` (
	`adres_ID` INT(3) UNSIGNED ZEROFILL NOT NULL,
	`miejscowosc` VARCHAR(30) NOT NULL COLLATE 'ucs2_polish_ci',
	`kod` INT(5) UNSIGNED NOT NULL,
	`ulica` VARCHAR(30) NOT NULL COLLATE 'ucs2_polish_ci',
	`nr_domu` VARCHAR(6) NOT NULL COLLATE 'ucs2_polish_ci',
	`nr_mieszkania` VARCHAR(4) NULL COLLATE 'ucs2_polish_ci'
) ENGINE=MyISAM;

-- Zrzut struktury tabela dziennik szkolny.czas_lekcji
CREATE TABLE IF NOT EXISTS `czas_lekcji` (
  `czas_lekcji_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL DEFAULT '0000-00-00',
  `godz_start` time NOT NULL DEFAULT '00:00:00',
  `godz_koniec` time NOT NULL DEFAULT '00:00:00',
  PRIMARY KEY (`czas_lekcji_ID`),
  UNIQUE KEY `ID` (`czas_lekcji_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Eksport danych został odznaczony.

-- Zrzut struktury procedura dziennik szkolny.dzieci_rodzica
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dzieci_rodzica`(
	IN `rodzic_id` INT


)
select ulst.imie, ulst.nazwisko, ulst.klasa_id
from rodzic as r
join uczen_info_lista as ulst on rodzic.opiekunowie_id = ulst.opiekunowie_id
where rodzic.rodzic_ID = rodzic_id//
DELIMITER ;

-- Zrzut struktury procedura dziennik szkolny.frekwencja_na_lekcji
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `frekwencja_na_lekcji`(
	IN `lekcja_id` INT


)
select u.imie, u.nazwisko, o.`status`
from obecnosc as o
join lekcja as l on o.lekcja_id = l.lekcja_ID
join uczen_info_lista as u on o.uczen_id = u.uczen_ID
where l.lekcja_ID = lekcja_id
order by u.nazwisko//
DELIMITER ;

-- Zrzut struktury procedura dziennik szkolny.frekwencja_ucznia
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `frekwencja_ucznia`(
	IN `uczen_id` INT



)
select l.`data`, l.godz_start, l.godz_koniec, l.sala, l.przedmiot, l.imie, l.nazwisko, l.temat, o.`status`
from lekcja_info_lista as l
join obecnosc as o on l.lekcja_ID = o.lekcja_id
where o.uczen_id = uczen_id
order by l.`data`//
DELIMITER ;

-- Zrzut struktury tabela dziennik szkolny.grupa_lekcji
CREATE TABLE IF NOT EXISTS `grupa_lekcji` (
  `grupa_lekcji_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `klasa_id` int(2) unsigned zerofill NOT NULL,
  `nauczyciel_przedmiot_id` int(3) unsigned zerofill NOT NULL,
  PRIMARY KEY (`grupa_lekcji_ID`),
  UNIQUE KEY `ID` (`grupa_lekcji_ID`),
  KEY `FK_grupa_lekcji_klasa` (`klasa_id`),
  KEY `FK_grupa_lekcji_nauczyciel_przedmiotu` (`nauczyciel_przedmiot_id`),
  CONSTRAINT `FK_grupa_lekcji_klasa` FOREIGN KEY (`klasa_id`) REFERENCES `klasa` (`klasa_ID`),
  CONSTRAINT `FK_grupa_lekcji_nauczyciel_przedmiotu` FOREIGN KEY (`nauczyciel_przedmiot_id`) REFERENCES `nauczyciel_przedmiotu` (`nauczyciel_przedmiotu_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Eksport danych został odznaczony.

-- Zrzut struktury tabela dziennik szkolny.klasa
CREATE TABLE IF NOT EXISTS `klasa` (
  `klasa_ID` int(2) unsigned zerofill NOT NULL,
  `oddzial` varchar(3) COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`klasa_ID`),
  UNIQUE KEY `ID` (`klasa_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Eksport danych został odznaczony.

-- Zrzut struktury tabela dziennik szkolny.lekcja
CREATE TABLE IF NOT EXISTS `lekcja` (
  `lekcja_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `temat` varchar(250) COLLATE ucs2_polish_ci NOT NULL,
  `sala` int(2) unsigned NOT NULL,
  `grupa_lekcji_id` int(3) unsigned zerofill NOT NULL,
  `czas_lekcji_id` int(5) unsigned zerofill NOT NULL,
  PRIMARY KEY (`lekcja_ID`),
  UNIQUE KEY `lekcja_id` (`lekcja_ID`) USING BTREE,
  KEY `FK_lekcja_grupa_lekcji` (`grupa_lekcji_id`),
  KEY `FK_lekcja_czas_lekcji` (`czas_lekcji_id`),
  CONSTRAINT `FK_lekcja_czas_lekcji` FOREIGN KEY (`czas_lekcji_id`) REFERENCES `czaslekcji` (`czaslekcji_ID`),
  CONSTRAINT `FK_lekcja_grupa_lekcji` FOREIGN KEY (`grupa_lekcji_id`) REFERENCES `grupa_lekcji` (`grupa_lekcji_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Eksport danych został odznaczony.

-- Zrzut struktury widok dziennik szkolny.lekcja_info_lista
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `lekcja_info_lista` (
	`lekcja_ID` INT(5) UNSIGNED ZEROFILL NOT NULL,
	`data` DATE NOT NULL,
	`godz_start` TIME NOT NULL,
	`godz_koniec` TIME NOT NULL,
	`oddzial` VARCHAR(3) NOT NULL COLLATE 'ucs2_polish_ci',
	`sala` INT(2) UNSIGNED NOT NULL,
	`przedmiot` VARCHAR(32) NULL COLLATE 'ucs2_polish_ci',
	`imie` VARCHAR(20) NOT NULL COLLATE 'ucs2_polish_ci',
	`nazwisko` VARCHAR(30) NOT NULL COLLATE 'ucs2_polish_ci',
	`temat` VARCHAR(250) NOT NULL COLLATE 'ucs2_polish_ci',
	`nauczyciel_id` INT(2) UNSIGNED ZEROFILL NOT NULL
) ENGINE=MyISAM;

-- Zrzut struktury procedura dziennik szkolny.lekcje_nauczyciela
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `lekcje_nauczyciela`(
	IN `nauczyciel_id` INT





)
select l.`data`, l.godz_start, l.godz_koniec, l.oddzial,l.sala,l.przedmiot
from nauczyciel_info_lista as n
join lekcja_info_lista as l on n.ID = l.nauczyciel_id and `l`.`przedmiot` = `n`.`przedmiot`
where n.ID = nauczyciel_id//
DELIMITER ;

-- Zrzut struktury procedura dziennik szkolny.lista_osob_w_klasie
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_osob_w_klasie`(
	IN `klasa_id` INT
)
SELECT uzytkownik.imie AS 'imie', uzytkownik.nazwisko AS 'nazwisko', k.oddzial
FROM uczen as u
INNER JOIN klasa as k ON u.klasa_id = k.klasa_ID 
left JOIN uzytkownik ON u.uzytkownik_login = uzytkownik.uzytkownik_login
where k.klasa_ID =klasa_id
ORDER BY nazwisko ASC//
DELIMITER ;

-- Zrzut struktury tabela dziennik szkolny.miejscowosc
CREATE TABLE IF NOT EXISTS `miejscowosc` (
  `miejscowosc_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(30) COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`miejscowosc_ID`),
  UNIQUE KEY `ID` (`miejscowosc_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Eksport danych został odznaczony.

-- Zrzut struktury tabela dziennik szkolny.nauczyciel
CREATE TABLE IF NOT EXISTS `nauczyciel` (
  `nauczyciel_ID` int(2) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `uzytkownik_login` varchar(16) COLLATE ucs2_polish_ci NOT NULL,
  `nr_tel` char(50) COLLATE ucs2_polish_ci NOT NULL,
  `czy_wych` enum('Y','N') COLLATE ucs2_polish_ci NOT NULL DEFAULT 'N',
  PRIMARY KEY (`nauczyciel_ID`),
  UNIQUE KEY `ID` (`nauczyciel_ID`),
  UNIQUE KEY `uzytkownik_login` (`uzytkownik_login`),
  CONSTRAINT `FK_nauczyciel_uzytkownik_2` FOREIGN KEY (`uzytkownik_login`) REFERENCES `uzytkownik` (`uzytkownik_login`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Eksport danych został odznaczony.

-- Zrzut struktury procedura dziennik szkolny.nauczyciele_przedmiotu
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `nauczyciele_przedmiotu`(
	IN `przedmiot_nazwa` VARCHAR(32)







)
select np.przedmiot_nazwa, nlst.imie, nlst.nazwisko, nlst.nr_tel, nlst.email
from nauczyciel_przedmiotu as np
join nauczyciel_info_lista as nlst on np.nauczyciel_id = nlst.ID and np.przedmiot_nazwa = nlst.przedmiot
where np.przedmiot_nazwa = przedmiot_nazwa//
DELIMITER ;

-- Zrzut struktury widok dziennik szkolny.nauczyciel_info_lista
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `nauczyciel_info_lista` (
	`ID` INT(2) UNSIGNED ZEROFILL NOT NULL,
	`nazwisko` VARCHAR(30) NOT NULL COLLATE 'ucs2_polish_ci',
	`imie` VARCHAR(20) NOT NULL COLLATE 'ucs2_polish_ci',
	`nr_tel` CHAR(50) NOT NULL COLLATE 'ucs2_polish_ci',
	`email` VARCHAR(32) NULL COLLATE 'ucs2_polish_ci',
	`przedmiot` VARCHAR(32) NULL COLLATE 'ucs2_polish_ci',
	`nauczyciel_przedmiotu_ID` INT(3) UNSIGNED ZEROFILL NOT NULL
) ENGINE=MyISAM;

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

-- Eksport danych został odznaczony.

-- Zrzut struktury tabela dziennik szkolny.obecnosc
CREATE TABLE IF NOT EXISTS `obecnosc` (
  `obecnosc_ID` int(7) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `status` enum('obecny','nieobecny','spóźniony') COLLATE ucs2_polish_ci NOT NULL DEFAULT 'obecny',
  `uczen_id` int(3) unsigned zerofill NOT NULL,
  `lekcja_id` int(5) unsigned zerofill NOT NULL,
  PRIMARY KEY (`obecnosc_ID`),
  UNIQUE KEY `obecność_id` (`obecnosc_ID`) USING BTREE,
  KEY `uczen` (`uczen_id`),
  KEY `lekcja` (`lekcja_id`),
  CONSTRAINT `FK_obecnosc_lekcja` FOREIGN KEY (`lekcja_id`) REFERENCES `lekcja` (`lekcja_ID`),
  CONSTRAINT `FK_obecnosc_uczen` FOREIGN KEY (`uczen_id`) REFERENCES `uczen` (`uczen_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Eksport danych został odznaczony.

-- Zrzut struktury tabela dziennik szkolny.ocena
CREATE TABLE IF NOT EXISTS `ocena` (
  `ocena_ID` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `stopien` enum('brak','ndst','dop','dst','db','bdb','cel') COLLATE utf8_polish_ci NOT NULL,
  `waga` int(1) unsigned NOT NULL DEFAULT 1,
  `opis` varchar(100) COLLATE utf8_polish_ci NOT NULL DEFAULT '',
  `data` date NOT NULL,
  `uczen_id` int(3) unsigned zerofill NOT NULL,
  `nauczyciel_przedmiotu_id` int(3) unsigned zerofill NOT NULL,
  PRIMARY KEY (`ocena_ID`),
  UNIQUE KEY `Indeks 1` (`ocena_ID`) USING BTREE,
  KEY `nauczyciel` (`nauczyciel_przedmiotu_id`),
  KEY `uczen` (`uczen_id`),
  CONSTRAINT `FK_ocena_nauczyciel_przedmiotu` FOREIGN KEY (`nauczyciel_przedmiotu_id`) REFERENCES `nauczyciel_przedmiotu` (`nauczyciel_przedmiotu_ID`),
  CONSTRAINT `FK_ocena_uczen` FOREIGN KEY (`uczen_id`) REFERENCES `uczen` (`uczen_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Eksport danych został odznaczony.

-- Zrzut struktury widok dziennik szkolny.ocena_info_lista
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `ocena_info_lista` (
	`ocena_ID` INT(6) UNSIGNED ZEROFILL NOT NULL,
	`stopien` ENUM('brak','ndst','dop','dst','db','bdb','cel') NOT NULL COLLATE 'utf8_polish_ci',
	`waga` INT(1) UNSIGNED NOT NULL,
	`opis` VARCHAR(100) NOT NULL COLLATE 'utf8_polish_ci',
	`data` DATE NOT NULL,
	`uczen_id` INT(3) UNSIGNED ZEROFILL NOT NULL,
	`imie` VARCHAR(20) NOT NULL COLLATE 'ucs2_polish_ci',
	`nazwisko` VARCHAR(30) NOT NULL COLLATE 'ucs2_polish_ci',
	`przedmiot` VARCHAR(32) NULL COLLATE 'ucs2_polish_ci'
) ENGINE=MyISAM;

-- Zrzut struktury procedura dziennik szkolny.oceny_ucznia
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `oceny_ucznia`(
	IN `uczen_id` INT


)
select * 
from ocena_info_lista as o
where o.uczen_id = uczen_id//
DELIMITER ;

-- Zrzut struktury tabela dziennik szkolny.opiekunowie
CREATE TABLE IF NOT EXISTS `opiekunowie` (
  `opiekunowie_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`opiekunowie_ID`),
  UNIQUE KEY `ID` (`opiekunowie_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Eksport danych został odznaczony.

-- Zrzut struktury procedura dziennik szkolny.plan_lekcji_klasy
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `plan_lekcji_klasy`(
	IN `klasa_id` INT



)
select *
from lekcja_info_lista as l
join klasa as k on l.oddzial = k.oddzial
where k.klasa_ID = klasa_id//
DELIMITER ;

-- Zrzut struktury tabela dziennik szkolny.przedmiot
CREATE TABLE IF NOT EXISTS `przedmiot` (
  `przedmiot_nazwa` varchar(32) COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`przedmiot_nazwa`),
  UNIQUE KEY `przedmiot_nazwa` (`przedmiot_nazwa`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Eksport danych został odznaczony.

-- Zrzut struktury tabela dziennik szkolny.rodzic
CREATE TABLE IF NOT EXISTS `rodzic` (
  `rodzic_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `uzytkownik_login` varchar(16) COLLATE ucs2_polish_ci NOT NULL,
  `nr_telefonu` varchar(12) COLLATE ucs2_polish_ci DEFAULT NULL,
  `opiekunowie_id` int(3) unsigned zerofill NOT NULL,
  PRIMARY KEY (`rodzic_ID`),
  UNIQUE KEY `ID` (`rodzic_ID`),
  UNIQUE KEY `uzytkownik_login` (`uzytkownik_login`),
  KEY `powiazanie` (`opiekunowie_id`),
  CONSTRAINT `FK_rodzic_powiazanie` FOREIGN KEY (`opiekunowie_id`) REFERENCES `opiekunowie` (`opiekunowie_ID`),
  CONSTRAINT `FK_rodzic_uzytkownik` FOREIGN KEY (`uzytkownik_login`) REFERENCES `uzytkownik` (`uzytkownik_login`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Eksport danych został odznaczony.

-- Zrzut struktury procedura dziennik szkolny.rodzice_ucznia
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `rodzice_ucznia`(
	IN `uczen_id` INT




)
select rlst.imie, rlst.nazwisko, rlst.email, rlst.nr_telefonu
from opiekunowie
join uczen on opiekunowie.opiekunowie_ID = uczen.opiekunowie_id
join rodzic_info_lista as rlst on opiekunowie.opiekunowie_ID = rlst.opiekunowie_id
where uczen.uczen_ID = uczen_id//
DELIMITER ;

-- Zrzut struktury procedura dziennik szkolny.rodzice_w_klasie
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `rodzice_w_klasie`(
	IN `klasa_id` INT


)
select rlst.imie, rlst.nazwisko, rlst.email, rlst.nr_telefonu
from uczen_info_lista as ui
join rodzic_info_lista as rlst on ui.opiekunowie_id = rlst.opiekunowie_id
where ui.klasa_id = klasa_id//
DELIMITER ;

-- Zrzut struktury procedura dziennik szkolny.rodzic_info
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `rodzic_info`(
	IN `rodzic_id` INT

)
select rlst.imie, rlst.nazwisko, rlst.email, rlst.nr_telefonu
from rodzic_info_lista as rlst
where rlst.rodzic_ID  = rodzic_id//
DELIMITER ;

-- Zrzut struktury widok dziennik szkolny.rodzic_info_lista
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `rodzic_info_lista` (
	`rodzic_ID` INT(3) UNSIGNED ZEROFILL NOT NULL,
	`nr_telefonu` VARCHAR(12) NULL COLLATE 'ucs2_polish_ci',
	`imie` VARCHAR(20) NULL COLLATE 'ucs2_polish_ci',
	`nazwisko` VARCHAR(30) NULL COLLATE 'ucs2_polish_ci',
	`email` VARCHAR(32) NULL COLLATE 'ucs2_polish_ci',
	`opiekunowie_id` INT(3) UNSIGNED ZEROFILL NOT NULL
) ENGINE=MyISAM;

-- Zrzut struktury widok dziennik szkolny.rodzic_info_lista1
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `rodzic_info_lista1` (
	`rodzic_ID` INT(3) UNSIGNED ZEROFILL NOT NULL,
	`nr_telefonu` VARCHAR(12) NULL COLLATE 'ucs2_polish_ci',
	`imie` VARCHAR(20) NULL COLLATE 'ucs2_polish_ci',
	`nazwisko` VARCHAR(30) NULL COLLATE 'ucs2_polish_ci',
	`email` VARCHAR(32) NULL COLLATE 'ucs2_polish_ci',
	`opiekunowie_id` INT(3) UNSIGNED ZEROFILL NOT NULL
) ENGINE=MyISAM;

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

-- Eksport danych został odznaczony.

-- Zrzut struktury procedura dziennik szkolny.uczen_info
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `uczen_info`(
	IN `uczen_id` INT

)
select * 
from uczen_info_lista
where uczen_info_lista.uczen_ID = uczen_id//
DELIMITER ;

-- Zrzut struktury widok dziennik szkolny.uczen_info_lista
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `uczen_info_lista` (
	`uczen_ID` INT(3) UNSIGNED ZEROFILL NOT NULL,
	`oddzial` VARCHAR(3) NOT NULL COLLATE 'ucs2_polish_ci',
	`imie` VARCHAR(20) NOT NULL COLLATE 'ucs2_polish_ci',
	`nazwisko` VARCHAR(30) NOT NULL COLLATE 'ucs2_polish_ci',
	`pesel` CHAR(11) NOT NULL COLLATE 'latin1_swedish_ci',
	`email` VARCHAR(32) NULL COLLATE 'ucs2_polish_ci',
	`miejscowosc` VARCHAR(30) NOT NULL COLLATE 'ucs2_polish_ci',
	`kod` INT(5) UNSIGNED NOT NULL,
	`ulica` VARCHAR(30) NOT NULL COLLATE 'ucs2_polish_ci',
	`nr_domu` VARCHAR(6) NOT NULL COLLATE 'ucs2_polish_ci',
	`nr_mieszkania` VARCHAR(4) NULL COLLATE 'ucs2_polish_ci'
) ENGINE=MyISAM;

-- Zrzut struktury tabela dziennik szkolny.ulica
CREATE TABLE IF NOT EXISTS `ulica` (
  `ulica_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(30) COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`ulica_ID`),
  UNIQUE KEY `ID` (`ulica_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Eksport danych został odznaczony.

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

-- Eksport danych został odznaczony.

-- Zrzut struktury tabela dziennik szkolny.uzytkownik
CREATE TABLE IF NOT EXISTS `uzytkownik` (
  `uzytkownik_login` varchar(16) CHARACTER SET ucs2 COLLATE ucs2_polish_ci NOT NULL,
  `nazwisko` varchar(30) CHARACTER SET ucs2 COLLATE ucs2_polish_ci NOT NULL,
  `imie` varchar(20) CHARACTER SET ucs2 COLLATE ucs2_polish_ci NOT NULL,
  `haslo` char(32) CHARACTER SET ucs2 COLLATE ucs2_polish_ci NOT NULL,
  `str` char(32) COLLATE utf8_polish_ci DEFAULT 'safsdf',
  `rodzaj` enum('U','N','R','I','A') CHARACTER SET ucs2 COLLATE ucs2_polish_ci DEFAULT 'I',
  `email` varchar(32) CHARACTER SET ucs2 COLLATE ucs2_polish_ci DEFAULT NULL,
  PRIMARY KEY (`uzytkownik_login`),
  UNIQUE KEY `login` (`uzytkownik_login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Eksport danych został odznaczony.

-- Zrzut struktury tabela dziennik szkolny.wersja
CREATE TABLE IF NOT EXISTS `wersja` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `major` int(10) unsigned DEFAULT 0,
  `minor` int(10) unsigned DEFAULT 0,
  `data` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Eksport danych został odznaczony.

-- Zrzut struktury procedura dziennik szkolny.zmiana_hasla
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `zmiana_hasla`(
	IN `uzytkownik_login` VARCHAR(16)
,
	IN `new_haslo` CHAR(32)



,
	IN `old_haslo` CHAR(32)
)
update uzytkownik 
set uzytkownik.haslo = new_haslo 
where uzytkownik.uzytkownik_login = uzytkownik_login//
DELIMITER ;

-- Zrzut struktury procedura dziennik szkolny.zmiana_hasla_admin
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `zmiana_hasla_admin`(
	IN `new_haslo` CHAR(32),
	IN `uzytkownik_login` VARCHAR(16)
)
update uzytkownik 
set uzytkownik.haslo = new_haslo 
where uzytkownik.uzytkownik_login = uzytkownik_login//
DELIMITER ;

-- Zrzut struktury procedura dziennik szkolny.zmiana_obecnosci_ucznia
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `zmiana_obecnosci_ucznia`(
	IN `uczen_id` INT,
	IN `lekcja_id` INT,
	IN `new_status` ENUM('obecny','nieobecny','spóźniony')

)
update obecnosc set obecnosc.`status` = new_status where obecnosc.uczen = uczen_id and obecnosc.lekcja = lekcja_id//
DELIMITER ;

-- Zrzut struktury procedura dziennik szkolny.zmiana_tematu_lekcji
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `zmiana_tematu_lekcji`(
	IN `lekcja_id` INT,
	IN `new_temat` VARCHAR(250)
)
update lekcja set lekcja.temat = new_temat where lekcja.ID = lekcja_id//
DELIMITER ;

-- Zrzut struktury widok dziennik szkolny.adres_info_lista
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `adres_info_lista`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dziennik szkolny`.`adres_info_lista` AS select `dziennik szkolny`.`adres`.`adres_ID` AS `adres_ID`,`dziennik szkolny`.`miejscowosc`.`nazwa` AS `miejscowosc`,`um`.`kod` AS `kod`,`dziennik szkolny`.`ulica`.`nazwa` AS `ulica`,`dziennik szkolny`.`adres`.`nr_domu` AS `nr_domu`,`dziennik szkolny`.`adres`.`nr_mieszkania` AS `nr_mieszkania` from (((`dziennik szkolny`.`ulice_miejscowosci` `um` join `dziennik szkolny`.`ulica` on(`um`.`ulica_id` = `dziennik szkolny`.`ulica`.`ulica_ID`)) join `dziennik szkolny`.`miejscowosc` on(`um`.`miejscowosc_id` = `dziennik szkolny`.`miejscowosc`.`miejscowosc_ID`)) join `dziennik szkolny`.`adres` on(`dziennik szkolny`.`adres`.`ulice_miejscowosci_id` = `um`.`ulice_miejscowosci_ID`));

-- Zrzut struktury widok dziennik szkolny.lekcja_info_lista
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `lekcja_info_lista`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dziennik szkolny`.`lekcja_info_lista` AS select `l`.`lekcja_ID` AS `lekcja_ID`,`c`.`data` AS `data`,`c`.`godz_start` AS `godz_start`,`c`.`godz_koniec` AS `godz_koniec`,`o`.`oddzial` AS `oddzial`,`l`.`sala` AS `sala`,`o`.`przedmiot` AS `przedmiot`,`o`.`imie` AS `imie`,`o`.`nazwisko` AS `nazwisko`,`l`.`temat` AS `temat`,`o`.`ID` AS `nauczyciel_id` from ((`dziennik szkolny`.`lekcja` `l` join `dziennik szkolny`.`czas_lekcji` `c` on(`l`.`czas_lekcji_id` = `c`.`czas_lekcji_ID`)) join (select `gr`.`grupa_lekcji_ID` AS `grupa_lekcji_ID`,`k`.`oddzial` AS `oddzial`,`nlst`.`imie` AS `imie`,`nlst`.`nazwisko` AS `nazwisko`,`nlst`.`przedmiot` AS `przedmiot`,`nlst`.`ID` AS `ID` from ((`dziennik szkolny`.`grupa_lekcji` `gr` join `dziennik szkolny`.`nauczyciel_info_lista` `nlst` on(`gr`.`nauczyciel_przedmiot_id` = `nlst`.`nauczyciel_przedmiotu_ID`)) join `dziennik szkolny`.`klasa` `k` on(`gr`.`klasa_id` = `k`.`klasa_ID`))) `o` on(`l`.`grupa_lekcji_id` = `o`.`grupa_lekcji_ID`));

-- Zrzut struktury widok dziennik szkolny.nauczyciel_info_lista
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `nauczyciel_info_lista`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dziennik szkolny`.`nauczyciel_info_lista` AS select `dziennik szkolny`.`nauczyciel`.`nauczyciel_ID` AS `ID`,`dziennik szkolny`.`uzytkownik`.`nazwisko` AS `nazwisko`,`dziennik szkolny`.`uzytkownik`.`imie` AS `imie`,`dziennik szkolny`.`nauczyciel`.`nr_tel` AS `nr_tel`,`dziennik szkolny`.`uzytkownik`.`email` AS `email`,`dziennik szkolny`.`nauczyciel_przedmiotu`.`przedmiot_nazwa` AS `przedmiot`,`dziennik szkolny`.`nauczyciel_przedmiotu`.`nauczyciel_przedmiotu_ID` AS `nauczyciel_przedmiotu_ID` from ((`dziennik szkolny`.`nauczyciel` join `dziennik szkolny`.`uzytkownik` on(`dziennik szkolny`.`nauczyciel`.`uzytkownik_login` = `dziennik szkolny`.`uzytkownik`.`uzytkownik_login`)) join `dziennik szkolny`.`nauczyciel_przedmiotu` on(`dziennik szkolny`.`nauczyciel`.`nauczyciel_ID` = `dziennik szkolny`.`nauczyciel_przedmiotu`.`nauczyciel_id`));

-- Zrzut struktury widok dziennik szkolny.ocena_info_lista
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `ocena_info_lista`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dziennik szkolny`.`ocena_info_lista` AS select `dziennik szkolny`.`ocena`.`ocena_ID` AS `ocena_ID`,`dziennik szkolny`.`ocena`.`stopien` AS `stopien`,`dziennik szkolny`.`ocena`.`waga` AS `waga`,`dziennik szkolny`.`ocena`.`opis` AS `opis`,`dziennik szkolny`.`ocena`.`data` AS `data`,`dziennik szkolny`.`ocena`.`uczen_id` AS `uczen_id`,`n`.`imie` AS `imie`,`n`.`nazwisko` AS `nazwisko`,`n`.`przedmiot` AS `przedmiot` from (`dziennik szkolny`.`ocena` join `dziennik szkolny`.`nauczyciel_info_lista` `n` on(`dziennik szkolny`.`ocena`.`nauczyciel_przedmiotu_id` = `n`.`nauczyciel_przedmiotu_ID`));

-- Zrzut struktury widok dziennik szkolny.rodzic_info_lista
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `rodzic_info_lista`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dziennik szkolny`.`rodzic_info_lista` AS select `r`.`rodzic_ID` AS `rodzic_ID`,`r`.`nr_telefonu` AS `nr_telefonu`,`u`.`imie` AS `imie`,`u`.`nazwisko` AS `nazwisko`,`u`.`email` AS `email`,`r`.`opiekunowie_id` AS `opiekunowie_id` from (`dziennik szkolny`.`rodzic` `r` left join `dziennik szkolny`.`uzytkownik` `u` on(`r`.`uzytkownik_login` = `u`.`uzytkownik_login`));

-- Zrzut struktury widok dziennik szkolny.rodzic_info_lista1
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `rodzic_info_lista1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dziennik szkolny`.`rodzic_info_lista1` AS select `r`.`rodzic_ID` AS `rodzic_ID`,`r`.`nr_telefonu` AS `nr_telefonu`,`u`.`imie` AS `imie`,`u`.`nazwisko` AS `nazwisko`,`u`.`email` AS `email`,`r`.`opiekunowie_id` AS `opiekunowie_id` from (`dziennik szkolny`.`rodzic` `r` left join `dziennik szkolny`.`uzytkownik` `u` on(`r`.`uzytkownik_login` = `u`.`uzytkownik_login`));

-- Zrzut struktury widok dziennik szkolny.uczen_info_lista
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `uczen_info_lista`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dziennik szkolny`.`uczen_info_lista` AS select `ucz`.`uczen_ID` AS `uczen_ID`,`k`.`oddzial` AS `oddzial`,`u`.`imie` AS `imie`,`u`.`nazwisko` AS `nazwisko`,`ucz`.`pesel` AS `pesel`,`u`.`email` AS `email`,`a`.`miejscowosc` AS `miejscowosc`,`a`.`kod` AS `kod`,`a`.`ulica` AS `ulica`,`a`.`nr_domu` AS `nr_domu`,`a`.`nr_mieszkania` AS `nr_mieszkania` from (((`dziennik szkolny`.`uczen` `ucz` join `dziennik szkolny`.`uzytkownik` `u` on(`ucz`.`uzytkownik_login` = `u`.`uzytkownik_login`)) join `dziennik szkolny`.`adres_info_lista` `a` on(`ucz`.`adres_id` = `a`.`adres_ID`)) join `dziennik szkolny`.`klasa` `k` on(`ucz`.`klasa_id` = `k`.`klasa_ID`));

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
