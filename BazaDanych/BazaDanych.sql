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

-- Zrzut struktury tabela id13767441_dziennik.adres
CREATE TABLE IF NOT EXISTS `adres` (
  `adres_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `ulice_miejscowosci_id` int(6) unsigned zerofill NOT NULL,
  `nr_domu` varchar(6) COLLATE utf8_polish_ci NOT NULL,
  `nr_mieszkania` varchar(4) COLLATE utf8_polish_ci DEFAULT NULL,
  PRIMARY KEY (`adres_ID`),
  UNIQUE KEY `ID` (`adres_ID`),
  KEY `FK_adres_ulice_miejscowosci` (`ulice_miejscowosci_id`),
  CONSTRAINT `FK_adres_ulice_miejscowosci` FOREIGN KEY (`ulice_miejscowosci_id`) REFERENCES `ulice_miejscowosci` (`ulice_miejscowosci_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Zrzucanie danych dla tabeli id13767441_dziennik.adres: ~11 rows (około)
/*!40000 ALTER TABLE `adres` DISABLE KEYS */;
REPLACE INTO `adres` (`adres_ID`, `ulice_miejscowosci_id`, `nr_domu`, `nr_mieszkania`) VALUES
	(001, 000006, '23', '12'),
	(002, 000005, '1', '123'),
	(003, 000012, '23', '3'),
	(004, 000006, '23', '33'),
	(005, 000014, '23', '12'),
	(006, 000001, '23', ''),
	(007, 000004, '1', '12'),
	(008, 000014, '23', '12'),
	(009, 000002, '1', '2'),
	(010, 000013, '23', '12'),
	(011, 000012, '23', '19');
/*!40000 ALTER TABLE `adres` ENABLE KEYS */;

-- Zrzut struktury widok id13767441_dziennik.adres_info_lista
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `adres_info_lista` (
	`adres_ID` INT(3) UNSIGNED ZEROFILL NOT NULL,
	`miejscowosc` VARCHAR(30) NOT NULL COLLATE 'utf8_polish_ci',
	`kod` INT(5) UNSIGNED NOT NULL,
	`ulica` VARCHAR(30) NOT NULL COLLATE 'utf8_polish_ci',
	`nr_domu` VARCHAR(6) NOT NULL COLLATE 'utf8_polish_ci',
	`nr_mieszkania` VARCHAR(4) NULL COLLATE 'utf8_polish_ci'
) ENGINE=MyISAM;

-- Zrzut struktury tabela id13767441_dziennik.czas_lekcji
CREATE TABLE IF NOT EXISTS `czas_lekcji` (
  `czas_lekcji_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL DEFAULT '0000-00-00',
  `godz_start` time NOT NULL DEFAULT '00:00:00',
  `godz_koniec` time NOT NULL DEFAULT '00:00:00',
  PRIMARY KEY (`czas_lekcji_ID`),
  UNIQUE KEY `ID` (`czas_lekcji_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Zrzucanie danych dla tabeli id13767441_dziennik.czas_lekcji: ~5 rows (około)
/*!40000 ALTER TABLE `czas_lekcji` DISABLE KEYS */;
REPLACE INTO `czas_lekcji` (`czas_lekcji_ID`, `data`, `godz_start`, `godz_koniec`) VALUES
	(00001, '2020-05-08', '14:00:00', '14:45:00'),
	(00002, '2020-05-08', '15:00:00', '15:45:00'),
	(00003, '2020-05-09', '14:00:00', '14:45:00'),
	(00004, '2020-05-09', '15:00:00', '15:45:00'),
	(00005, '2020-05-10', '14:00:00', '14:45:00');
/*!40000 ALTER TABLE `czas_lekcji` ENABLE KEYS */;

-- Zrzut struktury procedura id13767441_dziennik.dodaj_ocene
DELIMITER //
CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `dodaj_ocene`(
	IN `stopien` ENUM('0','1','2','3','4','5','6'),
	IN `waga` INT,
	IN `opis` VARCHAR(100),
	IN `uczen_id` INT,
	IN `nauczyciel_przedmiotu_id` INT



)
INSERT INTO ocena (ocena.stopien, ocena.waga, ocena.opis, ocena.uczen_id, ocena.nauczyciel_przedmiotu_id) 
VALUES (stopien,waga,opis,uczen_id,nauczyciel_przedmiotu_id)//
DELIMITER ;

-- Zrzut struktury procedura id13767441_dziennik.dzieci_rodzica
DELIMITER //
CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `dzieci_rodzica`(
	IN `rodzic_id` INT








)
select u.imie, u.nazwisko, u.oddzial, u.uczen_ID
from rodzic as r
join uczen_info_lista as u on r.opiekunowie_id = u.opiekunowie_id
where r.rodzic_ID = rodzic_id//
DELIMITER ;

-- Zrzut struktury procedura id13767441_dziennik.frekwencja_na_lekcji
DELIMITER //
CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `frekwencja_na_lekcji`(
	IN `lekcja_id` INT




)
select u.imie, u.nazwisko, o.`status`
from obecnosc as o
join lekcja_info_lista as l on o.lekcja_id = l.lekcja_ID
join uczen_info_lista as u on o.uczen_id = u.uczen_ID
where l.lekcja_ID = lekcja_id
and l.oddzial = u.oddzial
order by u.nazwisko//
DELIMITER ;

-- Zrzut struktury procedura id13767441_dziennik.frekwencja_ucznia
DELIMITER //
CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `frekwencja_ucznia`(
	IN `uczen_id` INT




)
select l.`data`, l.godz_start, l.godz_koniec, l.sala, l.przedmiot, l.imie, l.nazwisko, l.temat, o.`status`
from lekcja_info_lista as l
join obecnosc as o on l.lekcja_ID = o.lekcja_id
where o.uczen_id = uczen_id
order by l.`data`//
DELIMITER ;

-- Zrzut struktury tabela id13767441_dziennik.grupa_lekcji
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Zrzucanie danych dla tabeli id13767441_dziennik.grupa_lekcji: ~3 rows (około)
/*!40000 ALTER TABLE `grupa_lekcji` DISABLE KEYS */;
REPLACE INTO `grupa_lekcji` (`grupa_lekcji_ID`, `klasa_id`, `nauczyciel_przedmiot_id`) VALUES
	(00001, 07, 001),
	(00002, 01, 003),
	(00003, 07, 002);
/*!40000 ALTER TABLE `grupa_lekcji` ENABLE KEYS */;

-- Zrzut struktury tabela id13767441_dziennik.klasa
CREATE TABLE IF NOT EXISTS `klasa` (
  `klasa_ID` int(2) unsigned zerofill NOT NULL,
  `oddzial` varchar(3) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`klasa_ID`),
  UNIQUE KEY `ID` (`klasa_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Zrzucanie danych dla tabeli id13767441_dziennik.klasa: ~16 rows (około)
/*!40000 ALTER TABLE `klasa` DISABLE KEYS */;
REPLACE INTO `klasa` (`klasa_ID`, `oddzial`) VALUES
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

-- Zrzut struktury tabela id13767441_dziennik.lekcja
CREATE TABLE IF NOT EXISTS `lekcja` (
  `lekcja_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `temat` varchar(250) COLLATE utf8_polish_ci NOT NULL,
  `sala` int(2) unsigned NOT NULL,
  `grupa_lekcji_id` int(3) unsigned zerofill NOT NULL,
  `czas_lekcji_id` int(5) unsigned zerofill NOT NULL,
  PRIMARY KEY (`lekcja_ID`),
  UNIQUE KEY `lekcja_id` (`lekcja_ID`) USING BTREE,
  KEY `FK_lekcja_grupa_lekcji` (`grupa_lekcji_id`),
  KEY `FK_lekcja_czas_lekcji` (`czas_lekcji_id`),
  CONSTRAINT `FK_lekcja_czas_lekcji` FOREIGN KEY (`czas_lekcji_id`) REFERENCES `czaslekcji` (`czaslekcji_ID`),
  CONSTRAINT `FK_lekcja_grupa_lekcji` FOREIGN KEY (`grupa_lekcji_id`) REFERENCES `grupa_lekcji` (`grupa_lekcji_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Zrzucanie danych dla tabeli id13767441_dziennik.lekcja: ~7 rows (około)
/*!40000 ALTER TABLE `lekcja` DISABLE KEYS */;
REPLACE INTO `lekcja` (`lekcja_ID`, `temat`, `sala`, `grupa_lekcji_id`, `czas_lekcji_id`) VALUES
	(00001, 'To jest nowy temat lekcji wywołany przez procedurę zmiana_tematu_lekcji', 12, 001, 00001),
	(00002, 'Temat', 12, 002, 00001),
	(00003, 'Temat', 12, 003, 00001),
	(00004, 'Temat', 12, 001, 00002),
	(00005, 'Temat', 12, 002, 00002),
	(00006, 'Temat', 12, 003, 00002),
	(00007, 'Procedury, widoki, wyzwalacze i indeksy', 12, 002, 00004);
/*!40000 ALTER TABLE `lekcja` ENABLE KEYS */;

-- Zrzut struktury widok id13767441_dziennik.lekcja_info_lista
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `lekcja_info_lista` (
	`lekcja_ID` INT(5) UNSIGNED ZEROFILL NOT NULL,
	`data` DATE NOT NULL,
	`godz_start` TIME NOT NULL,
	`godz_koniec` TIME NOT NULL,
	`oddzial` VARCHAR(3) NOT NULL COLLATE 'utf8_polish_ci',
	`sala` INT(2) UNSIGNED NOT NULL,
	`przedmiot` VARCHAR(32) NULL COLLATE 'utf8_polish_ci',
	`imie` VARCHAR(20) NOT NULL COLLATE 'utf8_polish_ci',
	`nazwisko` VARCHAR(30) NOT NULL COLLATE 'utf8_polish_ci',
	`temat` VARCHAR(250) NOT NULL COLLATE 'utf8_polish_ci',
	`nauczyciel_id` INT(2) UNSIGNED ZEROFILL NOT NULL
) ENGINE=MyISAM;

-- Zrzut struktury procedura id13767441_dziennik.lekcje_nauczyciela
DELIMITER //
CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `lekcje_nauczyciela`(
	IN `nauczyciel_id` INT






)
select l.`data`, l.godz_start, l.godz_koniec, l.oddzial,l.sala,l.przedmiot
from nauczyciel_info_lista as n
join lekcja_info_lista as l on n.ID = l.nauczyciel_id and `l`.`przedmiot` = `n`.`przedmiot`
where n.ID = nauczyciel_id//
DELIMITER ;

-- Zrzut struktury procedura id13767441_dziennik.lista_osob_w_klasie
DELIMITER //
CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `lista_osob_w_klasie`(
	IN `klasa_id` INT

)
SELECT uzytkownik.imie AS 'imie', uzytkownik.nazwisko AS 'nazwisko', k.oddzial
FROM uczen as u
INNER JOIN klasa as k ON u.klasa_id = k.klasa_ID 
left JOIN uzytkownik ON u.uzytkownik_login = uzytkownik.uzytkownik_login
where k.klasa_ID =klasa_id
ORDER BY nazwisko ASC//
DELIMITER ;

-- Zrzut struktury tabela id13767441_dziennik.miejscowosc
CREATE TABLE IF NOT EXISTS `miejscowosc` (
  `miejscowosc_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(30) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`miejscowosc_ID`),
  UNIQUE KEY `ID` (`miejscowosc_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Zrzucanie danych dla tabeli id13767441_dziennik.miejscowosc: ~6 rows (około)
/*!40000 ALTER TABLE `miejscowosc` DISABLE KEYS */;
REPLACE INTO `miejscowosc` (`miejscowosc_ID`, `nazwa`) VALUES
	(001, 'Wrocław'),
	(002, 'Oborniki Śląskie'),
	(003, 'Oława'),
	(004, 'Kamieniec Wrocławski'),
	(005, 'Oleśnica'),
	(006, 'Trzebnica');
/*!40000 ALTER TABLE `miejscowosc` ENABLE KEYS */;

-- Zrzut struktury tabela id13767441_dziennik.nauczyciel
CREATE TABLE IF NOT EXISTS `nauczyciel` (
  `nauczyciel_ID` int(2) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `uzytkownik_login` varchar(16) COLLATE utf8_polish_ci NOT NULL,
  `nr_tel` char(50) COLLATE utf8_polish_ci NOT NULL,
  `czy_wych` enum('Y','N') COLLATE utf8_polish_ci NOT NULL DEFAULT 'N',
  PRIMARY KEY (`nauczyciel_ID`),
  UNIQUE KEY `ID` (`nauczyciel_ID`),
  UNIQUE KEY `uzytkownik_login` (`uzytkownik_login`),
  CONSTRAINT `FK_nauczyciel_uzytkownik_2` FOREIGN KEY (`uzytkownik_login`) REFERENCES `uzytkownik` (`uzytkownik_login`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Zrzucanie danych dla tabeli id13767441_dziennik.nauczyciel: ~2 rows (około)
/*!40000 ALTER TABLE `nauczyciel` DISABLE KEYS */;
REPLACE INTO `nauczyciel` (`nauczyciel_ID`, `uzytkownik_login`, `nr_tel`, `czy_wych`) VALUES
	(01, 'N0001', '111111111', 'N'),
	(02, 'N0002', '111111111', 'N');
/*!40000 ALTER TABLE `nauczyciel` ENABLE KEYS */;

-- Zrzut struktury procedura id13767441_dziennik.nauczyciele_przedmiotu
DELIMITER //
CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `nauczyciele_przedmiotu`(
	IN `przedmiot_nazwa` VARCHAR(32)








)
select np.przedmiot_nazwa, nlst.imie, nlst.nazwisko, nlst.nr_tel, nlst.email
from nauczyciel_przedmiotu as np
join nauczyciel_info_lista as nlst on np.nauczyciel_id = nlst.ID and np.przedmiot_nazwa = nlst.przedmiot
where np.przedmiot_nazwa = przedmiot_nazwa//
DELIMITER ;

-- Zrzut struktury widok id13767441_dziennik.nauczyciel_info_lista
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `nauczyciel_info_lista` (
	`ID` INT(2) UNSIGNED ZEROFILL NOT NULL,
	`nazwisko` VARCHAR(30) NOT NULL COLLATE 'utf8_polish_ci',
	`imie` VARCHAR(20) NOT NULL COLLATE 'utf8_polish_ci',
	`nr_tel` CHAR(50) NOT NULL COLLATE 'utf8_polish_ci',
	`email` VARCHAR(32) NULL COLLATE 'utf8_polish_ci',
	`przedmiot` VARCHAR(32) NULL COLLATE 'utf8_polish_ci',
	`nauczyciel_przedmiotu_ID` INT(3) UNSIGNED ZEROFILL NOT NULL
) ENGINE=MyISAM;

-- Zrzut struktury tabela id13767441_dziennik.nauczyciel_przedmiotu
CREATE TABLE IF NOT EXISTS `nauczyciel_przedmiotu` (
  `nauczyciel_przedmiotu_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `nauczyciel_id` int(2) unsigned zerofill NOT NULL,
  `przedmiot_nazwa` varchar(32) COLLATE utf8_polish_ci DEFAULT NULL,
  PRIMARY KEY (`nauczyciel_przedmiotu_ID`),
  UNIQUE KEY `ID` (`nauczyciel_przedmiotu_ID`),
  KEY `FK_nauczyciel_przedmiotu_przedmiot` (`przedmiot_nazwa`),
  KEY `FK_nauczyciel_przedmiotu_nauczyciel` (`nauczyciel_id`),
  CONSTRAINT `FK_nauczyciel_przedmiotu_nauczyciel` FOREIGN KEY (`nauczyciel_id`) REFERENCES `nauczyciel` (`nauczyciel_ID`),
  CONSTRAINT `FK_nauczyciel_przedmiotu_przedmiot` FOREIGN KEY (`przedmiot_nazwa`) REFERENCES `przedmiot` (`przedmiot_nazwa`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Zrzucanie danych dla tabeli id13767441_dziennik.nauczyciel_przedmiotu: ~3 rows (około)
/*!40000 ALTER TABLE `nauczyciel_przedmiotu` DISABLE KEYS */;
REPLACE INTO `nauczyciel_przedmiotu` (`nauczyciel_przedmiotu_ID`, `nauczyciel_id`, `przedmiot_nazwa`) VALUES
	(001, 01, 'WOS'),
	(002, 01, 'historia'),
	(003, 02, 'matematyka');
/*!40000 ALTER TABLE `nauczyciel_przedmiotu` ENABLE KEYS */;

-- Zrzut struktury tabela id13767441_dziennik.obecnosc
CREATE TABLE IF NOT EXISTS `obecnosc` (
  `obecnosc_ID` int(7) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `status` enum('obecny','nieobecny','spóźniony') COLLATE utf8_polish_ci NOT NULL DEFAULT 'obecny',
  `uczen_id` int(3) unsigned zerofill NOT NULL,
  `lekcja_id` int(5) unsigned zerofill NOT NULL,
  PRIMARY KEY (`obecnosc_ID`),
  UNIQUE KEY `obecność_id` (`obecnosc_ID`) USING BTREE,
  KEY `uczen` (`uczen_id`),
  KEY `lekcja` (`lekcja_id`),
  CONSTRAINT `FK_obecnosc_lekcja` FOREIGN KEY (`lekcja_id`) REFERENCES `lekcja` (`lekcja_ID`),
  CONSTRAINT `FK_obecnosc_uczen` FOREIGN KEY (`uczen_id`) REFERENCES `uczen` (`uczen_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Zrzucanie danych dla tabeli id13767441_dziennik.obecnosc: ~11 rows (około)
/*!40000 ALTER TABLE `obecnosc` DISABLE KEYS */;
REPLACE INTO `obecnosc` (`obecnosc_ID`, `status`, `uczen_id`, `lekcja_id`) VALUES
	(0000001, 'spóźniony', 001, 00001),
	(0000002, 'obecny', 001, 00002),
	(0000003, 'obecny', 001, 00003),
	(0000004, 'nieobecny', 001, 00004),
	(0000005, 'obecny', 002, 00001),
	(0000006, 'nieobecny', 002, 00002),
	(0000007, 'obecny', 002, 00003),
	(0000008, 'obecny', 003, 00001),
	(0000009, 'obecny', 003, 00002),
	(0000010, 'obecny', 003, 00003),
	(0000011, 'obecny', 003, 00004);
/*!40000 ALTER TABLE `obecnosc` ENABLE KEYS */;

-- Zrzut struktury tabela id13767441_dziennik.ocena
CREATE TABLE IF NOT EXISTS `ocena` (
  `ocena_ID` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `stopien` enum('0','1','2','3','4','5','6') COLLATE utf8_polish_ci NOT NULL,
  `waga` int(1) unsigned NOT NULL DEFAULT 1,
  `opis` varchar(100) COLLATE utf8_polish_ci NOT NULL DEFAULT 'Brak opisu',
  `data` date NOT NULL DEFAULT curdate(),
  `uczen_id` int(3) unsigned zerofill NOT NULL,
  `nauczyciel_przedmiotu_id` int(3) unsigned zerofill NOT NULL,
  PRIMARY KEY (`ocena_ID`),
  UNIQUE KEY `Indeks 1` (`ocena_ID`) USING BTREE,
  KEY `nauczyciel` (`nauczyciel_przedmiotu_id`),
  KEY `uczen` (`uczen_id`),
  CONSTRAINT `FK_ocena_nauczyciel_przedmiotu` FOREIGN KEY (`nauczyciel_przedmiotu_id`) REFERENCES `nauczyciel_przedmiotu` (`nauczyciel_przedmiotu_ID`),
  CONSTRAINT `FK_ocena_uczen` FOREIGN KEY (`uczen_id`) REFERENCES `uczen` (`uczen_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Zrzucanie danych dla tabeli id13767441_dziennik.ocena: ~12 rows (około)
/*!40000 ALTER TABLE `ocena` DISABLE KEYS */;
REPLACE INTO `ocena` (`ocena_ID`, `stopien`, `waga`, `opis`, `data`, `uczen_id`, `nauczyciel_przedmiotu_id`) VALUES
	(000001, '3', 3, '', '2020-04-29', 001, 001),
	(000002, '5', 1, '', '2020-04-29', 003, 002),
	(000003, '4', 2, '', '2020-04-29', 001, 003),
	(000004, '0', 1, '', '2020-04-29', 002, 001),
	(000005, '0', 1, '', '2020-04-29', 003, 002),
	(000006, '1', 1, '', '2020-04-29', 001, 003),
	(000007, '5', 8, '', '2020-04-29', 002, 003),
	(000008, '3', 1, '', '2020-04-29', 003, 001),
	(000009, '4', 2, 'Brak opisu', '2020-05-21', 001, 001),
	(000010, '1', 5, 'Brak opisu', '2020-05-21', 003, 002),
	(000011, '1', 1, 'Brak opisu', '2020-05-21', 002, 002),
	(000012, '1', 1, 'Brak opisu', '2020-05-21', 002, 002);
/*!40000 ALTER TABLE `ocena` ENABLE KEYS */;

-- Zrzut struktury widok id13767441_dziennik.ocena_info_lista
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `ocena_info_lista` (
	`ocena_ID` INT(6) UNSIGNED ZEROFILL NOT NULL,
	`stopien` ENUM('0','1','2','3','4','5','6') NOT NULL COLLATE 'utf8_polish_ci',
	`waga` INT(1) UNSIGNED NOT NULL,
	`opis` VARCHAR(100) NOT NULL COLLATE 'utf8_polish_ci',
	`data` DATE NOT NULL,
	`uczen_id` INT(3) UNSIGNED ZEROFILL NOT NULL,
	`imie` VARCHAR(20) NOT NULL COLLATE 'utf8_polish_ci',
	`nazwisko` VARCHAR(30) NOT NULL COLLATE 'utf8_polish_ci',
	`przedmiot` VARCHAR(32) NULL COLLATE 'utf8_polish_ci'
) ENGINE=MyISAM;

-- Zrzut struktury procedura id13767441_dziennik.oceny_ucznia
DELIMITER //
CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `oceny_ucznia`(
	IN `uczen_id` INT




)
select * 
from ocena_info_lista as o
where o.uczen_id = uczen_id//
DELIMITER ;

-- Zrzut struktury tabela id13767441_dziennik.opiekunowie
CREATE TABLE IF NOT EXISTS `opiekunowie` (
  `opiekunowie_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`opiekunowie_ID`),
  UNIQUE KEY `ID` (`opiekunowie_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Zrzucanie danych dla tabeli id13767441_dziennik.opiekunowie: ~6 rows (około)
/*!40000 ALTER TABLE `opiekunowie` DISABLE KEYS */;
REPLACE INTO `opiekunowie` (`opiekunowie_ID`) VALUES
	(001),
	(002),
	(003),
	(004),
	(005),
	(006);
/*!40000 ALTER TABLE `opiekunowie` ENABLE KEYS */;

-- Zrzut struktury procedura id13767441_dziennik.plan_lekcji_klasy
DELIMITER //
CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `plan_lekcji_klasy`(
	IN `klasa_id` INT




)
select *
from lekcja_info_lista as l
join klasa as k on l.oddzial = k.oddzial
where k.klasa_ID = klasa_id//
DELIMITER ;

-- Zrzut struktury tabela id13767441_dziennik.przedmiot
CREATE TABLE IF NOT EXISTS `przedmiot` (
  `przedmiot_nazwa` varchar(32) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`przedmiot_nazwa`),
  UNIQUE KEY `przedmiot_nazwa` (`przedmiot_nazwa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Zrzucanie danych dla tabeli id13767441_dziennik.przedmiot: ~14 rows (około)
/*!40000 ALTER TABLE `przedmiot` DISABLE KEYS */;
REPLACE INTO `przedmiot` (`przedmiot_nazwa`) VALUES
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

-- Zrzut struktury tabela id13767441_dziennik.rodzic
CREATE TABLE IF NOT EXISTS `rodzic` (
  `rodzic_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `uzytkownik_login` varchar(16) COLLATE utf8_polish_ci NOT NULL,
  `nr_telefonu` varchar(12) COLLATE utf8_polish_ci DEFAULT NULL,
  `opiekunowie_id` int(3) unsigned zerofill NOT NULL,
  PRIMARY KEY (`rodzic_ID`),
  UNIQUE KEY `ID` (`rodzic_ID`),
  UNIQUE KEY `uzytkownik_login` (`uzytkownik_login`),
  KEY `powiazanie` (`opiekunowie_id`),
  CONSTRAINT `FK_rodzic_powiazanie` FOREIGN KEY (`opiekunowie_id`) REFERENCES `opiekunowie` (`opiekunowie_ID`),
  CONSTRAINT `FK_rodzic_uzytkownik` FOREIGN KEY (`uzytkownik_login`) REFERENCES `uzytkownik` (`uzytkownik_login`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Zrzucanie danych dla tabeli id13767441_dziennik.rodzic: ~6 rows (około)
/*!40000 ALTER TABLE `rodzic` DISABLE KEYS */;
REPLACE INTO `rodzic` (`rodzic_ID`, `uzytkownik_login`, `nr_telefonu`, `opiekunowie_id`) VALUES
	(001, 'R0001', '12313', 001),
	(002, 'R0002', '12313', 001),
	(003, 'R0003', '12313', 002),
	(004, 'R0004', '12313', 002),
	(005, 'R0005', '12313', 003),
	(006, 'R0006', '12313', 003);
/*!40000 ALTER TABLE `rodzic` ENABLE KEYS */;

-- Zrzut struktury procedura id13767441_dziennik.rodzice_ucznia
DELIMITER //
CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `rodzice_ucznia`(
	IN `uczen_id` INT





)
select rlst.imie, rlst.nazwisko, rlst.email, rlst.nr_telefonu
from opiekunowie
join uczen on opiekunowie.opiekunowie_ID = uczen.opiekunowie_id
join rodzic_info_lista as rlst on opiekunowie.opiekunowie_ID = rlst.opiekunowie_id
where uczen.uczen_ID = uczen_id//
DELIMITER ;

-- Zrzut struktury procedura id13767441_dziennik.rodzice_w_klasie
DELIMITER //
CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `rodzice_w_klasie`(
	IN `klasa_id` INT




)
select r.imie, r.nazwisko, r.email, r.nr_telefonu
from uczen_info_lista as u
join rodzic_info_lista as r on u.opiekunowie_id = r.opiekunowie_id
where u.klasa_id = klasa_id//
DELIMITER ;

-- Zrzut struktury procedura id13767441_dziennik.rodzic_info
DELIMITER //
CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `rodzic_info`(
	IN `rodzic_id` INT


)
select rlst.imie, rlst.nazwisko, rlst.email, rlst.nr_telefonu
from rodzic_info_lista as rlst
where rlst.rodzic_ID  = rodzic_id//
DELIMITER ;

-- Zrzut struktury widok id13767441_dziennik.rodzic_info_lista
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `rodzic_info_lista` (
	`rodzic_ID` INT(3) UNSIGNED ZEROFILL NOT NULL,
	`nr_telefonu` VARCHAR(12) NULL COLLATE 'utf8_polish_ci',
	`imie` VARCHAR(20) NULL COLLATE 'utf8_polish_ci',
	`nazwisko` VARCHAR(30) NULL COLLATE 'utf8_polish_ci',
	`email` VARCHAR(32) NULL COLLATE 'utf8_polish_ci',
	`opiekunowie_id` INT(3) UNSIGNED ZEROFILL NOT NULL
) ENGINE=MyISAM;

-- Zrzut struktury tabela id13767441_dziennik.uczen
CREATE TABLE IF NOT EXISTS `uczen` (
  `uczen_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `pesel` char(11) COLLATE utf8_polish_ci NOT NULL,
  `adres_id` int(3) unsigned zerofill NOT NULL,
  `klasa_id` int(2) unsigned zerofill NOT NULL,
  `opiekunowie_id` int(3) unsigned zerofill NOT NULL,
  `uzytkownik_login` varchar(16) COLLATE utf8_polish_ci NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Zrzucanie danych dla tabeli id13767441_dziennik.uczen: ~3 rows (około)
/*!40000 ALTER TABLE `uczen` DISABLE KEYS */;
REPLACE INTO `uczen` (`uczen_ID`, `pesel`, `adres_id`, `klasa_id`, `opiekunowie_id`, `uzytkownik_login`) VALUES
	(001, '99999999999', 009, 07, 001, 'U0001'),
	(002, '99999999998', 009, 02, 002, 'U0002'),
	(003, '99999999997', 008, 07, 003, 'U0003');
/*!40000 ALTER TABLE `uczen` ENABLE KEYS */;

-- Zrzut struktury procedura id13767441_dziennik.uczen_info
DELIMITER //
CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `uczen_info`(
	IN `uczen_id` INT


)
select * 
from uczen_info_lista
where uczen_info_lista.uczen_ID = uczen_id//
DELIMITER ;

-- Zrzut struktury widok id13767441_dziennik.uczen_info_lista
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `uczen_info_lista` (
	`uczen_ID` INT(3) UNSIGNED ZEROFILL NOT NULL,
	`klasa_ID` INT(2) UNSIGNED ZEROFILL NOT NULL,
	`oddzial` VARCHAR(3) NOT NULL COLLATE 'utf8_polish_ci',
	`imie` VARCHAR(20) NOT NULL COLLATE 'utf8_polish_ci',
	`nazwisko` VARCHAR(30) NOT NULL COLLATE 'utf8_polish_ci',
	`pesel` CHAR(11) NOT NULL COLLATE 'utf8_polish_ci',
	`email` VARCHAR(32) NULL COLLATE 'utf8_polish_ci',
	`miejscowosc` VARCHAR(30) NOT NULL COLLATE 'utf8_polish_ci',
	`kod` INT(5) UNSIGNED NOT NULL,
	`ulica` VARCHAR(30) NOT NULL COLLATE 'utf8_polish_ci',
	`nr_domu` VARCHAR(6) NOT NULL COLLATE 'utf8_polish_ci',
	`nr_mieszkania` VARCHAR(4) NULL COLLATE 'utf8_polish_ci',
	`opiekunowie_id` INT(3) UNSIGNED ZEROFILL NOT NULL
) ENGINE=MyISAM;

-- Zrzut struktury tabela id13767441_dziennik.ulica
CREATE TABLE IF NOT EXISTS `ulica` (
  `ulica_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(30) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`ulica_ID`),
  UNIQUE KEY `ID` (`ulica_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Zrzucanie danych dla tabeli id13767441_dziennik.ulica: ~14 rows (około)
/*!40000 ALTER TABLE `ulica` DISABLE KEYS */;
REPLACE INTO `ulica` (`ulica_ID`, `nazwa`) VALUES
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

-- Zrzut struktury tabela id13767441_dziennik.ulice_miejscowosci
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Zrzucanie danych dla tabeli id13767441_dziennik.ulice_miejscowosci: ~15 rows (około)
/*!40000 ALTER TABLE `ulice_miejscowosci` DISABLE KEYS */;
REPLACE INTO `ulice_miejscowosci` (`ulice_miejscowosci_ID`, `miejscowosc_id`, `ulica_id`, `kod`) VALUES
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

-- Zrzut struktury tabela id13767441_dziennik.uzytkownik
CREATE TABLE IF NOT EXISTS `uzytkownik` (
  `uzytkownik_login` varchar(16) COLLATE utf8_polish_ci NOT NULL DEFAULT left(md5(rand()),6),
  `nazwisko` varchar(30) COLLATE utf8_polish_ci NOT NULL,
  `imie` varchar(20) COLLATE utf8_polish_ci NOT NULL,
  `haslo` char(32) COLLATE utf8_polish_ci NOT NULL DEFAULT left(md5(rand()),16),
  `rodzaj` enum('U','N','R','I','A') COLLATE utf8_polish_ci DEFAULT 'I',
  `email` varchar(32) COLLATE utf8_polish_ci DEFAULT NULL,
  PRIMARY KEY (`uzytkownik_login`),
  UNIQUE KEY `login` (`uzytkownik_login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Zrzucanie danych dla tabeli id13767441_dziennik.uzytkownik: ~14 rows (około)
/*!40000 ALTER TABLE `uzytkownik` DISABLE KEYS */;
REPLACE INTO `uzytkownik` (`uzytkownik_login`, `nazwisko`, `imie`, `haslo`, `rodzaj`, `email`) VALUES
	('46f823', 'asd', 'adasd', 'e36b985580dbdd59', 'I', NULL),
	('db511b', 'Jackowski', 'Antoni', '452414799544ed31', 'A', NULL),
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
	('U0003', 'Grzyb', 'Aleksander', 'trabant', 'U', NULL);
/*!40000 ALTER TABLE `uzytkownik` ENABLE KEYS */;

-- Zrzut struktury tabela id13767441_dziennik.wersja
CREATE TABLE IF NOT EXISTS `wersja` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `major` int(10) unsigned DEFAULT 0,
  `minor` int(10) unsigned DEFAULT 0,
  `data` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Zrzucanie danych dla tabeli id13767441_dziennik.wersja: ~2 rows (około)
/*!40000 ALTER TABLE `wersja` DISABLE KEYS */;
REPLACE INTO `wersja` (`id`, `major`, `minor`, `data`) VALUES
	(1, 1, 0, '2020-05-13 17:31:38'),
	(2, 1, 1, '2020-05-21 13:25:43');
/*!40000 ALTER TABLE `wersja` ENABLE KEYS */;

-- Zrzut struktury procedura id13767441_dziennik.zmiana_hasla_admin
DELIMITER //
CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `zmiana_hasla_admin`(
	IN `new_haslo` CHAR(32),
	IN `uzytkownik_login` VARCHAR(16)

)
update uzytkownik 
set uzytkownik.haslo = new_haslo 
where uzytkownik.uzytkownik_login = uzytkownik_login//
DELIMITER ;

-- Zrzut struktury procedura id13767441_dziennik.zmiana_obecnosci_ucznia
DELIMITER //
CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `zmiana_obecnosci_ucznia`(
	IN `uczen_id` INT,
	IN `lekcja_id` INT,
	IN `new_status` ENUM('obecny','nieobecny','spóźniony')


)
update obecnosc set obecnosc.`status` = new_status where obecnosc.uczen = uczen_id and obecnosc.lekcja = lekcja_id//
DELIMITER ;

-- Zrzut struktury procedura id13767441_dziennik.zmiana_tematu_lekcji
DELIMITER //
CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `zmiana_tematu_lekcji`(
	IN `lekcja_id` INT,
	IN `new_temat` VARCHAR(250)

)
update lekcja set lekcja.temat = new_temat where lekcja.ID = lekcja_id//
DELIMITER ;

-- Zrzut struktury funkcja id13767441_dziennik.zmien_haslo
DELIMITER //
CREATE DEFINER=`id13767441_dzienn`@`%` FUNCTION `zmien_haslo`(`uzytkownik_login` VARCHAR(16),
	`old_haslo` CHAR(32),
	`new_haslo` CHAR(32)


) RETURNS bit(1)
BEGIN
    DECLARE s BIT;

    IF exists 
	 (
		 select *
		 from uzytkownik 
		 where uzytkownik.uzytkownik_login = uzytkownik_login and uzytkownik.haslo = old_haslo
	 )
	 THEN 
		 update uzytkownik
			set uzytkownik.haslo = new_haslo
		  	where uzytkownik.uzytkownik_login = uzytkownik_login;
		 SET s = 1;
	  
    ELSE SET s = 0;
    END IF;

    

    RETURN s;
END//
DELIMITER ;

-- Zrzut struktury widok id13767441_dziennik.adres_info_lista
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `adres_info_lista`;
CREATE ALGORITHM=UNDEFINED DEFINER=`id13767441_dzienn`@`%` SQL SECURITY DEFINER VIEW `adres_info_lista` AS SELECT `id13767441_dziennik`.`adres`.`adres_ID` AS `adres_ID`,`id13767441_dziennik`.`miejscowosc`.`nazwa` AS `miejscowosc`,`um`.`kod` AS `kod`,`id13767441_dziennik`.`ulica`.`nazwa` AS `ulica`,`id13767441_dziennik`.`adres`.`nr_domu` AS `nr_domu`,`id13767441_dziennik`.`adres`.`nr_mieszkania` AS `nr_mieszkania`
FROM (((`ulice_miejscowosci` `um`
JOIN `ulica` ON(`um`.`ulica_id` = `id13767441_dziennik`.`ulica`.`ulica_ID`))
JOIN `miejscowosc` ON(`um`.`miejscowosc_id` = `id13767441_dziennik`.`miejscowosc`.`miejscowosc_ID`))
JOIN `adres` ON(`id13767441_dziennik`.`adres`.`ulice_miejscowosci_id` = `um`.`ulice_miejscowosci_ID`)) ;

-- Zrzut struktury widok id13767441_dziennik.lekcja_info_lista
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `lekcja_info_lista`;
CREATE ALGORITHM=UNDEFINED DEFINER=`id13767441_dzienn`@`%` SQL SECURITY DEFINER VIEW `lekcja_info_lista` AS select `l`.`lekcja_ID` AS `lekcja_ID`,`c`.`data` AS `data`,`c`.`godz_start` AS `godz_start`,`c`.`godz_koniec` AS `godz_koniec`,`o`.`oddzial` AS `oddzial`,`l`.`sala` AS `sala`,`o`.`przedmiot` AS `przedmiot`,`o`.`imie` AS `imie`,`o`.`nazwisko` AS `nazwisko`,`l`.`temat` AS `temat`,`o`.`ID` AS `nauczyciel_id` from ((`id13767441_dziennik`.`lekcja` `l` join `id13767441_dziennik`.`czas_lekcji` `c` on(`l`.`czas_lekcji_id` = `c`.`czas_lekcji_ID`)) join (select `gr`.`grupa_lekcji_ID` AS `grupa_lekcji_ID`,`k`.`oddzial` AS `oddzial`,`nlst`.`imie` AS `imie`,`nlst`.`nazwisko` AS `nazwisko`,`nlst`.`przedmiot` AS `przedmiot`,`nlst`.`ID` AS `ID` from ((`id13767441_dziennik`.`grupa_lekcji` `gr` join `id13767441_dziennik`.`nauczyciel_info_lista` `nlst` on(`gr`.`nauczyciel_przedmiot_id` = `nlst`.`nauczyciel_przedmiotu_ID`)) join `id13767441_dziennik`.`klasa` `k` on(`gr`.`klasa_id` = `k`.`klasa_ID`))) `o` on(`l`.`grupa_lekcji_id` = `o`.`grupa_lekcji_ID`)) ;

-- Zrzut struktury widok id13767441_dziennik.nauczyciel_info_lista
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `nauczyciel_info_lista`;
CREATE ALGORITHM=UNDEFINED DEFINER=`id13767441_dzienn`@`%` SQL SECURITY DEFINER VIEW `nauczyciel_info_lista` AS select `id13767441_dziennik`.`nauczyciel`.`nauczyciel_ID` AS `ID`,`id13767441_dziennik`.`uzytkownik`.`nazwisko` AS `nazwisko`,`id13767441_dziennik`.`uzytkownik`.`imie` AS `imie`,`id13767441_dziennik`.`nauczyciel`.`nr_tel` AS `nr_tel`,`id13767441_dziennik`.`uzytkownik`.`email` AS `email`,`id13767441_dziennik`.`nauczyciel_przedmiotu`.`przedmiot_nazwa` AS `przedmiot`,`id13767441_dziennik`.`nauczyciel_przedmiotu`.`nauczyciel_przedmiotu_ID` AS `nauczyciel_przedmiotu_ID` from ((`nauczyciel` join `uzytkownik` on(`id13767441_dziennik`.`nauczyciel`.`uzytkownik_login` = `id13767441_dziennik`.`uzytkownik`.`uzytkownik_login`)) join `nauczyciel_przedmiotu` on(`id13767441_dziennik`.`nauczyciel`.`nauczyciel_ID` = `id13767441_dziennik`.`nauczyciel_przedmiotu`.`nauczyciel_id`)) ;

-- Zrzut struktury widok id13767441_dziennik.ocena_info_lista
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `ocena_info_lista`;
CREATE ALGORITHM=UNDEFINED DEFINER=`id13767441_dzienn`@`%` SQL SECURITY DEFINER VIEW `ocena_info_lista` AS select `id13767441_dziennik`.`ocena`.`ocena_ID` AS `ocena_ID`,`id13767441_dziennik`.`ocena`.`stopien` AS `stopien`,`id13767441_dziennik`.`ocena`.`waga` AS `waga`,`id13767441_dziennik`.`ocena`.`opis` AS `opis`,`id13767441_dziennik`.`ocena`.`data` AS `data`,`id13767441_dziennik`.`ocena`.`uczen_id` AS `uczen_id`,`n`.`imie` AS `imie`,`n`.`nazwisko` AS `nazwisko`,`n`.`przedmiot` AS `przedmiot` from (`ocena` join `nauczyciel_info_lista` `n` on(`id13767441_dziennik`.`ocena`.`nauczyciel_przedmiotu_id` = `n`.`nauczyciel_przedmiotu_ID`)) ;

-- Zrzut struktury widok id13767441_dziennik.rodzic_info_lista
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `rodzic_info_lista`;
CREATE ALGORITHM=UNDEFINED DEFINER=`id13767441_dzienn`@`%` SQL SECURITY DEFINER VIEW `rodzic_info_lista` AS select `r`.`rodzic_ID` AS `rodzic_ID`,`r`.`nr_telefonu` AS `nr_telefonu`,`u`.`imie` AS `imie`,`u`.`nazwisko` AS `nazwisko`,`u`.`email` AS `email`,`r`.`opiekunowie_id` AS `opiekunowie_id` from (`rodzic` `r` left join `uzytkownik` `u` on(`r`.`uzytkownik_login` = `u`.`uzytkownik_login`)) ;

-- Zrzut struktury widok id13767441_dziennik.uczen_info_lista
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `uczen_info_lista`;
CREATE ALGORITHM=UNDEFINED DEFINER=`id13767441_dzienn`@`%` SQL SECURITY DEFINER VIEW `uczen_info_lista` AS SELECT `ucz`.`uczen_ID` AS `uczen_ID`,k.klasa_ID,`k`.`oddzial` AS `oddzial`,`u`.`imie` AS `imie`,`u`.`nazwisko` AS `nazwisko`,`ucz`.`pesel` AS `pesel`,`u`.`email` AS `email`,`a`.`miejscowosc` AS `miejscowosc`,`a`.`kod` AS `kod`,`a`.`ulica` AS `ulica`,`a`.`nr_domu` AS `nr_domu`,`a`.`nr_mieszkania` AS `nr_mieszkania`, ucz.opiekunowie_id
FROM (((`uczen` `ucz`
JOIN `uzytkownik` `u` ON(`ucz`.`uzytkownik_login` = `u`.`uzytkownik_login`))
JOIN `adres_info_lista` `a` ON(`ucz`.`adres_id` = `a`.`adres_ID`))
JOIN `klasa` `k` ON(`ucz`.`klasa_id` = `k`.`klasa_ID`)) ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
