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

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
