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

-- Zrzut struktury widok dziennik szkolny.lekcja_info_lista
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `lekcja_info_lista`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lekcja_info_lista` AS select `l`.`lekcja_ID` AS `lekcja_ID`,`c`.`data` AS `data`,`c`.`godz_start` AS `godz_start`,`c`.`godz_koniec` AS `godz_koniec`,`o`.`oddzial` AS `oddzial`,`l`.`sala` AS `sala`,`o`.`przedmiot` AS `przedmiot`,`o`.`imie` AS `imie`,`o`.`nazwisko` AS `nazwisko`,`l`.`temat` AS `temat`,`o`.`ID` AS `nauczyciel_id` from ((`dziennik szkolny`.`lekcja` `l` join `dziennik szkolny`.`czas_lekcji` `c` on(`l`.`czas_lekcji_id` = `c`.`czas_lekcji_ID`)) join (select `gr`.`grupa_lekcji_ID` AS `grupa_lekcji_ID`,`k`.`oddzial` AS `oddzial`,`nlst`.`imie` AS `imie`,`nlst`.`nazwisko` AS `nazwisko`,`nlst`.`przedmiot` AS `przedmiot`,`nlst`.`ID` AS `ID` from ((`dziennik szkolny`.`grupa_lekcji` `gr` join `dziennik szkolny`.`nauczyciel_info_lista` `nlst` on(`gr`.`nauczyciel_przedmiot_id` = `nlst`.`nauczyciel_przedmiotu_ID`)) join `dziennik szkolny`.`klasa` `k` on(`gr`.`klasa_id` = `k`.`klasa_ID`))) `o` on(`l`.`grupa_lekcji_id` = `o`.`grupa_lekcji_ID`));

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
