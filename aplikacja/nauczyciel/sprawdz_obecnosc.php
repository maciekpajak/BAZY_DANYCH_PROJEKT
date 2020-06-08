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
	<link rel="Shortcut icon" href="favicon.ico" />

	<meta http-equiv="X-UA_Compatible" content="IE=edge,chrome=1" />
	<meta name="author" content="Kowalski, Mielniczek, Pająk" />

</head>


<body>

	<div id="container">	
		<div id="logo">
		
			<h1>Frekwencja na lekcji</h1>
		
		</div>
		<?php 
	unset($_SESSION['blad']);
	
	require_once "../connect.php";
	
	$conn=new mysqli($IP, $username, $password, $DB_name); 
	
	if ($conn->connect_errno)
	{
		echo "Error: ".$conn->connect_errno;
	}
	
	$klasa = $_SESSION['id_klasy1'];
	$lekcja = $_SESSION['id_lekcji1'];
	$result1 = $conn->query("SELECT  * FROM lekcja_full_info AS l WHERE l.lekcja_ID = $lekcja");
	$result = $conn->query("CALL lista_osob_w_klasie($klasa)");
	$result2 = @mysqli_fetch_array($result1);
	$conn->close();
		

	?>

		
	<div>
		
		

		<div id="tresc">
			<div id="lewy">
			
		<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
		<script type='text/javascript'>
			
			function sprawdz(){
				
				
			}
		</script>
			
			<?php
			
			{
			echo $result2['data'];
			echo '</br>';
			echo $result2['godz_start'] . "-" . $result2['godz_koniec'];
			echo '</br>';
			echo $result2['oddzial'];
			echo '</br>';
			echo "Sala: " . $result2['sala'];
			echo '</br>';
			echo $result2['przedmiot'];
			echo '</br>';
			echo $result2['imie'] . " " . $result2['nazwisko'];
			echo '</br>';
			echo "Temat: " . $result2['temat'];
			}
			
			echo '<form action="zatwierdz_obecnosc.php" method="post">';
			echo "<table border=1>";
		    if($result->num_rows > 0) {
				$nr = 1;
				
				echo "<tr><td>";
				echo "Nr";
				echo "</td><td>";
				echo "Imie i nazwisko";
				echo "</td><td>";
				echo "<input type=\"checkbox\" id='checkall' /> Select All<br/>";
				echo "</td></tr>";
		        while($row = $result->fetch_assoc()) {
					echo "<tr><td>";
					echo $nr . '.';
					echo "</td><td>";
					echo $row['imie'];
					echo " ";
					echo $row['nazwisko'];
					echo "</td><td>";
					echo "<input type=\"hidden\" name=\"lista_uczniow[]\" value=".$row['uczen_ID']."></input>";
					echo "<input type=\"checkbox\" class='checkbox' name=\"list[]\" value=" . $row['uczen_ID'] . "></input>";
					echo "</td></tr>";
					$nr = $nr + 1;
		        }
		    }
			echo "</table>"; 
			echo '<input type="submit" /> Zatwierdź</input>';
			echo '</form>';
			
			?>
		

		
		</div>
		
		
		
		
		
		
		<button> Zatwierdź </button>
		<button> Odrzuć </button>
		
		<div id="footer">
		e-dziennik
		</div>

	
	
		
	</div>
	
</body>

</html>