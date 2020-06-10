<?php
session_start();
?>


<!DOCTYPE HTML>

<html lang="pl">
<head>
	<meta charset="utf-8" />
	<title>Zarządzanie kontem</title>
	<meta name="description" content="opis w google"/>
	<meta name="keywords" content="słowa po których google szuka"/>

	<link rel="stylesheet" href="../Styles/styleApp.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/form.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/table.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/myInput.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/button.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/tooltip.css" type="text/css" />
	
	<link rel="stylesheet" type="text/css" href="../Styles/tooltip.css">
	<link rel="Shortcut icon" href="favicon.ico" />

	<meta http-equiv="X-UA_Compatible" content="IE=edge,chrome=1" />
	<meta name="author" content="Kowalski, Mielniczek, Pająk" />

</head>

<body>
		
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
	
		$sql2="SELECT * FROM nauczyciel WHERE uzytkownik_login='$login' ";
		$result2 = @$conn->query($sql2);
		
		$dane_uzytkowanika=@mysqli_fetch_assoc($result);
		$dane_nauczyciela=@mysqli_fetch_assoc($result2);
		
		$result3 = $conn->query("CALL terminarz_nauczyciela($dane_nauczyciela[nauczyciel_ID])");
		
		$conn->close();
			
	}

	?>

	<div id="container">
	
	
		<div id="logo">
		
			<h1>Zalogowano jako nauczyciel</h1>
		
		</div>
		
		<a href="n_konto.php">
		<div id="inne">
		Zarządzanie kontem
		</div>
		</a>
				
		<a href="n_lekcje.php">
		<div id="inne">
		Lekcje
		</div> </a>
		
		<a href="n_oceny.php">
		<div id="inne">
		Oceny 
		</div></a>
		
		<a href="n_terminarz.php">
		<div id="teraz">
		Terminarz
		</div></a>
		
		<form action="../wyloguj.php" >
		<button class="button button2" style=" width:100px; height:30px; float: right;" id="btn" type="submit" >WYLOGUJ</button>
		</form>
		
		<?php
		if($dane_nauczyciela['czy_wych']=="Y")
		
		echo '<a href="n_klasa_wych.php">
		<div id="inne">
		Klasa wychowawcza
		</div></a>';	
		
		?>


	<div >
		
		

		<div id="tresc">
			<div id="lewy">
			
			
			<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
			<script language="javascript" type="text/javascript" >
				$(document).ready(function(){
				  $("#myInput").on("keyup", function() {
					var value = $(this).val().toLowerCase();
					$("#myTable tr").filter(function() {
					  $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
					});
				  });
				});
			
			</script>
			
			<?php
			date_default_timezone_set('Europe/Warsaw');
			$date = date('Y-m-d', time());
			#$date = "2020-10-10"; //data do testowania
		    if($result3->num_rows > 0) {
				
				echo "<table >";
				echo "<tr class='header'><th style:'width:10%px;'>Data</th>";
				echo "<th style:'width:10%;'>Godzina</th>";
				echo "<th style:'width:10%;'>Typ</th>";
				echo "<th style:'width:10%;'>Przemiot</th>";
				echo "<th style:'width:10%;'>Klasa</th>";
				echo "<th style:'width:30%;'>Opis</th>";
				echo "<th style:'width:10%;'>Edytuj</th>";
				echo "<th style:'width:10%;'>Usuń</th></tr>";
						
		        while($row3 = $result3->fetch_assoc()) {
					
					if ( $row3['data'] > $date || ( $row3['data'] == $date  && $row3['godz_start'] > time()))
					{
						echo "<tr><td>" . $row3['data'] . "</td>";
						echo "<td>" . $row3['godz_start'] . "</td>";
						echo "</td><td>" . $row3['typ']. "</td>";
						echo "<td>" . $row3['przedmiot'] . "</td>";
						echo "<td>" . $row3['oddzial'] . "</td>";
						echo "<td>";
						echo '<textarea style="resize: vertical; max-height: 300px; min-height: 20px;" disabled>' .$row3['opis'].'</textarea>';
						echo "</td><td>";echo "</td><td>";
						echo '</td></tr>';
					}
					
		        }
				echo '</table>';
		    }
			
			
			?>
			

			</div>
		</div>
		
		

		
		<div id="footer">
		e-dziennik
		</div>

	
	
	</div>
	
</body>

</html>