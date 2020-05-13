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
  CONSTRAINT `FK_adres_ulice_miejscowosci` FOREIGN KEY (`ulice_miejscowosci_id`) REFERENCES `ulicemiejscowosci` (`ulicemiejscowosci_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.adres: ~11 rows (około)
DELETE FROM `adres`;
/*!40000 ALTER TABLE `adres` DISABLE KEYS */;
INSERT INTO `adres` (`adres_ID`, `ulice_miejscowosci_id`, `nr_domu`, `nr_mieszkania`) VALUES
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

-- Zrzut struktury tabela dziennik szkolny.czaslekcji
CREATE TABLE IF NOT EXISTS `czaslekcji` (
  `czaslekcji_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL DEFAULT '0000-00-00',
  `godz_start` time NOT NULL DEFAULT '00:00:00',
  `godz_koniec` time NOT NULL DEFAULT '00:00:00',
  PRIMARY KEY (`czaslekcji_ID`),
  UNIQUE KEY `ID` (`czaslekcji_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.czaslekcji: ~5 rows (około)
DELETE FROM `czaslekcji`;
/*!40000 ALTER TABLE `czaslekcji` DISABLE KEYS */;
INSERT INTO `czaslekcji` (`czaslekcji_ID`, `data`, `godz_start`, `godz_koniec`) VALUES
	(00001, '2020-05-08', '14:00:00', '14:45:00'),
	(00002, '2020-05-08', '15:00:00', '15:45:00'),
	(00003, '2020-05-09', '14:00:00', '14:45:00'),
	(00004, '2020-05-09', '15:00:00', '15:45:00'),
	(00005, '2020-05-10', '14:00:00', '14:45:00');
/*!40000 ALTER TABLE `czaslekcji` ENABLE KEYS */;

-- Zrzut struktury tabela dziennik szkolny.czas_lekcji
CREATE TABLE IF NOT EXISTS `czas_lekcji` (
  `czas_lekcji_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL DEFAULT '0000-00-00',
  `godz_start` time NOT NULL DEFAULT '00:00:00',
  `godz_koniec` time NOT NULL DEFAULT '00:00:00',
  PRIMARY KEY (`czas_lekcji_ID`),
  UNIQUE KEY `ID` (`czas_lekcji_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.czas_lekcji: ~5 rows (około)
DELETE FROM `czas_lekcji`;
/*!40000 ALTER TABLE `czas_lekcji` DISABLE KEYS */;
INSERT INTO `czas_lekcji` (`czas_lekcji_ID`, `data`, `godz_start`, `godz_koniec`) VALUES
	(00001, '2020-05-08', '14:00:00', '14:45:00'),
	(00002, '2020-05-08', '15:00:00', '15:45:00'),
	(00003, '2020-05-09', '14:00:00', '14:45:00'),
	(00004, '2020-05-09', '15:00:00', '15:45:00'),
	(00005, '2020-05-10', '14:00:00', '14:45:00');
/*!40000 ALTER TABLE `czas_lekcji` ENABLE KEYS */;

-- Zrzut struktury procedura dziennik szkolny.dzieci_rodzica
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `dzieci_rodzica`(
	IN `rodzic_id` INT

)
select *
from rodzic 
join uczen_info as ui on rodzic.opiekunowie_id = ui.opiekunowie_id
where rodzic.rodzic_ID = rodzic_id//
DELIMITER ;

-- Zrzut struktury procedura dziennik szkolny.frekwencja_na_lekcji
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `frekwencja_na_lekcji`(
	IN `lekcja_id` INT
)
select *
from obecnosc
join lekcja on obecnosc.lekcja = lekcja.lekcja_ID
join uczen on obecnosc.uczen = uczen.uczen_ID
where lekcja.lekcja_ID = lekcja_id//
DELIMITER ;

-- Zrzut struktury procedura dziennik szkolny.frekwencja_ucznia
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `frekwencja_ucznia`(
	IN `uczen_id` INT


)
select *
from lekcja_info as li
join nauczyciel_info as ni on li.grupalekcji_ID = ni.gpid
join obecnosc on li.lekcja_ID = obecnosc.lekcja
where obecnosc.uczen = uczen_id
order by li.`data`//
DELIMITER ;

-- Zrzut struktury tabela dziennik szkolny.grupalekcji
CREATE TABLE IF NOT EXISTS `grupalekcji` (
  `grupalekcji_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `klasa_id` int(2) unsigned zerofill NOT NULL,
  `nauczyciel_przedmiot_id` int(3) unsigned zerofill NOT NULL,
  PRIMARY KEY (`grupalekcji_ID`),
  UNIQUE KEY `ID` (`grupalekcji_ID`),
  KEY `FK_grupa_lekcji_klasa` (`klasa_id`),
  KEY `FK_grupa_lekcji_nauczyciel_przedmiotu` (`nauczyciel_przedmiot_id`),
  CONSTRAINT `FK_grupa_lekcji_klasa` FOREIGN KEY (`klasa_id`) REFERENCES `klasa` (`klasa_ID`),
  CONSTRAINT `FK_grupa_lekcji_nauczyciel_przedmiotu` FOREIGN KEY (`nauczyciel_przedmiot_id`) REFERENCES `nauczycielprzedmiotu` (`nauczycielprzedmiotu_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.grupalekcji: ~2 rows (około)
DELETE FROM `grupalekcji`;
/*!40000 ALTER TABLE `grupalekcji` DISABLE KEYS */;
INSERT INTO `grupalekcji` (`grupalekcji_ID`, `klasa_id`, `nauczyciel_przedmiot_id`) VALUES
	(00001, 07, 001),
	(00002, 01, 003),
	(00003, 07, 002);
/*!40000 ALTER TABLE `grupalekcji` ENABLE KEYS */;

-- Zrzut struktury widok dziennik szkolny.grupalekcjinauczycielprzemiotu
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `grupalekcjinauczycielprzemiotu` 
) ENGINE=MyISAM;

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

-- Zrzut struktury tabela dziennik szkolny.lekcja
CREATE TABLE IF NOT EXISTS `lekcja` (
  `lekcja_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `temat` varchar(250) COLLATE ucs2_polish_ci NOT NULL,
  `sala` int(2) unsigned NOT NULL,
  `grupa_lekcji_id` int(3) unsigned zerofill NOT NULL,
  `czas_lekcji_id` int(5) unsigned zerofill NOT NULL,
  PRIMARY KEY (`lekcja_ID`),
  UNIQUE KEY `lekcja_id` (`lekcja_ID`),
  KEY `FK_lekcja_grupa_lekcji` (`grupa_lekcji_id`),
  KEY `FK_lekcja_czas_lekcji` (`czas_lekcji_id`),
  CONSTRAINT `FK_lekcja_czas_lekcji` FOREIGN KEY (`czas_lekcji_id`) REFERENCES `czaslekcji` (`czaslekcji_ID`),
  CONSTRAINT `FK_lekcja_grupa_lekcji` FOREIGN KEY (`grupa_lekcji_id`) REFERENCES `grupalekcji` (`grupalekcji_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.lekcja: ~7 rows (około)
DELETE FROM `lekcja`;
/*!40000 ALTER TABLE `lekcja` DISABLE KEYS */;
INSERT INTO `lekcja` (`lekcja_ID`, `temat`, `sala`, `grupa_lekcji_id`, `czas_lekcji_id`) VALUES
	(00001, 'To jest nowy temat lekcji wywołany przez procedurę zmiana_tematu_lekcji', 12, 001, 00001),
	(00002, 'Temat', 12, 002, 00001),
	(00003, 'Temat', 12, 003, 00001),
	(00004, 'Temat', 12, 001, 00002),
	(00005, 'Temat', 12, 002, 00002),
	(00006, 'Temat', 12, 003, 00002),
	(00007, 'Procedury, widoki, wyzwalacze i indeksy', 12, 002, 00004);
/*!40000 ALTER TABLE `lekcja` ENABLE KEYS */;

-- Zrzut struktury widok dziennik szkolny.lekcja_info
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `lekcja_info` (
	`lekcja_ID` INT(5) UNSIGNED ZEROFILL NOT NULL,
	`temat` VARCHAR(250) NOT NULL COLLATE 'ucs2_polish_ci',
	`sala` INT(2) UNSIGNED NOT NULL,
	`nauczyciel_przedmiot_id` INT(3) UNSIGNED ZEROFILL NOT NULL,
	`klasa_id` INT(2) UNSIGNED ZEROFILL NOT NULL,
	`data` DATE NULL,
	`godz_start` TIME NULL,
	`godz_koniec` TIME NULL,
	`grupalekcji_ID` INT(5) UNSIGNED ZEROFILL NOT NULL
) ENGINE=MyISAM;

-- Zrzut struktury procedura dziennik szkolny.lekcje_nauczyciela
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `lekcje_nauczyciela`(
	IN `nauczyciel_id` INT

)
select * 
from nauczycielprzedmiotu as np
join lekcja_info as li on np.nauczycielprzedmiotu_ID = li.nauczyciel_przedmiot_id
join nauczyciel on np.nauczyciel_id  = nauczyciel.nauczyciel_ID//
DELIMITER ;

-- Zrzut struktury widok dziennik szkolny.lista_nauczycieli
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `lista_nauczycieli` (
	`ID` INT(2) UNSIGNED ZEROFILL NOT NULL,
	`nazwisko` VARCHAR(30) NOT NULL COLLATE 'ucs2_polish_ci',
	`imie` VARCHAR(20) NOT NULL COLLATE 'ucs2_polish_ci',
	`nr_tel` CHAR(50) NOT NULL COLLATE 'ucs2_polish_ci',
	`email` VARCHAR(32) NULL COLLATE 'ucs2_polish_ci',
	`przedmiot` VARCHAR(32) NULL COLLATE 'ucs2_polish_ci'
) ENGINE=MyISAM;

-- Zrzut struktury procedura dziennik szkolny.lista_osob_w_klasie
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_osob_w_klasie`(
	IN `in_oddzial` CHAR(3)


)
SELECT klasa.oddzial AS 'klasa', uzytkownik.imie AS 'imie', uzytkownik.nazwisko AS 'nazwisko'
FROM ((uczen
INNER JOIN klasa ON uczen.klasa = klasa.id AND klasa.oddzial= in_oddzial )
left JOIN uzytkownik ON uczen.uzytkownik_login = uzytkownik.login)
ORDER BY nazwisko ASC//
DELIMITER ;

-- Zrzut struktury widok dziennik szkolny.lista_rodzicow
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `lista_rodzicow` 
) ENGINE=MyISAM;

-- Zrzut struktury widok dziennik szkolny.lista_uczniow
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `lista_uczniow` 
) ENGINE=MyISAM;

-- Zrzut struktury widok dziennik szkolny.lista_uzytkownikow
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `lista_uzytkownikow` 
) ENGINE=MyISAM;

-- Zrzut struktury tabela dziennik szkolny.miejscowosc
CREATE TABLE IF NOT EXISTS `miejscowosc` (
  `miejscowosc_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(30) COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`miejscowosc_ID`),
  UNIQUE KEY `ID` (`miejscowosc_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.miejscowosc: ~6 rows (około)
DELETE FROM `miejscowosc`;
/*!40000 ALTER TABLE `miejscowosc` DISABLE KEYS */;
INSERT INTO `miejscowosc` (`miejscowosc_ID`, `nazwa`) VALUES
	(001, 'Wrocław'),
	(002, 'Oborniki Śląskie'),
	(003, 'Oława'),
	(004, 'Kamieniec Wrocławski'),
	(005, 'Oleśnica'),
	(006, 'Trzebnica');
/*!40000 ALTER TABLE `miejscowosc` ENABLE KEYS */;

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

-- Zrzucanie danych dla tabeli dziennik szkolny.nauczyciel: ~2 rows (około)
DELETE FROM `nauczyciel`;
/*!40000 ALTER TABLE `nauczyciel` DISABLE KEYS */;
INSERT INTO `nauczyciel` (`nauczyciel_ID`, `uzytkownik_login`, `nr_tel`, `czy_wych`) VALUES
	(01, 'N0001', '111111111', 'N'),
	(02, 'N0002', '111111111', 'N');
/*!40000 ALTER TABLE `nauczyciel` ENABLE KEYS */;

-- Zrzut struktury procedura dziennik szkolny.nauczyciele_przedmiotu
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `nauczyciele_przedmiotu`(
	IN `przedmiot_nazwa` VARCHAR(32)




)
select *
from przedmiot
where przedmiot.przedmiot_nazwa = przedmiot_nazwa//
DELIMITER ;

-- Zrzut struktury tabela dziennik szkolny.nauczycielprzedmiotu
CREATE TABLE IF NOT EXISTS `nauczycielprzedmiotu` (
  `nauczycielprzedmiotu_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `nauczyciel_id` int(2) unsigned zerofill NOT NULL,
  `przedmiot_nazwa` varchar(32) COLLATE ucs2_polish_ci DEFAULT NULL,
  PRIMARY KEY (`nauczycielprzedmiotu_ID`),
  UNIQUE KEY `ID` (`nauczycielprzedmiotu_ID`),
  KEY `FK_nauczyciel_przedmiotu_przedmiot` (`przedmiot_nazwa`),
  KEY `FK_nauczyciel_przedmiotu_nauczyciel` (`nauczyciel_id`),
  CONSTRAINT `FK_nauczyciel_przedmiotu_nauczyciel` FOREIGN KEY (`nauczyciel_id`) REFERENCES `nauczyciel` (`nauczyciel_ID`),
  CONSTRAINT `FK_nauczyciel_przedmiotu_przedmiot` FOREIGN KEY (`przedmiot_nazwa`) REFERENCES `przedmiot` (`przedmiot_nazwa`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.nauczycielprzedmiotu: ~3 rows (około)
DELETE FROM `nauczycielprzedmiotu`;
/*!40000 ALTER TABLE `nauczycielprzedmiotu` DISABLE KEYS */;
INSERT INTO `nauczycielprzedmiotu` (`nauczycielprzedmiotu_ID`, `nauczyciel_id`, `przedmiot_nazwa`) VALUES
	(001, 01, 'WOS\r'),
	(002, 01, 'historia\r'),
	(003, 02, 'matematyka\r');
/*!40000 ALTER TABLE `nauczycielprzedmiotu` ENABLE KEYS */;

-- Zrzut struktury widok dziennik szkolny.nauczyciel_info
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `nauczyciel_info` (
	`ID` INT(2) UNSIGNED ZEROFILL NOT NULL,
	`imie` VARCHAR(20) NOT NULL COLLATE 'ucs2_polish_ci',
	`nazwisko` VARCHAR(30) NOT NULL COLLATE 'ucs2_polish_ci',
	`nazwa` VARCHAR(32) NOT NULL COLLATE 'ucs2_polish_ci',
	`gpid` INT(5) UNSIGNED ZEROFILL NOT NULL,
	`npid` INT(3) UNSIGNED ZEROFILL NOT NULL
) ENGINE=MyISAM;

-- Zrzut struktury tabela dziennik szkolny.obecnosc
CREATE TABLE IF NOT EXISTS `obecnosc` (
  `obecnosc_ID` int(7) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `status` enum('obecny','nieobecny','spóźniony') COLLATE ucs2_polish_ci NOT NULL DEFAULT 'obecny',
  `uczen` int(3) unsigned zerofill NOT NULL,
  `lekcja` int(5) unsigned zerofill NOT NULL,
  PRIMARY KEY (`obecnosc_ID`),
  UNIQUE KEY `obecność_id` (`obecnosc_ID`),
  KEY `uczen` (`uczen`),
  KEY `lekcja` (`lekcja`),
  CONSTRAINT `FK_obecnosc_lekcja` FOREIGN KEY (`lekcja`) REFERENCES `lekcja` (`lekcja_ID`),
  CONSTRAINT `FK_obecnosc_uczen` FOREIGN KEY (`uczen`) REFERENCES `uczen` (`uczen_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.obecnosc: ~11 rows (około)
DELETE FROM `obecnosc`;
/*!40000 ALTER TABLE `obecnosc` DISABLE KEYS */;
INSERT INTO `obecnosc` (`obecnosc_ID`, `status`, `uczen`, `lekcja`) VALUES
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
  CONSTRAINT `FK_ocena_nauczyciel_przedmiotu` FOREIGN KEY (`nauczyciel_przedmiotu_id`) REFERENCES `nauczycielprzedmiotu` (`nauczycielprzedmiotu_ID`),
  CONSTRAINT `FK_ocena_uczen` FOREIGN KEY (`uczen_id`) REFERENCES `uczen` (`uczen_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.ocena: ~8 rows (około)
DELETE FROM `ocena`;
/*!40000 ALTER TABLE `ocena` DISABLE KEYS */;
INSERT INTO `ocena` (`ocena_ID`, `stopien`, `waga`, `opis`, `data`, `uczen_id`, `nauczyciel_przedmiotu_id`) VALUES
	(000001, 'dop', 3, '', '2020-04-29', 001, 001),
	(000002, 'db', 1, '', '2020-04-29', 003, 002),
	(000003, 'ndst', 2, '', '2020-04-29', 001, 003),
	(000004, 'cel', 1, '', '2020-04-29', 002, 001),
	(000005, 'dst', 1, '', '2020-04-29', 003, 002),
	(000006, 'db', 1, '', '2020-04-29', 001, 003),
	(000007, 'bdb', 8, '', '2020-04-29', 002, 003),
	(000008, 'db', 1, '', '2020-04-29', 003, 001);
/*!40000 ALTER TABLE `ocena` ENABLE KEYS */;

-- Zrzut struktury procedura dziennik szkolny.oceny_ucznia
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `oceny_ucznia`(
	IN `uczen_id` INT

)
select * 
from ocena 
join nauczyciel_info as ni on ocena.nauczyciel_przedmiotu_id = ni.npid
where ocena.uczen_id = uczen_id//
DELIMITER ;

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

-- Zrzut struktury tabela dziennik szkolny.przedmiot
CREATE TABLE IF NOT EXISTS `przedmiot` (
  `przedmiot_nazwa` varchar(32) COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`przedmiot_nazwa`),
  UNIQUE KEY `przedmiot_nazwa` (`przedmiot_nazwa`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.przedmiot: ~11 rows (około)
DELETE FROM `przedmiot`;
/*!40000 ALTER TABLE `przedmiot` DISABLE KEYS */;
INSERT INTO `przedmiot` (`przedmiot_nazwa`) VALUES
	('biologia'),
	('chemia\r'),
	('fizyka\r'),
	('geografia\r'),
	('historia\r'),
	('j.angielski\r'),
	('j.niemiecki\r'),
	('j.polski\r'),
	('matematyka\r'),
	('matematyka'),
	('wf\r'),
	('WOS\r');
/*!40000 ALTER TABLE `przedmiot` ENABLE KEYS */;

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

-- Zrzucanie danych dla tabeli dziennik szkolny.rodzic: ~6 rows (około)
DELETE FROM `rodzic`;
/*!40000 ALTER TABLE `rodzic` DISABLE KEYS */;
INSERT INTO `rodzic` (`rodzic_ID`, `uzytkownik_login`, `nr_telefonu`, `opiekunowie_id`) VALUES
	(001, 'R0001', '12313', 001),
	(002, 'R0002', '12313', 001),
	(003, 'R0003', '12313', 002),
	(004, 'R0004', '12313', 002),
	(005, 'R0005', '12313', 003),
	(006, 'R0006', '12313', 003);
/*!40000 ALTER TABLE `rodzic` ENABLE KEYS */;

-- Zrzut struktury procedura dziennik szkolny.rodzice_ucznia
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `rodzice_ucznia`(
	IN `uczen_id` INT

)
select * 
from opiekunowie
join uczen on opiekunowie.opiekunowie_ID = uczen.opiekunowie_id
join rodzic_info as ri on opiekunowie.opiekunowie_ID = ri.opiekunowie_id
where uczen.uczen_ID = uczen_id//
DELIMITER ;

-- Zrzut struktury widok dziennik szkolny.rodzic_info
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `rodzic_info` (
	`rodzic_ID` INT(3) UNSIGNED ZEROFILL NOT NULL,
	`nr_telefonu` VARCHAR(12) NULL COLLATE 'ucs2_polish_ci',
	`uzytkownik_login` VARCHAR(16) NULL COLLATE 'ucs2_polish_ci',
	`haslo` CHAR(32) NULL COLLATE 'ucs2_polish_ci',
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

-- Zrzucanie danych dla tabeli dziennik szkolny.uczen: ~3 rows (około)
DELETE FROM `uczen`;
/*!40000 ALTER TABLE `uczen` DISABLE KEYS */;
INSERT INTO `uczen` (`uczen_ID`, `pesel`, `adres_id`, `klasa_id`, `opiekunowie_id`, `uzytkownik_login`) VALUES
	(001, '99999999999', 009, 07, 001, 'U0001'),
	(002, '99999999998', 009, 02, 002, 'U0002'),
	(003, '99999999997', 008, 07, 003, 'U0003');
/*!40000 ALTER TABLE `uczen` ENABLE KEYS */;

-- Zrzut struktury widok dziennik szkolny.uczen_info
-- Tworzenie tymczasowej tabeli aby przezwyciężyć błędy z zależnościami w WIDOKU
CREATE TABLE `uczen_info` (
	`uczen_ID` INT(3) UNSIGNED ZEROFILL NOT NULL,
	`pesel` CHAR(11) NOT NULL COLLATE 'latin1_swedish_ci',
	`klasa_id` INT(2) UNSIGNED ZEROFILL NOT NULL,
	`opiekunowie_id` INT(3) UNSIGNED ZEROFILL NOT NULL,
	`uzytkownik_login` VARCHAR(16) NOT NULL COLLATE 'ucs2_polish_ci',
	`haslo` CHAR(32) NOT NULL COLLATE 'ucs2_polish_ci',
	`imie` VARCHAR(20) NOT NULL COLLATE 'ucs2_polish_ci',
	`nazwisko` VARCHAR(30) NOT NULL COLLATE 'ucs2_polish_ci',
	`email` VARCHAR(32) NULL COLLATE 'ucs2_polish_ci'
) ENGINE=MyISAM;

-- Zrzut struktury tabela dziennik szkolny.ulica
CREATE TABLE IF NOT EXISTS `ulica` (
  `ulica_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(30) COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`ulica_ID`),
  UNIQUE KEY `ID` (`ulica_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.ulica: ~14 rows (około)
DELETE FROM `ulica`;
/*!40000 ALTER TABLE `ulica` DISABLE KEYS */;
INSERT INTO `ulica` (`ulica_ID`, `nazwa`) VALUES
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

-- Zrzut struktury tabela dziennik szkolny.ulicemiejscowosci
CREATE TABLE IF NOT EXISTS `ulicemiejscowosci` (
  `ulicemiejscowosci_ID` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `miejscowosc_id` int(3) unsigned zerofill NOT NULL,
  `ulica_id` int(3) unsigned zerofill NOT NULL,
  `kod` int(5) unsigned NOT NULL,
  PRIMARY KEY (`ulicemiejscowosci_ID`),
  UNIQUE KEY `ID` (`ulicemiejscowosci_ID`),
  KEY `FK_ulice_miejscowosci_miejscowosc` (`miejscowosc_id`),
  KEY `FK_ulice_miejscowosci_ulica` (`ulica_id`),
  CONSTRAINT `FK_ulice_miejscowosci_miejscowosc` FOREIGN KEY (`miejscowosc_id`) REFERENCES `miejscowosc` (`miejscowosc_ID`),
  CONSTRAINT `FK_ulice_miejscowosci_ulica` FOREIGN KEY (`ulica_id`) REFERENCES `ulica` (`ulica_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.ulicemiejscowosci: ~15 rows (około)
DELETE FROM `ulicemiejscowosci`;
/*!40000 ALTER TABLE `ulicemiejscowosci` DISABLE KEYS */;
INSERT INTO `ulicemiejscowosci` (`ulicemiejscowosci_ID`, `miejscowosc_id`, `ulica_id`, `kod`) VALUES
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
/*!40000 ALTER TABLE `ulicemiejscowosci` ENABLE KEYS */;

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

-- Zrzucanie danych dla tabeli dziennik szkolny.uzytkownik: ~12 rows (około)
DELETE FROM `uzytkownik`;
/*!40000 ALTER TABLE `uzytkownik` DISABLE KEYS */;
INSERT INTO `uzytkownik` (`uzytkownik_login`, `nazwisko`, `imie`, `haslo`, `rodzaj`, `email`) VALUES
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

-- Zrzut struktury wyzwalacz dziennik szkolny.test
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `test` BEFORE DELETE ON `rodzic` FOR EACH ROW delete from uzytkownik where login = OLD.uzytkownik_login//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Zrzut struktury widok dziennik szkolny.grupalekcjinauczycielprzemiotu
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `grupalekcjinauczycielprzemiotu`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `grupalekcjinauczycielprzemiotu` AS select `dziennik szkolny`.`grupalekcji`.`ID` AS `glid`,`dziennik szkolny`.`nauczycielprzedmiotu`.`ID` AS `npid`,`dziennik szkolny`.`nauczycielprzedmiotu`.`nauczyciel_id` AS `nauczyciel_id` from (`grupalekcji` left join `nauczycielprzedmiotu` on(`dziennik szkolny`.`grupalekcji`.`nauczyciel_przedmiot_id` = `dziennik szkolny`.`nauczycielprzedmiotu`.`ID`));

-- Zrzut struktury widok dziennik szkolny.lekcja_info
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `lekcja_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lekcja_info` AS select `l`.`lekcja_ID` AS `lekcja_ID`,`l`.`temat` AS `temat`,`l`.`sala` AS `sala`,`gl`.`nauczyciel_przedmiot_id` AS `nauczyciel_przedmiot_id`,`gl`.`klasa_id` AS `klasa_id`,`cl`.`data` AS `data`,`cl`.`godz_start` AS `godz_start`,`cl`.`godz_koniec` AS `godz_koniec`,`gl`.`grupalekcji_ID` AS `grupalekcji_ID` from ((`lekcja` `l` join `grupalekcji` `gl` on(`l`.`grupa_lekcji_id` = `gl`.`grupalekcji_ID`)) left join `czas_lekcji` `cl` on(`l`.`czas_lekcji_id` = `cl`.`czas_lekcji_ID`));

-- Zrzut struktury widok dziennik szkolny.lista_nauczycieli
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `lista_nauczycieli`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lista_nauczycieli` AS select `nauczyciel`.`nauczyciel_ID` AS `ID`,`uzytkownik`.`nazwisko` AS `nazwisko`,`uzytkownik`.`imie` AS `imie`,`nauczyciel`.`nr_tel` AS `nr_tel`,`uzytkownik`.`email` AS `email`,`nauczycielprzedmiotu`.`przedmiot_nazwa` AS `przedmiot` from ((`nauczyciel` join `uzytkownik` on(`nauczyciel`.`uzytkownik_login` = `uzytkownik`.`uzytkownik_login`)) join `nauczycielprzedmiotu` on(`nauczyciel`.`nauczyciel_ID` = `nauczycielprzedmiotu`.`nauczyciel_id`));

-- Zrzut struktury widok dziennik szkolny.lista_rodzicow
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `lista_rodzicow`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lista_rodzicow` AS select `dziennik szkolny`.`uzytkownik`.`login` AS `login`,`dziennik szkolny`.`uzytkownik`.`nazwisko` AS `nazwisko`,`dziennik szkolny`.`uzytkownik`.`imie` AS `imie`,`dziennik szkolny`.`uzytkownik`.`haslo` AS `haslo`,`dziennik szkolny`.`uzytkownik`.`rodzaj` AS `rodzaj`,`dziennik szkolny`.`uzytkownik`.`email` AS `email` from `uzytkownik` where `dziennik szkolny`.`uzytkownik`.`rodzaj` = 'R';

-- Zrzut struktury widok dziennik szkolny.lista_uczniow
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `lista_uczniow`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lista_uczniow` AS select `dziennik szkolny`.`uczen`.`ID` AS `ID`,`dziennik szkolny`.`uzytkownik`.`imie` AS `imie`,`dziennik szkolny`.`uzytkownik`.`nazwisko` AS `nazwisko`,`dziennik szkolny`.`klasa`.`oddzial` AS `oddzial` from ((`uczen` join `uzytkownik` on(`dziennik szkolny`.`uczen`.`uzytkownik_login` = `dziennik szkolny`.`uzytkownik`.`login`)) join `klasa` on(`dziennik szkolny`.`uczen`.`klasa_id` = `dziennik szkolny`.`klasa`.`ID`));

-- Zrzut struktury widok dziennik szkolny.lista_uzytkownikow
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `lista_uzytkownikow`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lista_uzytkownikow` AS select `dziennik szkolny`.`uzytkownik`.`login` AS `login`,`dziennik szkolny`.`uzytkownik`.`haslo` AS `haslo`,`dziennik szkolny`.`uzytkownik`.`rodzaj` AS `rodzaj`,`dziennik szkolny`.`uzytkownik`.`email` AS `email` from `uzytkownik`;

-- Zrzut struktury widok dziennik szkolny.nauczyciel_info
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `nauczyciel_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `nauczyciel_info` AS select `lstn`.`ID` AS `ID`,`lstn`.`imie` AS `imie`,`lstn`.`nazwisko` AS `nazwisko`,`przedmiot`.`przedmiot_nazwa` AS `nazwa`,`grupalekcji`.`grupalekcji_ID` AS `gpid`,`np`.`nauczycielprzedmiotu_ID` AS `npid` from (((`nauczycielprzedmiotu` `np` join `grupalekcji` on(`np`.`nauczycielprzedmiotu_ID` = `grupalekcji`.`nauczyciel_przedmiot_id`)) join `przedmiot` on(`np`.`przedmiot_nazwa` = `przedmiot`.`przedmiot_nazwa`)) join `lista_nauczycieli` `lstn` on(`np`.`nauczyciel_id` = `lstn`.`ID`));

-- Zrzut struktury widok dziennik szkolny.rodzic_info
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `rodzic_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rodzic_info` AS select `r`.`rodzic_ID` AS `rodzic_ID`,`r`.`nr_telefonu` AS `nr_telefonu`,`u`.`uzytkownik_login` AS `uzytkownik_login`,`u`.`haslo` AS `haslo`,`u`.`imie` AS `imie`,`u`.`nazwisko` AS `nazwisko`,`u`.`email` AS `email`,`r`.`opiekunowie_id` AS `opiekunowie_id` from (`rodzic` `r` left join `uzytkownik` `u` on(`r`.`uzytkownik_login` = `u`.`uzytkownik_login`));

-- Zrzut struktury widok dziennik szkolny.uczen_info
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `uczen_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `uczen_info` AS select `ucz`.`uczen_ID` AS `uczen_ID`,`ucz`.`pesel` AS `pesel`,`ucz`.`klasa_id` AS `klasa_id`,`ucz`.`opiekunowie_id` AS `opiekunowie_id`,`u`.`uzytkownik_login` AS `uzytkownik_login`,`u`.`haslo` AS `haslo`,`u`.`imie` AS `imie`,`u`.`nazwisko` AS `nazwisko`,`u`.`email` AS `email` from (`uczen` `ucz` join `uzytkownik` `u` on(`ucz`.`uzytkownik_login` = `u`.`uzytkownik_login`));

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
