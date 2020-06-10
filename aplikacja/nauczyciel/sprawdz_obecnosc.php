<?php
session_start();
?>


<!DOCTYPE HTML>

<html lang="pl">
<head>
	<meta charset="utf-8" />
	<title>Frekwencja</title>
	<meta name="description" content="opis w google"/>
	<meta name="keywords" content="słowa po których google szuka"/>

    <link rel="stylesheet" href="../Styles/styleApp.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/table.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/button.css" type="text/css" />
	
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
			
			echo "<table>";
			echo "<tr class='header'><td colspan=2>Informacje o lekcji</td></tr>";
			echo "<tr><td style='width:30%'>Data</td><td>" . $result2['data'] .'</td></tr>';
			echo "<tr><td style='width:30%'>Godzina</td><td> " . $result2['godz_start'] . "-" . $result2['godz_koniec'] . '</td></tr>';
			echo "<tr><td style='width:30%'>Klasa</td><td> " . $result2['oddzial'] . '</td></tr>';
			echo "<tr><td style='width:30%'>Sala</td><td> " . $result2['sala'] . '</td></tr>';
			echo "<tr><td style='width:30%'>Przedmiot</td><td>" . $result2['przedmiot'] . '</td></tr>';
			echo "<tr><td style='width:30%'>Nauczyciel</td><td> " . $result2['imie'] . " " . $result2['nazwisko'] . '</td></tr>';
			echo "<tr><td style='width:30%'>Temat</td><td> " . $result2['temat'] . '</td></tr>';
			echo "</table>";
			echo "<br>";
			echo '<form action="zatwierdz_obecnosc.php" method="post">';
			echo "<table >";
		    if($result->num_rows > 0) {
				$nr = 1;
				
				echo "<tr class='header'>";
				echo "<td>Nr</td>";
				echo "<td>Imie i nazwisko</td>";
				echo "<td>Obecny/Nieobecny</td>";
				echo '</tr>';
		        while($row = $result->fetch_assoc()) {
					echo "<tr>";
					echo "<td>" .$nr . ".</td>";
					echo "<td style='text-align:left;'>";
					echo $row['imie']. " " . $row['nazwisko'];
					echo "</td><td>";
					echo "<input type=\"hidden\" name=\"lista_uczniow[]\" value=".$row['uczen_ID']."></input>";
					echo "<input type=\"checkbox\" class='checkbox' name=\"list[]\" value=" . $row['uczen_ID'] . "></input>";
					echo "</td></tr>";
					$nr = $nr + 1;
		        }
		    }
			echo "</table>"; 
			echo '<button class="button button2" style=" width:48%; height:30px;float: left;"  type="submit"> Zatwierdź</button>';
			echo '<button class="button button2" style=" width:48%; height:30px; float: right;" type="button" onClick="javascript:window.close();"> Odrzuć</button>';
			echo '</form>';
			
			?>
		

		
		</div>
		
		
		<div id="footer">
		e-dziennik
		</div>

	
	
		
	</div>
	
</body>

</html>