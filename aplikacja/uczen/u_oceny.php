<?php
session_start();
?>

<!DOCTYPE HTML>

<html lang="pl">
<head>
	
	<title>Konto ucznia</title>
	<META http-equiv="content-type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="../Styles/styleApp.css" type="text/css" />
	<link rel="Shortcut icon" href="favicon.ico" />
	
	<meta name="description" content="opis w google"/>
	<meta name="keywords" content="słowa po których google szuka"/>

	<meta http-equiv="X-UA_Compatible" content="IE=edge,chrome=1" />
	<meta name="author" content="Kowalski, Mielniczek, Pająk" />

</head>


<body>
	
	<div id="container">
	
		<div id="logo">
		
			<h1>Zalogowano jako uczeń</h1>
		
		</div>
		
		<a href="u_konto.php">
		<div id="inne">
		Zarządzanie kontem
		</div>
		</a>
		
		
		<a href="u_oceny.php">
		<div id="teraz">
		 Oceny 
		</div></a>
		
		
		<a href="u_frekwencja.php">
		<div id="inne">
		 Frekwencja
		</div> </a>	
		
		
		<a href="u_terminarz.php">
		<div id="inne">
		 Terminarz 
		</div>
		</a>	
		
		
		<?php 
	unset($_SESSION['blad']);
	
	require_once "../connect.php";
	
	$conn=@new mysqli($IP, $username, $password, $DB_name); 
    
	if ($conn->connect_errno!=0)
	{
		echo "Error: ".$conn->connect_errno;
	}
	else
	{
		
		$login=$_SESSION['uzytkownik_login'];
		
		$haslo = $_SESSION['haslo'];
		
		$sql="SELECT * FROM uzytkownik WHERE uzytkownik_login='$login' AND haslo='$haslo'";
		$result = @$conn->query($sql);
	
		$sql2="SELECT * FROM uczen WHERE uzytkownik_login='$login' ";
		$result2 = @$conn->query($sql2);
		
		$dane_uzytkowanika=@mysqli_fetch_assoc($result);
		$dane_ucznia=@mysqli_fetch_assoc($result2);
		
		$sql3="select * from ocena_full_info as o where o.uczen_id = '$dane_ucznia[uczen_ID]' ORDER BY o.`przedmiot`, o.`data` ASC";
		$result3 = @$conn->query($sql3);
		
		$conn->close();
	}
	
	?>
		
		
		<div id="tresc">
		<div id="lewy">
			
			<B> Oceny: </B><br/>	
		
		<?php
		    
		    if($result3->num_rows > 0) {
		        while($row3 = $result3->fetch_assoc()) {

                    $nazwap = $row3['przedmiot'];
		            echo $nazwap;
		            echo " ";
		            echo $row3['stopien'];
		            echo "<br/>";
		        }
		    }
		    
		?>
		
		</div>
		</div>
		
		<form action="../wyloguj.php" >

		<button type="submit">wyloguj</button>
		</form>
		
		
		<div id="footer">
		e-dziennik
		</div>
	
	
	
	</div>
	
</body>

</html>