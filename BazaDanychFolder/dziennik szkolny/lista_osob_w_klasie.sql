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

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;