<?php 
	session_start();
		
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
		
		$sql11="SELECT * FROM uzytkownik WHERE uzytkownik_login='$login'";
		$result11= @$conn->query($sql11);
		
		if($result11->num_rows > 0){
		$_SESSION['blad_login']='Login już istnieje, spróbuj inny!!!';
		}
		
		else
		{
		$conn->query("CALL dodaj_nauczyciela('$login','$haslo','$imie','$nazwisko','$email','$nr_tel','$czy_wych','$przedmiot_in')");

		$conn->close();
		$_SESSION['blad_login']='Nauczyciel został dodany pomyślnie.';
		
		
		
		if(isset($_GET['klasa_wych']))
		{
		$klasa_wych=$_GET['klasa_wych'];
		 
		
		require_once "../connect.php";
		
		$conn=@new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
		
		if ($conn->connect_errno!=0)
		{
			echo "Error: ".$conn->connect_errno;
		}
		else
		{
		
		
			
			$conn->query("UPDATE klasa SET nauczyciel_id=(SELECT MAX(ID) FROM nauczyciel_full_info) WHERE oddzial='$klasa_wych'");
			
			$conn->close();
		}
		}
		}
		}
	
	
	?>