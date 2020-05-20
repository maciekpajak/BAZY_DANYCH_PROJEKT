<?php
	session_start();
	
	require_once "connect.php";
	
	$conn=@new mysqli($IP, $username, $password, $DB_name); 
		                                   /*("adres IP", "username","password", "DB_name")*/
	if ($conn->connect_errno!=0)
	{
		echo "Error: ".$conn->connect_errno;
	}
	else
	{
		$login = $_POST['login'];
		$haslo = $_POST['haslo'];
		
		
		$sql="SELECT * FROM uzytkownik WHERE uzytkownik_login='$login' AND haslo='$haslo'";
		
		if($result = @$conn->query($sql))
			{
			
			$czy_dobrze=$result->num_rows;
			
			if($czy_dobrze>0)
				{
					
				$dane=@mysqli_fetch_assoc($result);
				$_SESSION['uzytkownik_login']=$dane['uzytkownik_login'];
				$_SESSION['haslo']=$dane['haslo'];
				
				$result->free_result();
				if($dane['rodzaj']=='U')
				{
					
					header('Location: u_konto.php');
				}
				if($dane['rodzaj']=='A')
				{
					
					header('Location: a_konto.php');
				}
				if($dane['rodzaj']=='R')
				{
					header('Location: r_konto.php');
				}
				if($dane['rodzaj']=='N')
				{
					header('Location: n_konto.php');
				}
				}
				
			else
				{
				$_SESSION['blad']='<span style="font-size:20px; color:red">Nieprawidłowy login lub hasło</span>';
				header('Location: index.php');
				}
		
		
		
		
			$conn->close();
			}
	}

?>