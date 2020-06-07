<?php
	session_start();
	
	if(isset($_GET['id_klasy']))
	{
		$_SESSION['klasa_do_pokazu']= $_GET['id_klasy'];
	}
			 
?>