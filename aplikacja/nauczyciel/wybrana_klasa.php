<?php
	session_start();
	
	if(isset($_GET['id_klasy']) and isset($_GET['id_lekcji']))
	{
		$_SESSION['id_klasy1']= $_GET['id_klasy'];
		$_SESSION['id_lekcji1']= $_GET['id_lekcji'];
	}
			 
?>