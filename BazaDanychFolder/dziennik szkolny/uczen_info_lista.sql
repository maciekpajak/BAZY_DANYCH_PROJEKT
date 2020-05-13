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

-- Zrzut struktury widok dziennik szkolny.uczen_info_lista
-- Usuwanie tabeli tymczasowej i tworzenie ostatecznej struktury WIDOKU
DROP TABLE IF EXISTS `uczen_info_lista`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `uczen_info_lista` AS select `ucz`.`uczen_ID` AS `uczen_ID`,`k`.`oddzial` AS `oddzial`,`u`.`imie` AS `imie`,`u`.`nazwisko` AS `nazwisko`,`ucz`.`pesel` AS `pesel`,`u`.`email` AS `email`,`a`.`miejscowosc` AS `miejscowosc`,`a`.`kod` AS `kod`,`a`.`ulica` AS `ulica`,`a`.`nr_domu` AS `nr_domu`,`a`.`nr_mieszkania` AS `nr_mieszkania` from (((`uczen` `ucz` join `uzytkownik` `u` on(`ucz`.`uzytkownik_login` = `u`.`uzytkownik_login`)) join `adres_info_lista` `a` on(`ucz`.`adres_id` = `a`.`adres_ID`)) join `klasa` `k` on(`ucz`.`klasa_id` = `k`.`klasa_ID`));

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
