<?php 
	
    //if(isset($_GET['id']) and isset($_GET['tresc'])) {
		//$id = $_GET['id'];
		//$tresc = $_GET['tresc'];
		
		
		
		$login=$_GET['login'];
		$haslo=$_GET['haslo'];
		$imie=$_GET['imie'];
		$nazwisko=$_GET['nazwisko'];
		$email=$_GET['email'];
		$nr_tel=$_GET['nr_tel'];
		$czy_wych=$_GET['czy_wych'];
		$przedmiot_in=$_GET['przedmiot_in'];
		
		
		
		require_once "../connect.php";
		
		$conn=@new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
		
		
		
		
		if ($conn->connect_errno!=0)
		{
			echo "Error: ".$conn->connect_errno;
		}
		else
		{
			
			//$conn->query("UPDATE obecnosc AS o SET o.czy_do_uspr = 'Y', o.tresc_uspr = '$tresc' WHERE o.obecnosc_ID = '$id'");
				
			$conn->query("CALL dodaj_nauczyciela('$login','$haslo','$imie','$nazwisko','$email','$nr_tel','$czy_wych','$przedmiot_in')");
			$conn->close();
		}
	//}
	?>