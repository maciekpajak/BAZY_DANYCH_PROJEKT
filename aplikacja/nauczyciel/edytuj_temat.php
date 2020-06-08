<?php


if(isset($_GET['id_lekcji']) and isset($_GET['temat']))
{
	require_once "../connect.php";
		
	$conn=new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
	
	if ($conn->connect_errno)
	{
		echo "Error: ".$conn->connect_errno;
	}
	
	
	$id_lekcji = $_GET['id_lekcji'];
	$temat= $_GET['temat'];
	$conn->query("UPDATE lekcja SET temat='$temat' WHERE lekcja_ID='$id_lekcji'");
	$conn->close();
}			 
?>