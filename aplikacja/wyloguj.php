<?php
	session_start();
	
	
		unset($_SESSION['uzytkownik_login']);
		unset($_SESSION['haslo']);
		header('Location: index.php');
	?>