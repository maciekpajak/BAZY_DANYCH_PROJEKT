-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Czas generowania: 21 Maj 2020, 08:38
-- Wersja serwera: 10.3.16-MariaDB
-- Wersja PHP: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `id13767441_dziennik`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `dzieci_rodzica` (IN `rodzic_id` INT)  select ulst.imie, ulst.nazwisko, ulst.klasa_id
from rodzic as r
join uczen_info_lista as ulst on rodzic.opiekunowie_id = ulst.opiekunowie_id
where rodzic.rodzic_ID = rodzic_id$$

CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `frekwencja_na_lekcji` (IN `lekcja_id` INT)  select u.imie, u.nazwisko, o.`status`
from obecnosc as o
join lekcja as l on o.lekcja_id = l.lekcja_ID
join uczen_info_lista as u on o.uczen_id = u.uczen_ID
where l.lekcja_ID = lekcja_id
order by u.nazwisko$$

CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `frekwencja_ucznia` (IN `uczen_id` INT)  select l.`data`, l.godz_start, l.godz_koniec, l.sala, l.przedmiot, l.imie, l.nazwisko, l.temat, o.`status`
from lekcja_info_lista as l
join obecnosc as o on l.lekcja_ID = o.lekcja_id
where o.uczen_id = uczen_id
order by l.`data`$$

CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `lekcje_nauczyciela` (IN `nauczyciel_id` INT)  select l.`data`, l.godz_start, l.godz_koniec, l.oddzial,l.sala,l.przedmiot
from nauczyciel_info_lista as n
join lekcja_info_lista as l on n.ID = l.nauczyciel_id and `l`.`przedmiot` = `n`.`przedmiot`
where n.ID = nauczyciel_id$$

CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `lista_osob_w_klasie` (IN `klasa_id` INT)  SELECT uzytkownik.imie AS 'imie', uzytkownik.nazwisko AS 'nazwisko', k.oddzial
FROM uczen as u
INNER JOIN klasa as k ON u.klasa_id = k.klasa_ID 
left JOIN uzytkownik ON u.uzytkownik_login = uzytkownik.uzytkownik_login
where k.klasa_ID =klasa_id
ORDER BY nazwisko ASC$$

CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `nauczyciele_przedmiotu` (IN `przedmiot_nazwa` VARCHAR(32))  select np.przedmiot_nazwa, nlst.imie, nlst.nazwisko, nlst.nr_tel, nlst.email
from nauczyciel_przedmiotu as np
join nauczyciel_info_lista as nlst on np.nauczyciel_id = nlst.ID and np.przedmiot_nazwa = nlst.przedmiot
where np.przedmiot_nazwa = przedmiot_nazwa$$

CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `oceny_ucznia` (IN `uczen_id` INT)  select * 
from ocena_info_lista as o
where o.uczen_id = uczen_id$$

CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `plan_lekcji_klasy` (IN `klasa_id` INT)  select *
from lekcja_info_lista as l
join klasa as k on l.oddzial = k.oddzial
where k.klasa_ID = klasa_id$$

CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `rodzice_ucznia` (IN `uczen_id` INT)  select rlst.imie, rlst.nazwisko, rlst.email, rlst.nr_telefonu
from opiekunowie
join uczen on opiekunowie.opiekunowie_ID = uczen.opiekunowie_id
join rodzic_info_lista as rlst on opiekunowie.opiekunowie_ID = rlst.opiekunowie_id
where uczen.uczen_ID = uczen_id$$

CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `rodzice_w_klasie` (IN `klasa_id` INT)  select rlst.imie, rlst.nazwisko, rlst.email, rlst.nr_telefonu
from uczen_info_lista as ui
join rodzic_info_lista as rlst on ui.opiekunowie_id = rlst.opiekunowie_id
where ui.klasa_id = klasa_id$$

CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `rodzic_info` (IN `rodzic_id` INT)  select rlst.imie, rlst.nazwisko, rlst.email, rlst.nr_telefonu
from rodzic_info_lista as rlst
where rlst.rodzic_ID  = rodzic_id$$

CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `uczen_info` (IN `uczen_id` INT)  select * 
from uczen_info_lista
where uczen_info_lista.uczen_ID = uczen_id$$

CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `zmiana_hasla` (IN `uzytkownik_login` VARCHAR(16), IN `new_haslo` CHAR(32), IN `old_haslo` CHAR(32))  update uzytkownik 
set uzytkownik.haslo = new_haslo 
where uzytkownik.uzytkownik_login = uzytkownik_login$$

CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `zmiana_hasla_admin` (IN `new_haslo` CHAR(32), IN `uzytkownik_login` VARCHAR(16))  update uzytkownik 
set uzytkownik.haslo = new_haslo 
where uzytkownik.uzytkownik_login = uzytkownik_login$$

CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `zmiana_obecnosci_ucznia` (IN `uczen_id` INT, IN `lekcja_id` INT, IN `new_status` ENUM('obecny','nieobecny','spóźniony'))  update obecnosc set obecnosc.`status` = new_status where obecnosc.uczen = uczen_id and obecnosc.lekcja = lekcja_id$$

