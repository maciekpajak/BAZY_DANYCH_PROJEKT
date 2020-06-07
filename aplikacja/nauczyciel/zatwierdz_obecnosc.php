<?php

session_start();

$conn=new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 

$id_lekcji = $_SESSION['id_lekcji1'];
if(isset($_POST['lista_uczniow'])){
	
	foreach($_POST['lista_uczniow'] as $id_ucz) {
		
		$status = "obecny";
		echo $id_ucz . " ";
		if(isset($_POST['list']) ){
			
			if (in_array($id_ucz,$_POST['list']))
			{
				echo "nieobecny";
				$status = "nieobecny";
			}
		}
		
		echo "obecny"; 
		echo '</br>';
		$conn->query("CALL dodaj_obecnosc('$status','$id_ucz','$id_lekcji')");
	}
}


$conn->close();

?>