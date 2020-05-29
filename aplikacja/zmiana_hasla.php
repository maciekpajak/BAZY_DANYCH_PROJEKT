<?php

session_start();
	$haslo = $_SESSION['haslo'];
	$login=$_SESSION['uzytkownik_login'];
	require_once "connect.php";
	
	$conn=@new mysqli($IP, $username, $password, $DB_name); 

	if ($conn->connect_errno!=0)
	{
		echo "Error: ".$conn->connect_errno;
	}
	else
	{
		$stare=$_POST['stare'];
					$nowe=$_POST['nowe'];
					$p_nowe=$_POST['p_nowe'];
					
					if($stare==$haslo)
					{
						if($nowe==$p_nowe)
						{
						$sql5="update uzytkownik set uzytkownik.haslo = '$nowe' where uzytkownik.uzytkownik_login = '$login'";	
						$result5 = @$conn->query($sql5);
						echo "Poprawnie zmienione hasło".
								'<form action="index.php">
		
					<br/>
					<button type="submit">Zaloguj się jeszcze raz</button>
					';
						}
						
						else
					    {
						    echo "Błąd w zmianie hasła, nowe hasło powtórzone niewłaściwie".'
														<form action="index.php">
		
					        <br/>
					        <button type="submit">Zaloguj się jeszcze raz</button>';
					    }
					}
					else
					{
						echo "Błąd w zmianie hasła, sprawdz poprawność starego hasła".'
														<form action="index.php">
		
					<br/>
					<button type="submit">Zaloguj się jeszcze raz</button>';
					}
					
					$conn->close();
					}

?>