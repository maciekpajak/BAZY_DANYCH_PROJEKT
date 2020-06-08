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

<style>
body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box;}

/* Button used to open the contact form - fixed at the bottom of the page */
.open-button {
  background-color: #555;
  color: white;
  padding: 16px 20px;
  border: none;
  cursor: pointer;
  opacity: 0.8;
  position: fixed;
  bottom: 23px;
  right: 28px;
  width: 280px;
}

/* The popup form - hidden by default */
.form-popup {
  display: none;
  position: fixed;
  top: 100px;
  left: 500px;
  border: 3px solid #f1f1f1;
  z-index: 9;
}

/* Add styles to the form container */
.form-container {
  max-width: 300px;
  width: 300px;
  hight: 300px;
  padding: 10px;
  background-color: white;
}

/* Full-width input fields */
.form-container input[type=text], .form-container input[type=password] {
  width: 100%;
  hight: 100px:
  padding: 15px;
  margin: 5px 0 22px 0;
  border: none;
  background: #f1f1f1;
}

/* When the inputs get focus, do something */
.form-container input[type=text]:focus, .form-container input[type=password]:focus {
  background-color: #ddd;
  outline: none;
}

/* Set a style for the submit/login button */
.form-container .btn {
  background-color: #4CAF50;
  color: white;
  padding: 16px 20px;
  border: none;
  cursor: pointer;
  width: 100%;
  margin-bottom:10px;
  opacity: 0.8;
}

/* Add a red background color to the cancel button */
.form-container .cancel {
  background-color: red;
}

/* Add some hover effects to buttons */
.form-container .btn:hover, .open-button:hover {
  opacity: 1;
  
textarea {
  width: 100%;
  height: 200px;
  padding: 12px 20px;
  box-sizing: border-box;
  border: 2px solid #ccc;
  border-radius: 4px;
  background-color: #f8f8f8;
  resize: none;
}
}
</style>


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
			  
			  function openForm(id , temat) {
				  
				  window.alert(temat);
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
				window.alert("temat edytowany");
				document.getElementById("myForm").style.display = "none";
			  }
			  
			  
			</script>
			
			
			
			<?php
			
			
			
			
			?>
			
			
			<?php
			date_default_timezone_set('Europe/Warsaw');
			$date = date('Y-m-d', time());
			#$date = "2020-10-10"; //data do testowania
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
					
					
					
					
					if ( $row3['data'] > $date || ( $row3['data'] == $date  && $row3['godz_start'] > time()))
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
						echo '<textarea style="resize: vertical; width:200px;hight:20px; max-height: 300px; min-height: 20px;">' .$row3['temat'].'</textarea>';
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
						echo "
						<button onClick='sprawdzObecnosc(\"".$id_klasy."\" , \"".$id_lekcji."\" ,\"" . $oddzial_klasy."\",)'>
							Sprawdź obecność
						</button>";
						
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