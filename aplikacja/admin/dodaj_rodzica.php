<?php 
	session_start();
		$login=$_GET['login'];
		$haslo=$_GET['haslo'];
		$imie=$_GET['imie'];
		$nazwisko=$_GET['nazwisko'];
		$nr_tel=$_GET['nr_tel'];
		$email=$_GET['email'];
		$opiekunowie_id=$_GET['o_id'];

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
			
			
			
		$conn->query("CALL dodaj_rodzica('$login','$haslo','$imie','$nazwisko','$nr_tel','$email','$opiekunowie_id')");
		$conn->close();
		$_SESSION['blad_login']='Rodzic został dodany pomyślnie.';
		}
		}
		
	?>