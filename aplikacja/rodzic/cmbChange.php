<?php
	session_start();
	
	if(isset($_GET['id_wysw_ucznia']))
	{
		echo $_GET['id_wysw_ucznia'];
		$_SESSION['wybrane_dziecko_id']= $_GET['id_wysw_ucznia'];
	}
			 
?>