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

-- Zrzut struktury tabela dziennik szkolny.wersja
CREATE TABLE IF NOT EXISTS `wersja` (
  `wersja` varchar(10) COLLATE ucs2_polish_ci NOT NULL,
  `opis` varchar(500) COLLATE ucs2_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;

-- Zrzucanie danych dla tabeli dziennik szkolny.wersja: ~1 rows (około)
DELETE FROM `wersja`;
/*!40000 ALTER TABLE `wersja` DISABLE KEYS */;
INSERT INTO `wersja` (`wersja`, `opis`) VALUES
	('v3.0', 'Wersja wyjściowa.\r\nPo zmianach w bazie danych należy dodać kolejny rekord wersji:\r\n- przy dużych zmianach należy powiększyć liczbę przed pierwszą kropką o 1\r\n- przy małych zmianach należy powiększyć liczbę przed drugą kropką o 1\r\n- kolejne liczby po kolejnych kropkach dodawać w razie potrzeby');
/*!40000 ALTER TABLE `wersja` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
