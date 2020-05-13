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

-- Zrzut struktury widok dziennik szkolny.nauczyciel_info_lista
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `nauczyciel_info_lista`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `nauczyciel_info_lista` AS select `nauczyciel`.`nauczyciel_ID` AS `ID`,`uzytkownik`.`nazwisko` AS `nazwisko`,`uzytkownik`.`imie` AS `imie`,`nauczyciel`.`nr_tel` AS `nr_tel`,`uzytkownik`.`email` AS `email`,`nauczyciel_przedmiotu`.`przedmiot_nazwa` AS `przedmiot`,`nauczyciel_przedmiotu`.`nauczyciel_przedmiotu_ID` AS `nauczyciel_przedmiotu_ID` from ((`nauczyciel` join `uzytkownik` on(`nauczyciel`.`uzytkownik_login` = `uzytkownik`.`uzytkownik_login`)) join `nauczyciel_przedmiotu` on(`nauczyciel`.`nauczyciel_ID` = `nauczyciel_przedmiotu`.`nauczyciel_id`));

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
