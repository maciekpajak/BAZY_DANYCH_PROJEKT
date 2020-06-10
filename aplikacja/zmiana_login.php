<?php

session_start();
	$haslo = $_SESSION['haslo'];
	$login=$_SESSION['uzytkownik_login'];
	$n_login=$_POST['nowy_login'];
	$haslo_L=md5($_POST['haslo_L']);
	require_once "connect.php";
	
	$conn=@new mysqli($IP, $username, $password, $DB_name); 

	if ($conn->connect_errno!=0)
	{
		echo "Error: ".$conn->connect_errno;
	}
	else
	{
					
					
					
					if($haslo_L==$haslo)
					{
						$sql11="SELECT * FROM uzytkownik WHERE uzytkownik_login='$n_login'";
						$result11= @$conn->query($sql11);
						$conn->close();
						if($result11->num_rows > 0){
						echo "Login już istnieje.".'<form action="index.php">
		
					    <br/>
					    <button type="submit">Zaloguj się jeszcze raz</button>';
						}
		
						else
						{
						require_once "connect.php";
	
						$conn=@new mysqli($IP, $username, $password, $DB_name); 
						$sql5="UPDATE uzytkownik SET uzytkownik_login = '$n_login' WHERE uzytkownik_login = '$login'";	
						@$conn->query($sql5);
						$conn->close();
						echo "Poprawnie zmieniony login".
								'<form action="index.php">
		
					<br/>
					<button type="submit">Zaloguj się jeszcze raz</button>
					';
						}
					}
					else
					{
							echo "Błąd w zmianie loginu".'<form action="index.php">
			
							<br/>
							<button type="submit">Zaloguj się jeszcze raz</button>';
						}

	}
					
					
					

?>