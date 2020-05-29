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
					
					header('Location: uczen/u_konto.php');
				}
				else if($dane['rodzaj']=='A')
				{
					
					header('Location: admin/a_konto.php');
				}
				else if($dane['rodzaj']=='R')
				{
					header('Location: rodzic/r_konto.php');
				}
				else if($dane['rodzaj']=='N')
				{
					header('Location: nauczyciel/n_konto.php');
				}
				else
				{
				    $_SESSION['blad']='<span style="font-size:20px; color:red">Nieprawidłowy typ konta</span>';
				header('Location: index.php');
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