CREATE DEFINER=`id13767441_dzienn`@`%` PROCEDURE `zmiana_tematu_lekcji` (IN `lekcja_id` INT, IN `new_temat` VARCHAR(250))  update lekcja set lekcja.temat = new_temat where lekcja.ID = lekcja_id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `adres`
--

CREATE TABLE `adres` (
  `adres_ID` int(3) UNSIGNED ZEROFILL NOT NULL,
  `ulice_miejscowosci_id` int(6) UNSIGNED ZEROFILL NOT NULL,
  `nr_domu` varchar(6) COLLATE utf8_polish_ci NOT NULL,
  `nr_mieszkania` varchar(4) COLLATE utf8_polish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `adres`
--

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

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `adres_info_lista`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `adres_info_lista` (
`adres_ID` int(3) unsigned zerofill
,`miejscowosc` varchar(30)
,`kod` int(5) unsigned
,`ulica` varchar(30)
,`nr_domu` varchar(6)
,`nr_mieszkania` varchar(4)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `czas_lekcji`
--

CREATE TABLE `czas_lekcji` (
  `czas_lekcji_ID` int(5) UNSIGNED ZEROFILL NOT NULL,
  `data` date NOT NULL DEFAULT '0000-00-00',
  `godz_start` time NOT NULL DEFAULT '00:00:00',
  `godz_koniec` time NOT NULL DEFAULT '00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `czas_lekcji`
--

INSERT INTO `czas_lekcji` (`czas_lekcji_ID`, `data`, `godz_start`, `godz_koniec`) VALUES
(00001, '2020-05-08', '14:00:00', '14:45:00'),
(00002, '2020-05-08', '15:00:00', '15:45:00'),
(00003, '2020-05-09', '14:00:00', '14:45:00'),
(00004, '2020-05-09', '15:00:00', '15:45:00'),
(00005, '2020-05-10', '14:00:00', '14:45:00');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `grupa_lekcji`
--

CREATE TABLE `grupa_lekcji` (
  `grupa_lekcji_ID` int(5) UNSIGNED ZEROFILL NOT NULL,
  `klasa_id` int(2) UNSIGNED ZEROFILL NOT NULL,
  `nauczyciel_przedmiot_id` int(3) UNSIGNED ZEROFILL NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `grupa_lekcji`
--

INSERT INTO `grupa_lekcji` (`grupa_lekcji_ID`, `klasa_id`, `nauczyciel_przedmiot_id`) VALUES
(00001, 07, 001),
(00002, 01, 003),
(00003, 07, 002);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `klasa`
--

CREATE TABLE `klasa` (
  `klasa_ID` int(2) UNSIGNED ZEROFILL NOT NULL,
  `oddzial` varchar(3) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `klasa`
--

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

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `lekcja`
--

CREATE TABLE `lekcja` (
  `lekcja_ID` int(5) UNSIGNED ZEROFILL NOT NULL,
  `temat` varchar(250) COLLATE utf8_polish_ci NOT NULL,
  `sala` int(2) UNSIGNED NOT NULL,
  `grupa_lekcji_id` int(3) UNSIGNED ZEROFILL NOT NULL,
  `czas_lekcji_id` int(5) UNSIGNED ZEROFILL NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `lekcja`
--

INSERT INTO `lekcja` (`lekcja_ID`, `temat`, `sala`, `grupa_lekcji_id`, `czas_lekcji_id`) VALUES
(00001, 'To jest nowy temat lekcji wywołany przez procedurę zmiana_tematu_lekcji', 12, 001, 00001),
(00002, 'Temat', 12, 002, 00001),
(00003, 'Temat', 12, 003, 00001),
(00004, 'Temat', 12, 001, 00002),
(00005, 'Temat', 12, 002, 00002),
(00006, 'Temat', 12, 003, 00002),
(00007, 'Procedury, widoki, wyzwalacze i indeksy', 12, 002, 00004);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `lekcja_info_lista`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `lekcja_info_lista` (
`lekcja_ID` int(5) unsigned zerofill
,`data` date
,`godz_start` time
,`godz_koniec` time
,`oddzial` varchar(3)
,`sala` int(2) unsigned
,`przedmiot` varchar(32)
,`imie` varchar(20)
,`nazwisko` varchar(30)
,`temat` varchar(250)
,`nauczyciel_id` int(2) unsigned zerofill
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `miejscowosc`
--

CREATE TABLE `miejscowosc` (
  `miejscowosc_ID` int(3) UNSIGNED ZEROFILL NOT NULL,
  `nazwa` varchar(30) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `miejscowosc`
--

INSERT INTO `miejscowosc` (`miejscowosc_ID`, `nazwa`) VALUES
(001, 'Wrocław'),
(002, 'Oborniki Śląskie'),
(003, 'Oława'),
(004, 'Kamieniec Wrocławski'),
(005, 'Oleśnica'),
(006, 'Trzebnica');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `nauczyciel`
--

CREATE TABLE `nauczyciel` (
  `nauczyciel_ID` int(2) UNSIGNED ZEROFILL NOT NULL,
  `uzytkownik_login` varchar(16) COLLATE utf8_polish_ci NOT NULL,
  `nr_tel` char(50) COLLATE utf8_polish_ci NOT NULL,
  `czy_wych` enum('Y','N') COLLATE utf8_polish_ci NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `nauczyciel`
--

INSERT INTO `nauczyciel` (`nauczyciel_ID`, `uzytkownik_login`, `nr_tel`, `czy_wych`) VALUES
(01, 'N0001', '111111111', 'N'),
(02, 'N0002', '111111111', 'N');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `nauczyciel_info_lista`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `nauczyciel_info_lista` (
`ID` int(2) unsigned zerofill
,`nazwisko` varchar(30)
,`imie` varchar(20)
,`nr_tel` char(50)
,`email` varchar(32)
,`przedmiot` varchar(32)
,`nauczyciel_przedmiotu_ID` int(3) unsigned zerofill
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `nauczyciel_przedmiotu`
--

CREATE TABLE `nauczyciel_przedmiotu` (
  `nauczyciel_przedmiotu_ID` int(3) UNSIGNED ZEROFILL NOT NULL,
  `nauczyciel_id` int(2) UNSIGNED ZEROFILL NOT NULL,
  `przedmiot_nazwa` varchar(32) COLLATE utf8_polish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `nauczyciel_przedmiotu`
--

INSERT INTO `nauczyciel_przedmiotu` (`nauczyciel_przedmiotu_ID`, `nauczyciel_id`, `przedmiot_nazwa`) VALUES
(001, 01, 'WOS'),
(002, 01, 'historia'),
(003, 02, 'matematyka');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `obecnosc`
--

CREATE TABLE `obecnosc` (
  `obecnosc_ID` int(7) UNSIGNED ZEROFILL NOT NULL,
  `status` enum('obecny','nieobecny','spóźniony') COLLATE utf8_polish_ci NOT NULL DEFAULT 'obecny',
  `uczen_id` int(3) UNSIGNED ZEROFILL NOT NULL,
  `lekcja_id` int(5) UNSIGNED ZEROFILL NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `obecnosc`
--

INSERT INTO `obecnosc` (`obecnosc_ID`, `status`, `uczen_id`, `lekcja_id`) VALUES
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

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ocena`
--

CREATE TABLE `ocena` (
  `ocena_ID` int(6) UNSIGNED ZEROFILL NOT NULL,
  `stopien` enum('brak','ndst','dop','dst','db','bdb','cel') COLLATE utf8_polish_ci NOT NULL,
  `waga` int(1) UNSIGNED NOT NULL DEFAULT 1,
  `opis` varchar(100) COLLATE utf8_polish_ci NOT NULL DEFAULT '',
  `data` date NOT NULL,
  `uczen_id` int(3) UNSIGNED ZEROFILL NOT NULL,
  `nauczyciel_przedmiotu_id` int(3) UNSIGNED ZEROFILL NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `ocena`
--

INSERT INTO `ocena` (`ocena_ID`, `stopien`, `waga`, `opis`, `data`, `uczen_id`, `nauczyciel_przedmiotu_id`) VALUES
(000001, 'dop', 3, '', '2020-04-29', 001, 001),
(000002, 'db', 1, '', '2020-04-29', 003, 002),
(000003, 'ndst', 2, '', '2020-04-29', 001, 003),
(000004, 'cel', 1, '', '2020-04-29', 002, 001),
(000005, 'dst', 1, '', '2020-04-29', 003, 002),
(000006, 'db', 1, '', '2020-04-29', 001, 003),
(000007, 'bdb', 8, '', '2020-04-29', 002, 003),
(000008, 'db', 1, '', '2020-04-29', 003, 001);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `ocena_info_lista`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `ocena_info_lista` (
`ocena_ID` int(6) unsigned zerofill
,`stopien` enum('brak','ndst','dop','dst','db','bdb','cel')
,`waga` int(1) unsigned
,`opis` varchar(100)
,`data` date
,`uczen_id` int(3) unsigned zerofill
,`imie` varchar(20)
,`nazwisko` varchar(30)
,`przedmiot` varchar(32)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `opiekunowie`
--

CREATE TABLE `opiekunowie` (
  `opiekunowie_ID` int(3) UNSIGNED ZEROFILL NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `opiekunowie`
--

INSERT INTO `opiekunowie` (`opiekunowie_ID`) VALUES
(001),
(002),
(003),
(004),
(005),
(006);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `przedmiot`
--

CREATE TABLE `przedmiot` (
  `przedmiot_nazwa` varchar(32) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `przedmiot`
--

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

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rodzic`
--

CREATE TABLE `rodzic` (
  `rodzic_ID` int(3) UNSIGNED ZEROFILL NOT NULL,
  `uzytkownik_login` varchar(16) COLLATE utf8_polish_ci NOT NULL,
  `nr_telefonu` varchar(12) COLLATE utf8_polish_ci DEFAULT NULL,
  `opiekunowie_id` int(3) UNSIGNED ZEROFILL NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `rodzic`
--

INSERT INTO `rodzic` (`rodzic_ID`, `uzytkownik_login`, `nr_telefonu`, `opiekunowie_id`) VALUES
(001, 'R0001', '12313', 001),
(002, 'R0002', '12313', 001),
(003, 'R0003', '12313', 002),
(004, 'R0004', '12313', 002),
(005, 'R0005', '12313', 003),
(006, 'R0006', '12313', 003);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `rodzic_info_lista`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `rodzic_info_lista` (
`rodzic_ID` int(3) unsigned zerofill
,`nr_telefonu` varchar(12)
,`imie` varchar(20)
,`nazwisko` varchar(30)
,`email` varchar(32)
,`opiekunowie_id` int(3) unsigned zerofill
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `rodzic_info_lista1`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `rodzic_info_lista1` (
`rodzic_ID` int(3) unsigned zerofill
,`nr_telefonu` varchar(12)
,`imie` varchar(20)
,`nazwisko` varchar(30)
,`email` varchar(32)
,`opiekunowie_id` int(3) unsigned zerofill
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uczen`
--

CREATE TABLE `uczen` (
  `uczen_ID` int(3) UNSIGNED ZEROFILL NOT NULL,
  `pesel` char(11) CHARACTER SET latin1 NOT NULL,
  `adres_id` int(3) UNSIGNED ZEROFILL NOT NULL,
  `klasa_id` int(2) UNSIGNED ZEROFILL NOT NULL,
  `opiekunowie_id` int(3) UNSIGNED ZEROFILL NOT NULL,
  `uzytkownik_login` varchar(16) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `uczen`
--

INSERT INTO `uczen` (`uczen_ID`, `pesel`, `adres_id`, `klasa_id`, `opiekunowie_id`, `uzytkownik_login`) VALUES
(001, '99999999999', 009, 07, 001, 'U0001'),
(002, '99999999998', 009, 02, 002, 'U0002'),
(003, '99999999997', 008, 07, 003, 'U0003');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `uczen_info_lista`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `uczen_info_lista` (
`uczen_ID` int(3) unsigned zerofill
,`oddzial` varchar(3)
,`imie` varchar(20)
,`nazwisko` varchar(30)
,`pesel` char(11)
,`email` varchar(32)
,`miejscowosc` varchar(30)
,`kod` int(5) unsigned
,`ulica` varchar(30)
,`nr_domu` varchar(6)
,`nr_mieszkania` varchar(4)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ulica`
--

CREATE TABLE `ulica` (
  `ulica_ID` int(3) UNSIGNED ZEROFILL NOT NULL,
  `nazwa` varchar(30) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `ulica`
--

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

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ulice_miejscowosci`
--

CREATE TABLE `ulice_miejscowosci` (
  `ulice_miejscowosci_ID` int(6) UNSIGNED ZEROFILL NOT NULL,
  `miejscowosc_id` int(3) UNSIGNED ZEROFILL NOT NULL,
  `ulica_id` int(3) UNSIGNED ZEROFILL NOT NULL,
  `kod` int(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `ulice_miejscowosci`
--

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

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uzytkownik`
--

CREATE TABLE `uzytkownik` (
  `uzytkownik_login` varchar(16) COLLATE utf8_polish_ci NOT NULL,
  `nazwisko` varchar(30) COLLATE utf8_polish_ci NOT NULL,
  `imie` varchar(20) COLLATE utf8_polish_ci NOT NULL,
  `haslo` char(32) COLLATE utf8_polish_ci NOT NULL,
  `str` char(32) COLLATE utf8_polish_ci DEFAULT 'safsdf',
  `rodzaj` enum('U','N','R','I','A') COLLATE utf8_polish_ci DEFAULT 'I',
  `email` varchar(32) COLLATE utf8_polish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `uzytkownik`
--

INSERT INTO `uzytkownik` (`uzytkownik_login`, `nazwisko`, `imie`, `haslo`, `str`, `rodzaj`, `email`) VALUES
('adad', 'adsasd', 'asdsad', 'asdasd', 'safsdf', 'U', NULL),
('adm', 'aaa', 'vvv', 'root', NULL, 'A', NULL),
('N0001', 'Trąba', 'Wiktor', '897n23nx723', 'safsdf', 'N', NULL),
('N0002', 'Ameba', 'Adam', '189fb7613', 'safsdf', 'N', NULL),
('N0003', 'Koch', 'Paweł', 'afsgfsgrw', 'safsdf', 'N', NULL),
('R0001', 'Nowak', 'Ewelina', '21n83h3f', 'safsdf', 'R', NULL),
('R0002', 'Nowak', 'Wojciech', '120389f7fn', 'safsdf', 'R', NULL),
('R0003', 'Kowalski', 'Edward', '321', 'safsdf', 'R', NULL),
('R0004', 'Kowalska', 'Hanna', 'o1398nh7', 'safsdf', 'R', NULL),
('R0005', 'Grzyb', 'Adam', '1309ab8ds', 'safsdf', 'R', NULL),
('R0006', 'Grzyb', 'Natalia', '1833b7v64', 'safsdf', 'R', NULL),
('U0001', 'Nowak', 'Michał', 'ADOafgh', 'safsdf', 'U', NULL),
('U0002', 'Kowalski', 'Maksymilian', 'akjgfaify23', 'safsdf', 'U', NULL),
('U0003', 'Grzyb', 'Aleksander', '123', 'safsdf', 'U', NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `wersja`
--

CREATE TABLE `wersja` (
  `id` int(10) UNSIGNED NOT NULL,
  `major` int(10) UNSIGNED DEFAULT 0,
  `minor` int(10) UNSIGNED DEFAULT 0,
  `data` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `wersja`
--

INSERT INTO `wersja` (`id`, `major`, `minor`, `data`) VALUES
(1, 1, 0, '2020-05-13 17:31:38');

-- --------------------------------------------------------

--
-- Struktura widoku `adres_info_lista`
--
DROP TABLE IF EXISTS `adres_info_lista`;

CREATE ALGORITHM=UNDEFINED DEFINER=`id13767441_dzienn`@`%` SQL SECURITY DEFINER VIEW `adres_info_lista`  AS  select `adres`.`adres_ID` AS `adres_ID`,`miejscowosc`.`nazwa` AS `miejscowosc`,`um`.`kod` AS `kod`,`ulica`.`nazwa` AS `ulica`,`adres`.`nr_domu` AS `nr_domu`,`adres`.`nr_mieszkania` AS `nr_mieszkania` from (((`ulice_miejscowosci` `um` join `ulica` on(`um`.`ulica_id` = `ulica`.`ulica_ID`)) join `miejscowosc` on(`um`.`miejscowosc_id` = `miejscowosc`.`miejscowosc_ID`)) join `adres` on(`adres`.`ulice_miejscowosci_id` = `um`.`ulice_miejscowosci_ID`)) ;

-- --------------------------------------------------------

--
-- Struktura widoku `lekcja_info_lista`
--
DROP TABLE IF EXISTS `lekcja_info_lista`;

CREATE ALGORITHM=UNDEFINED DEFINER=`id13767441_dzienn`@`%` SQL SECURITY DEFINER VIEW `lekcja_info_lista`  AS  select `l`.`lekcja_ID` AS `lekcja_ID`,`c`.`data` AS `data`,`c`.`godz_start` AS `godz_start`,`c`.`godz_koniec` AS `godz_koniec`,`o`.`oddzial` AS `oddzial`,`l`.`sala` AS `sala`,`o`.`przedmiot` AS `przedmiot`,`o`.`imie` AS `imie`,`o`.`nazwisko` AS `nazwisko`,`l`.`temat` AS `temat`,`o`.`ID` AS `nauczyciel_id` from ((`lekcja` `l` join `czas_lekcji` `c` on(`l`.`czas_lekcji_id` = `c`.`czas_lekcji_ID`)) join (select `gr`.`grupa_lekcji_ID` AS `grupa_lekcji_ID`,`k`.`oddzial` AS `oddzial`,`nlst`.`imie` AS `imie`,`nlst`.`nazwisko` AS `nazwisko`,`nlst`.`przedmiot` AS `przedmiot`,`nlst`.`ID` AS `ID` from ((`grupa_lekcji` `gr` join `nauczyciel_info_lista` `nlst` on(`gr`.`nauczyciel_przedmiot_id` = `nlst`.`nauczyciel_przedmiotu_ID`)) join `klasa` `k` on(`gr`.`klasa_id` = `k`.`klasa_ID`))) `o` on(`l`.`grupa_lekcji_id` = `o`.`grupa_lekcji_ID`)) ;

-- --------------------------------------------------------

--
-- Struktura widoku `nauczyciel_info_lista`
--
DROP TABLE IF EXISTS `nauczyciel_info_lista`;

CREATE ALGORITHM=UNDEFINED DEFINER=`id13767441_dzienn`@`%` SQL SECURITY DEFINER VIEW `nauczyciel_info_lista`  AS  select `nauczyciel`.`nauczyciel_ID` AS `ID`,`uzytkownik`.`nazwisko` AS `nazwisko`,`uzytkownik`.`imie` AS `imie`,`nauczyciel`.`nr_tel` AS `nr_tel`,`uzytkownik`.`email` AS `email`,`nauczyciel_przedmiotu`.`przedmiot_nazwa` AS `przedmiot`,`nauczyciel_przedmiotu`.`nauczyciel_przedmiotu_ID` AS `nauczyciel_przedmiotu_ID` from ((`nauczyciel` join `uzytkownik` on(`nauczyciel`.`uzytkownik_login` = `uzytkownik`.`uzytkownik_login`)) join `nauczyciel_przedmiotu` on(`nauczyciel`.`nauczyciel_ID` = `nauczyciel_przedmiotu`.`nauczyciel_id`)) ;

-- --------------------------------------------------------

--
-- Struktura widoku `ocena_info_lista`
--
DROP TABLE IF EXISTS `ocena_info_lista`;

CREATE ALGORITHM=UNDEFINED DEFINER=`id13767441_dzienn`@`%` SQL SECURITY DEFINER VIEW `ocena_info_lista`  AS  select `ocena`.`ocena_ID` AS `ocena_ID`,`ocena`.`stopien` AS `stopien`,`ocena`.`waga` AS `waga`,`ocena`.`opis` AS `opis`,`ocena`.`data` AS `data`,`ocena`.`uczen_id` AS `uczen_id`,`n`.`imie` AS `imie`,`n`.`nazwisko` AS `nazwisko`,`n`.`przedmiot` AS `przedmiot` from (`ocena` join `nauczyciel_info_lista` `n` on(`ocena`.`nauczyciel_przedmiotu_id` = `n`.`nauczyciel_przedmiotu_ID`)) ;

-- --------------------------------------------------------

--
-- Struktura widoku `rodzic_info_lista`
--
DROP TABLE IF EXISTS `rodzic_info_lista`;

CREATE ALGORITHM=UNDEFINED DEFINER=`id13767441_dzienn`@`%` SQL SECURITY DEFINER VIEW `rodzic_info_lista`  AS  select `r`.`rodzic_ID` AS `rodzic_ID`,`r`.`nr_telefonu` AS `nr_telefonu`,`u`.`imie` AS `imie`,`u`.`nazwisko` AS `nazwisko`,`u`.`email` AS `email`,`r`.`opiekunowie_id` AS `opiekunowie_id` from (`rodzic` `r` left join `uzytkownik` `u` on(`r`.`uzytkownik_login` = `u`.`uzytkownik_login`)) ;

-- --------------------------------------------------------

--
-- Struktura widoku `rodzic_info_lista1`
--
DROP TABLE IF EXISTS `rodzic_info_lista1`;

CREATE ALGORITHM=UNDEFINED DEFINER=`id13767441_dzienn`@`%` SQL SECURITY DEFINER VIEW `rodzic_info_lista1`  AS  select `r`.`rodzic_ID` AS `rodzic_ID`,`r`.`nr_telefonu` AS `nr_telefonu`,`u`.`imie` AS `imie`,`u`.`nazwisko` AS `nazwisko`,`u`.`email` AS `email`,`r`.`opiekunowie_id` AS `opiekunowie_id` from (`rodzic` `r` left join `uzytkownik` `u` on(`r`.`uzytkownik_login` = `u`.`uzytkownik_login`)) ;

-- --------------------------------------------------------

--
-- Struktura widoku `uczen_info_lista`
--
DROP TABLE IF EXISTS `uczen_info_lista`;

CREATE ALGORITHM=UNDEFINED DEFINER=`id13767441_dzienn`@`%` SQL SECURITY DEFINER VIEW `uczen_info_lista`  AS  select `ucz`.`uczen_ID` AS `uczen_ID`,`k`.`oddzial` AS `oddzial`,`u`.`imie` AS `imie`,`u`.`nazwisko` AS `nazwisko`,`ucz`.`pesel` AS `pesel`,`u`.`email` AS `email`,`a`.`miejscowosc` AS `miejscowosc`,`a`.`kod` AS `kod`,`a`.`ulica` AS `ulica`,`a`.`nr_domu` AS `nr_domu`,`a`.`nr_mieszkania` AS `nr_mieszkania` from (((`uczen` `ucz` join `uzytkownik` `u` on(`ucz`.`uzytkownik_login` = `u`.`uzytkownik_login`)) join `adres_info_lista` `a` on(`ucz`.`adres_id` = `a`.`adres_ID`)) join `klasa` `k` on(`ucz`.`klasa_id` = `k`.`klasa_ID`)) ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `adres`
--
ALTER TABLE `adres`
  ADD PRIMARY KEY (`adres_ID`),
  ADD UNIQUE KEY `ID` (`adres_ID`),
  ADD KEY `FK_adres_ulice_miejscowosci` (`ulice_miejscowosci_id`);

--
-- Indeksy dla tabeli `czas_lekcji`
--
ALTER TABLE `czas_lekcji`
  ADD PRIMARY KEY (`czas_lekcji_ID`),
  ADD UNIQUE KEY `ID` (`czas_lekcji_ID`);

--
-- Indeksy dla tabeli `grupa_lekcji`
--
ALTER TABLE `grupa_lekcji`
  ADD PRIMARY KEY (`grupa_lekcji_ID`),
  ADD UNIQUE KEY `ID` (`grupa_lekcji_ID`),
  ADD KEY `FK_grupa_lekcji_klasa` (`klasa_id`),
  ADD KEY `FK_grupa_lekcji_nauczyciel_przedmiotu` (`nauczyciel_przedmiot_id`);

--
-- Indeksy dla tabeli `klasa`
--
ALTER TABLE `klasa`
  ADD PRIMARY KEY (`klasa_ID`),
  ADD UNIQUE KEY `ID` (`klasa_ID`);

--
-- Indeksy dla tabeli `lekcja`
--
ALTER TABLE `lekcja`
  ADD PRIMARY KEY (`lekcja_ID`),
  ADD UNIQUE KEY `lekcja_id` (`lekcja_ID`) USING BTREE,
  ADD KEY `FK_lekcja_grupa_lekcji` (`grupa_lekcji_id`),
  ADD KEY `FK_lekcja_czas_lekcji` (`czas_lekcji_id`);

--
-- Indeksy dla tabeli `miejscowosc`
--
ALTER TABLE `miejscowosc`
  ADD PRIMARY KEY (`miejscowosc_ID`),
  ADD UNIQUE KEY `ID` (`miejscowosc_ID`);

--
-- Indeksy dla tabeli `nauczyciel`
--
ALTER TABLE `nauczyciel`
  ADD PRIMARY KEY (`nauczyciel_ID`),
  ADD UNIQUE KEY `ID` (`nauczyciel_ID`),
  ADD UNIQUE KEY `uzytkownik_login` (`uzytkownik_login`);

--
-- Indeksy dla tabeli `nauczyciel_przedmiotu`
--
ALTER TABLE `nauczyciel_przedmiotu`
  ADD PRIMARY KEY (`nauczyciel_przedmiotu_ID`),
  ADD UNIQUE KEY `ID` (`nauczyciel_przedmiotu_ID`),
  ADD KEY `FK_nauczyciel_przedmiotu_przedmiot` (`przedmiot_nazwa`),
  ADD KEY `FK_nauczyciel_przedmiotu_nauczyciel` (`nauczyciel_id`);

--
-- Indeksy dla tabeli `obecnosc`
--
ALTER TABLE `obecnosc`
  ADD PRIMARY KEY (`obecnosc_ID`),
  ADD UNIQUE KEY `obecność_id` (`obecnosc_ID`) USING BTREE,
  ADD KEY `uczen` (`uczen_id`),
  ADD KEY `lekcja` (`lekcja_id`);

--
-- Indeksy dla tabeli `ocena`
--
ALTER TABLE `ocena`
  ADD PRIMARY KEY (`ocena_ID`),
  ADD UNIQUE KEY `Indeks 1` (`ocena_ID`) USING BTREE,
  ADD KEY `nauczyciel` (`nauczyciel_przedmiotu_id`),
  ADD KEY `uczen` (`uczen_id`);

--
-- Indeksy dla tabeli `opiekunowie`
--
ALTER TABLE `opiekunowie`
  ADD PRIMARY KEY (`opiekunowie_ID`),
  ADD UNIQUE KEY `ID` (`opiekunowie_ID`);

--
-- Indeksy dla tabeli `przedmiot`
--
ALTER TABLE `przedmiot`
  ADD PRIMARY KEY (`przedmiot_nazwa`),
  ADD UNIQUE KEY `przedmiot_nazwa` (`przedmiot_nazwa`);

--
-- Indeksy dla tabeli `rodzic`
--
ALTER TABLE `rodzic`
  ADD PRIMARY KEY (`rodzic_ID`),
  ADD UNIQUE KEY `ID` (`rodzic_ID`),
  ADD UNIQUE KEY `uzytkownik_login` (`uzytkownik_login`),
  ADD KEY `powiazanie` (`opiekunowie_id`);

--
-- Indeksy dla tabeli `uczen`
--
ALTER TABLE `uczen`
  ADD PRIMARY KEY (`uczen_ID`),
  ADD UNIQUE KEY `ID` (`uczen_ID`,`pesel`),
  ADD UNIQUE KEY `uzytkownik_login` (`uzytkownik_login`),
  ADD KEY `powiazanie` (`opiekunowie_id`),
  ADD KEY `uzytkownik` (`uzytkownik_login`),
  ADD KEY `klasa` (`klasa_id`),
  ADD KEY `FK_uczen_adres` (`adres_id`);

--
-- Indeksy dla tabeli `ulica`
--
ALTER TABLE `ulica`
  ADD PRIMARY KEY (`ulica_ID`),
  ADD UNIQUE KEY `ID` (`ulica_ID`);

--
-- Indeksy dla tabeli `ulice_miejscowosci`
--
ALTER TABLE `ulice_miejscowosci`
  ADD PRIMARY KEY (`ulice_miejscowosci_ID`),
  ADD UNIQUE KEY `ID` (`ulice_miejscowosci_ID`) USING BTREE,
  ADD KEY `FK_ulice_miejscowosci_miejscowosc` (`miejscowosc_id`),
  ADD KEY `FK_ulice_miejscowosci_ulica` (`ulica_id`);

--
-- Indeksy dla tabeli `uzytkownik`
--
ALTER TABLE `uzytkownik`
  ADD PRIMARY KEY (`uzytkownik_login`),
  ADD UNIQUE KEY `login` (`uzytkownik_login`);

--
-- Indeksy dla tabeli `wersja`
--
ALTER TABLE `wersja`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT dla tabel zrzutów
--

--
-- AUTO_INCREMENT dla tabeli `adres`
--
ALTER TABLE `adres`
  MODIFY `adres_ID` int(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT dla tabeli `czas_lekcji`
--
ALTER TABLE `czas_lekcji`
  MODIFY `czas_lekcji_ID` int(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT dla tabeli `grupa_lekcji`
--
ALTER TABLE `grupa_lekcji`
  MODIFY `grupa_lekcji_ID` int(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `lekcja`
--
ALTER TABLE `lekcja`
  MODIFY `lekcja_ID` int(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT dla tabeli `miejscowosc`
--
ALTER TABLE `miejscowosc`
  MODIFY `miejscowosc_ID` int(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT dla tabeli `nauczyciel`
--
ALTER TABLE `nauczyciel`
  MODIFY `nauczyciel_ID` int(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `nauczyciel_przedmiotu`
--
ALTER TABLE `nauczyciel_przedmiotu`
  MODIFY `nauczyciel_przedmiotu_ID` int(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `obecnosc`
--
ALTER TABLE `obecnosc`
  MODIFY `obecnosc_ID` int(7) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT dla tabeli `ocena`
--
ALTER TABLE `ocena`
  MODIFY `ocena_ID` int(6) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT dla tabeli `opiekunowie`
--
ALTER TABLE `opiekunowie`
  MODIFY `opiekunowie_ID` int(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT dla tabeli `rodzic`
--
ALTER TABLE `rodzic`
  MODIFY `rodzic_ID` int(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT dla tabeli `uczen`
--
ALTER TABLE `uczen`
  MODIFY `uczen_ID` int(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `ulica`
--
ALTER TABLE `ulica`
  MODIFY `ulica_ID` int(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT dla tabeli `ulice_miejscowosci`
--
ALTER TABLE `ulice_miejscowosci`
  MODIFY `ulice_miejscowosci_ID` int(6) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT dla tabeli `wersja`
--
ALTER TABLE `wersja`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `adres`
--
ALTER TABLE `adres`
  ADD CONSTRAINT `FK_adres_ulice_miejscowosci` FOREIGN KEY (`ulice_miejscowosci_id`) REFERENCES `ulice_miejscowosci` (`ulice_miejscowosci_ID`);

--
-- Ograniczenia dla tabeli `grupa_lekcji`
--
ALTER TABLE `grupa_lekcji`
  ADD CONSTRAINT `FK_grupa_lekcji_klasa` FOREIGN KEY (`klasa_id`) REFERENCES `klasa` (`klasa_ID`),
  ADD CONSTRAINT `FK_grupa_lekcji_nauczyciel_przedmiotu` FOREIGN KEY (`nauczyciel_przedmiot_id`) REFERENCES `nauczyciel_przedmiotu` (`nauczyciel_przedmiotu_ID`);

--
-- Ograniczenia dla tabeli `lekcja`
--
ALTER TABLE `lekcja`
  ADD CONSTRAINT `FK_lekcja_czas_lekcji` FOREIGN KEY (`czas_lekcji_id`) REFERENCES `czaslekcji` (`czaslekcji_ID`),
  ADD CONSTRAINT `FK_lekcja_grupa_lekcji` FOREIGN KEY (`grupa_lekcji_id`) REFERENCES `grupa_lekcji` (`grupa_lekcji_ID`);

--
-- Ograniczenia dla tabeli `nauczyciel`
--
ALTER TABLE `nauczyciel`
  ADD CONSTRAINT `FK_nauczyciel_uzytkownik_2` FOREIGN KEY (`uzytkownik_login`) REFERENCES `uzytkownik` (`uzytkownik_login`);

--
-- Ograniczenia dla tabeli `nauczyciel_przedmiotu`
--
ALTER TABLE `nauczyciel_przedmiotu`
  ADD CONSTRAINT `FK_nauczyciel_przedmiotu_nauczyciel` FOREIGN KEY (`nauczyciel_id`) REFERENCES `nauczyciel` (`nauczyciel_ID`),
  ADD CONSTRAINT `FK_nauczyciel_przedmiotu_przedmiot` FOREIGN KEY (`przedmiot_nazwa`) REFERENCES `przedmiot` (`przedmiot_nazwa`);

--
-- Ograniczenia dla tabeli `obecnosc`
--
ALTER TABLE `obecnosc`
  ADD CONSTRAINT `FK_obecnosc_lekcja` FOREIGN KEY (`lekcja_id`) REFERENCES `lekcja` (`lekcja_ID`),
  ADD CONSTRAINT `FK_obecnosc_uczen` FOREIGN KEY (`uczen_id`) REFERENCES `uczen` (`uczen_ID`);

--
-- Ograniczenia dla tabeli `ocena`
--
ALTER TABLE `ocena`
  ADD CONSTRAINT `FK_ocena_nauczyciel_przedmiotu` FOREIGN KEY (`nauczyciel_przedmiotu_id`) REFERENCES `nauczyciel_przedmiotu` (`nauczyciel_przedmiotu_ID`),
  ADD CONSTRAINT `FK_ocena_uczen` FOREIGN KEY (`uczen_id`) REFERENCES `uczen` (`uczen_ID`);

--
-- Ograniczenia dla tabeli `rodzic`
--
ALTER TABLE `rodzic`
  ADD CONSTRAINT `FK_rodzic_powiazanie` FOREIGN KEY (`opiekunowie_id`) REFERENCES `opiekunowie` (`opiekunowie_ID`),
  ADD CONSTRAINT `FK_rodzic_uzytkownik` FOREIGN KEY (`uzytkownik_login`) REFERENCES `uzytkownik` (`uzytkownik_login`);

--
-- Ograniczenia dla tabeli `uczen`
--
ALTER TABLE `uczen`
  ADD CONSTRAINT `FK_uczen_adres` FOREIGN KEY (`adres_id`) REFERENCES `adres` (`adres_ID`),
  ADD CONSTRAINT `FK_uczen_klasa` FOREIGN KEY (`klasa_id`) REFERENCES `klasa` (`klasa_ID`),
  ADD CONSTRAINT `FK_uczen_powiazanie` FOREIGN KEY (`opiekunowie_id`) REFERENCES `opiekunowie` (`opiekunowie_ID`),
  ADD CONSTRAINT `FK_uczen_uzytkownik` FOREIGN KEY (`uzytkownik_login`) REFERENCES `uzytkownik` (`uzytkownik_login`);

--
-- Ograniczenia dla tabeli `ulice_miejscowosci`
--
ALTER TABLE `ulice_miejscowosci`
  ADD CONSTRAINT `FK_ulice_miejscowosci_miejscowosc` FOREIGN KEY (`miejscowosc_id`) REFERENCES `miejscowosc` (`miejscowosc_ID`),
  ADD CONSTRAINT `FK_ulice_miejscowosci_ulica` FOREIGN KEY (`ulica_id`) REFERENCES `ulica` (`ulica_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
