<?php

    session_start();
	
	if(!isset($_SESSION['uzytkownik_login']) || !isset($_SESSION['haslo']))
	{
		session_unset(); 
		session_destroy();
		header('Location: ../index.php');
	}
	

	
	if(isset($_SESSION['action'])) 
	{
		$duration = time() - (int)$_SESSION['action'];
			if($duration > $_SESSION['timeout']) 
			{
				session_unset(); 
				session_destroy();
				header('Location: ../index.php');
			}
	}
 
	$_SESSION['action'] = time();
	
?>

<script type="text/javascript">
setTimeout( function() { alert("Twoja sesja zakończyła się"); location.reload(); }, 180*1000);

</script>

<!--------------------------------------------------------------------------------------------->
<!DOCTYPE HTML>

<html lang="pl">

<head>
	
	<title>Konto ucznia</title>
	<META http-equiv="content-type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="../Styles/styleApp.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/form.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/table.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/myInput.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/button.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/modal.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/tooltip.css" type="text/css" />
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
		<div id="inne">
		 Oceny 
		</div></a>
		
		
		<a href="u_frekwencja.php">
		<div id="inne">
		 Frekwencja
		</div> </a>	
		
		
		<a href="u_terminarz.php">
		<div id="teraz">
		 Terminarz 
		</div>
		</a>	
		
		<form action="../wyloguj.php" >
		<button class="button button2" style=" width:100px; height:30px; float: right;" id="btn" type="submit" >WYLOGUJ</button>
		</form>
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
		
		$result3 = $conn->query("CALL terminarz_klasy('$dane_ucznia[klasa_id]')");
		
		$conn->close();
	}
	
	?>
		
		
		<div id="tresc">
		<div id="lewy">
			
		<?php
		    date_default_timezone_set('Europe/Warsaw');
			$date = date('Y-m-d', time());
			#$date = "2020-10-10"; //data do testowania
			echo "<table>";
			echo "<tr class='header'><th  style='width:25%;'>Data</th>";
			echo "<th style='width:25%;'>Godzina</th>";
			echo "<th id='ocena' style='width:25%;'>Przedmiot</th>";
			echo "<th id='ocena' style='width:25%;'>Typ</th></tr>";
		    if($result3->num_rows > 0) {
		        while($row3 = $result3->fetch_assoc()) {
					$przedmiot= $row3['przedmiot'];
					echo "<td>" . $row3['data'] . "</td>";
					echo "<td>" . $row3['godz_start'] . "</td>";
					echo "<td>" . $przedmiot  . "</td>";
					echo "<td>
					<div class='tooltip'>
							".$row3['typ']."
							<span class='tooltiptext'>
								Przedmiot: ".$przedmiot." <br>
								Nauczyciel: ".$row3['imie']." ".$row3['nazwisko']." <br>
								Opis: ".$row3['opis']."
							</span>
					</div></td>";
					echo "</tr>";
		        }
		    }
			echo "</table>";
		    
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

</div>
  
	
</body>

</html>