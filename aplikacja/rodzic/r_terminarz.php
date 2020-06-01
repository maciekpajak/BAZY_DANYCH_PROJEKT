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
	<link rel="stylesheet" type="text/css" href="../Styles/tooltip.css">
	<link rel="stylesheet"  type="text/css" href="../Styles/calendar.css" />
	<link rel="Shortcut icon" href="favicon.ico" />
	
	<meta name="description" content="opis w google"/>
	<meta name="keywords" content="słowa po których google szuka"/>

	<meta http-equiv="X-UA_Compatible" content="IE=edge,chrome=1" />
	<meta name="author" content="Kowalski, Mielniczek, Pająk" />

</head>


<body>
	
	<div id="container">
	
		<div id="logo">
		
			<h1>Zalogowano jako rodzic</h1>
		
		</div>
		
		<a href="r_konto.php">
		<div id="inne">
		Zarządzanie kontem
		</div>
		</a>
		
		
		<a href="r_oceny.php">
		<div id="inne">
		 Oceny 
		</div></a>
		
		
		<a href="r_frekwencja.php">
		<div id="inne">
		 Frekwencja
		</div> </a>	
		
		
		<a href="r_terminarz.php">
		<div id="teraz">
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
	
		$sql2="SELECT * FROM rodzic WHERE uzytkownik_login='$login' ";
		$result2 = @$conn->query($sql2);
		
		$dane_uzytkowanika=@mysqli_fetch_assoc($result);
		$dane_rodzica=@mysqli_fetch_assoc($result2);
		
		if(isset($_SESSION['wybrane_dziecko_id']) and $_SESSION['wybrane_dziecko_id'] != 0  )
			{
				
				$uczen_id = $_SESSION['wybrane_dziecko_id'];
				$result4 = @$conn->query("SELECT * FROM uczen WHERE uczen_ID=$uczen_id ");
				
				$dane_ucznia=@mysqli_fetch_assoc($result4);
				$result3 = $conn->query("CALL terminarz_klasy('$dane_ucznia[klasa_id]')");
			}
		$conn->close();
	}
	
	?>
		
		
		<div id="tresc">
		<div id="lewy">
			
			<B> Terminarz: </B><br/>	
			
		<?php
		include '../calendar.php';
		 
		$calendar = new Calendar();
		 
		echo $calendar->show();
		?>
		<?php
		if(isset($_SESSION['wybrane_dziecko_id']) and $_SESSION['wybrane_dziecko_id'] != 0  )
			{
				
		    date_default_timezone_set('Europe/Warsaw');
			$date = date('Y-m-d', time());
			#$date = "2020-10-10"; //data do testowania
		    if($result3->num_rows > 0) {
		        while($row3 = $result3->fetch_assoc()) {
					
					if ( $row3['data'] > $date || ( $row3['data'] == $date  && $row3['godz'] > time()))
					{
						echo " ";
						echo $row3['data'];
						echo " ";
						echo $row3['godz'];
						echo " ";
						$przedmiot= $row3['przedmiot'] . "\n";
						echo '
						<div class="tooltip">
								'.$row3['typ'].'
								<span class="tooltiptext">
									'.$przedmiot.' <br>
									'.$row3['imie'].' '.$row3['nazwisko'].' <br>
									'.$row3['opis'].'
								</span>
						</div>';
						echo "<br/>";
					}
		        }
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

</div>
  
	
</body>

</html>