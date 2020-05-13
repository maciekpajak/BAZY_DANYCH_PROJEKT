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

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
