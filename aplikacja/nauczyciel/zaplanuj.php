<?php


if(isset($_GET['id_lekcji']) and isset($_GET['opis']) and isset($_GET['typ']))
{
	require_once "../connect.php";
		
	$conn=new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
	
	if ($conn->connect_errno)
	{
		echo "Error: ".$conn->connect_errno;
	}
	
	
	$id_lekcji = $_GET['id_lekcji'];
	$opis = $_GET['opis'];
	$typ = $_GET['typ'];
	$conn->query("INSERT INTO terminarz (typ, lekcja_id, opis) VALUES ('$typ','$id_lekcji','$opis')");
	$conn->close();
}			 
?>