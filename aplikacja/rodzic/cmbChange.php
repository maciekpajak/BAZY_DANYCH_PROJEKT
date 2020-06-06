<?php
	session_start();
	
	if(isset($_GET['id']))
	{
		echo $_GET['id'];
		$_SESSION['wybrane_dziecko_id']= $_GET['id'];
	}
			 
?>