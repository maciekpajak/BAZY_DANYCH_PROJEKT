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

-- Zrzut struktury widok dziennik szkolny.adres_info_lista
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `adres_info_lista`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `adres_info_lista` AS select `adres`.`adres_ID` AS `adres_ID`,`miejscowosc`.`nazwa` AS `miejscowosc`,`um`.`kod` AS `kod`,`ulica`.`nazwa` AS `ulica`,`adres`.`nr_domu` AS `nr_domu`,`adres`.`nr_mieszkania` AS `nr_mieszkania` from (((`ulice_miejscowosci` `um` join `ulica` on(`um`.`ulica_id` = `ulica`.`ulica_ID`)) join `miejscowosc` on(`um`.`miejscowosc_id` = `miejscowosc`.`miejscowosc_ID`)) join `adres` on(`adres`.`ulice_miejscowosci_id` = `um`.`ulice_miejscowosci_ID`));

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
