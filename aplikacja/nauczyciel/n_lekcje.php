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
		
		$result3 = $conn->query("CALL lekcje_nauczyciela($dane_nauczyciela[nauczyciel_ID])");
		
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
		<div id="teraz">
		Lekcje
		</div> </a>
		
		<a href="n_oceny.php">
		<div id="inne">
		Oceny 
		</div></a>
		
		<a href="n_oceny_koncowe.php">
		<div id="inne">
		Oceny końcowe 
		</div></a>
		
		<a href="n_terminarz.php">
		<div id="inne">
		Terminarz
		</div></a>
		
		<a href="n_uwagi.php">
		<div id="inne">
		Uwagi 
		</div></a>
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
			  function sprawdzObecnosc(id_klasy_in, id_lekcji_in, oddzial){
				  
				  
				$.ajax({
					url: "./wybrana_klasa.php",
					data: {
						id_klasy: id_klasy_in,
						id_lekcji: id_lekcji_in
						}, 
				});
				window.open('./sprawdz_obecnosc.php?obecnosc=' + oddzial);
				
			  }
			  
			  function edytujObecnosc(id_klasy_in, id_lekcji_in, oddzial){
				  
				  
				$.ajax({
					url: "./wybrana_klasa.php",
					data: {
						id_klasy: id_klasy_in,
						id_lekcji: id_lekcji_in
						}, 
				});
				window.open('./edytuj_obecnosc.php?obecnosc=' + oddzial);
				
			  }
			  
			  
			  function openForm(id , temat) {
				  
				  $id_lekcji = id;
				  $temat= temat;
				  document.getElementById("textarea_temat").innerHTML = temat;
				  document.getElementById("myForm").style.display = "block";
				}
			  
			  function closeForm() {
				  document.getElementById("myForm").style.display = "none";
				}
				
			  function edytujTemat(){
				  
				$.ajax({
					url: "./edytuj_temat.php",
					data: {
						id_lekcji: $id_lekcji,
						temat: $('#textarea_temat').val()
					}, 
				});
				document.getElementById("myForm").style.display = "none";
			  }
			  
			  
			</script>
			
			
			
			<?php
			
			
			
			
			?>
			
			
			<?php
			date_default_timezone_set('Europe/Warsaw');
			$date = date('Y-m-d', time());
			#$d=mktime(11, 40, 54, 8, 12, 2014);
			#$date1 = date('G:i:s', $d);
			#$date = "2020-09-02"; //data do testowania
		    if($result3->num_rows > 0) {
				
				echo "<table border=2 style='font-size:15px;' >";
					
				echo "<tr><td style:'width:10px;'>";
				echo "Data";
				echo "</td><td style:'width:10px;'>";
				echo "Godzina";
				echo "</td><td style:'width:10px;'>";
				echo "Przedmiot";
				echo "</td><td style:'width:10px;'>";
				echo "Sala";
				echo "</td><td style:'width:10px;'>";
				echo "Klasa";
				echo '</td></tr>';
		        while($row3 = $result3->fetch_assoc()) {
					
					
					
					
					if ( $row3['data'] > $date || ( $row3['data'] == $date))
					{
						echo "<tr><td style:'width:10px;'>";
						echo $row3['data'];
						echo "</td><td style:'width:10px;'>";
						echo $row3['godz_start'];
						echo "</td><td style:'width:10px;'>";
						echo $row3['przedmiot'];
						echo "</td><td style:'width:10px;'>";
						echo $row3['sala'];
						echo "</td><td style:'width:10px;'>";
						echo $row3['oddzial'];
						echo "</td><td style:'width:10px;'>";
						echo '<textarea style="resize: vertical; width:200px;hight:20px; max-height: 300px; min-height: 20px;" disabled>' .$row3['temat'].'</textarea>';
						echo "</td><td>";
						$temat = $row3['temat'];
						
						$id_klasy = $row3['klasa_id'];
						$id_lekcji = $row3['lekcja_ID'];
						$oddzial_klasy = $row3['oddzial'];
						echo "
						<button onClick='openForm(\"".$id_lekcji."\" , \"" . $temat ."\")'> 
							Edytuj temat
						</button>";
						
						
						echo '</td><td>';
						if($row3['czy_spr_obec'] == 'N' )
						{
							if ( $row3['data'] == $date and $row3['godz_start'] <= time() ){
							echo "
							<button onClick='sprawdzObecnosc(\"".$id_klasy."\" , \"".$id_lekcji."\" ,\"" . $oddzial_klasy."\",)'>
								Sprawdź obecność
							</button>";}
							else{
								echo "
							<button disabled>
								Sprawdź obecność
							</button>";}
						}
						else
						{
							echo "
							<button onClick='edytujObecnosc(\"".$id_klasy."\" , \"".$id_lekcji."\" ,\"" . $oddzial_klasy."\",)'>
								Edytuj obecność
							</button>";
						}
						echo '</td></tr>';
					}
					
		        }
				echo '</table>';
		    }
			
			
			?>
			

			</div>
		</div>
		
		
		<div class="form-popup" id="myForm">
		  <form onSubmit="edytujTemat()" class="form-container" method="POST" >
			<h1>Edytuj temat</h1>
			<textarea id="textarea_temat" style="width:300px;height:150px;resize: none;" maxlength=100 ></textarea>
			<button id="btn" type="submit" name="uspr"  >Zatwierdź</button>
			<button type="button" onclick="closeForm()">Anuluj</button>
		  </form>
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