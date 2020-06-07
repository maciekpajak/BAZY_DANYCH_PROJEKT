<?php
	session_start();
	
	if(isset($_GET['typ']))
	{
		$_SESSION['typ']= $_GET['typ'];
	}
	if(isset($_GET['przedmiot']))
	{
		$_SESSION['przedmiot']= $_GET['przedmiot'];
	}	 
?>