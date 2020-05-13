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

-- Zrzut struktury widok dziennik szkolny.ocena_info_lista
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `ocena_info_lista`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ocena_info_lista` AS select `ocena`.`ocena_ID` AS `ocena_ID`,`ocena`.`stopien` AS `stopien`,`ocena`.`waga` AS `waga`,`ocena`.`opis` AS `opis`,`ocena`.`data` AS `data`,`ocena`.`uczen_id` AS `uczen_id`,`n`.`imie` AS `imie`,`n`.`nazwisko` AS `nazwisko`,`n`.`przedmiot` AS `przedmiot` from (`ocena` join `nauczyciel_info_lista` `n` on(`ocena`.`nauczyciel_przedmiotu_id` = `n`.`nauczyciel_przedmiotu_ID`));

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
