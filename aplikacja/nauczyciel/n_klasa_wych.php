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
	<link rel="stylesheet" type="text/css" href="../Styles/tooltip.css">
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
	
	$conn=@new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
	#$conn=new mysqli($IP, $username, $password, $DB_name); 
	
	if ($conn->connect_errno!=0)
	{
		echo "Error: ".$conn->connect_errno;
		exit();
	}
	
	$login=$_SESSION['uzytkownik_login'];
		
	$haslo = $_SESSION['haslo'];
	
	
	$sql="SELECT * FROM uzytkownik WHERE uzytkownik_login='$login' AND haslo='$haslo'";
	$result = $conn->query($sql);

	$sql2="SELECT * FROM nauczyciel WHERE uzytkownik_login='$login' ";
	$result2 = $conn->query($sql2);
	$dane_nauczyciela=@mysqli_fetch_assoc($result2);
	$n_id = $dane_nauczyciela['nauczyciel_ID'];
	
	

	
	
	$sql3 = "CALL klasy_nauczyciela('$n_id')";
	$result3 = $conn->query($sql3);
	
	$conn->close();
		
	
	?>
	<?php


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
		<div id="teraz">
		Klasa wychowawcza
		</div></a>';	
		
		?>
		
		
		<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
		<script language="javascript" type="text/javascript">


				function openForm(id , status, godzina, przedmiot, nauczyciel, uczen, tresc_uspr) {
				  
				  $id_obecnosci_do_uspr = id;
				  document.getElementById("form_uczen").innerHTML = uczen;
				  document.getElementById("form_status").innerHTML = status;
				  document.getElementById("form_przedmiot").innerHTML = przedmiot;
				  document.getElementById("form_nauczyciel").innerHTML = nauczyciel;
				  document.getElementById("form_godzina").innerHTML = godzina;
				  document.getElementById("tresc_uspr").innerHTML = tresc_uspr;
				  document.getElementById("myForm").style.display = "block";
				}

				function closeForm() {
				  document.getElementById("myForm").style.display = "none";
				}
				
				function usprawiedliw() {
				
				$.ajax({
					url: "./usprawiedliw.php",
					data: {
						id: $id_obecnosci_do_uspr
						}, 
				});
				window.alert("Usprawiedliwienie zostało pomyślnie wysłane");
				document.getElementById("myForm").style.display = "none";
				}


				function onChangeCmb() {
					
				var element = document.getElementById("cmbMake");
				var value = element.options[element.selectedIndex].value;
				 $.ajax({
					url: "./wyborTyp.php",
					data: {
						typ: value
						}, 
				});
				setTimeout(function(){ window.location.reload(true); }, 100);
				}
				
				function onChangeCmb2() {
					
				var element = document.getElementById("cmbMake2");
				var value = element.options[element.selectedIndex].value;
				 $.ajax({
					url: "./wyborTyp.php",
					data: {
						przedmiot: value
						}, 
				});
				setTimeout(function(){ window.location.reload(true); }, 100);
				}
				
				
					
	</script>
		
		<div>
		<div>
			<form method="POST" >
				  <select id="cmbMake" name="Make"  onchange="onChangeCmb()">
					 <?php
					 echo '<option value = 0 > ---Wybierz typ--- </option>';
					 echo '<option value="oceny">Oceny</option>';
					 echo '<option value="frekwencja">Frekwencja</option>';
					 ?>
				</select>
			</form>
		</div>
		<div>
			<form method="POST" >
				  <select id="cmbMake2" name="Make2"  onchange="onChangeCmb2()">
					 <?php
					 $conn=new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
					 $resultTMP = $conn->query("SELECT * FROM przedmiot");
					$conn->close();
					 echo '<option value = 0 > ---Wybierz przedmiot--- </option>';
					 while($p = $resultTMP->fetch_assoc())
					 {
						  echo '<option value =\''.$p['przedmiot_nazwa'].'\' > '.$p['przedmiot_nazwa'].' </option>';
					 }
					 ?>
				</select>
			</form>
		</div>
		<div>
			<form method="POST" >
				  <select id="cmbMake3" name="Make"  onchange="onChangeCmb3()">
					 <?php
					 $conn=new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
					 
					$sql5 = "SELECT * FROM klasa WHERE nauczyciel_ID = '$n_id'";
					$klasa_nauczyciela = $conn->query($sql5);
					$klasa = $klasa_nauczyciela->fetch_assoc();

					 $klasa_id= $klasa['klasa_ID'];
					 $resultTMP = $conn->query("CALL lista_osob_w_klasie('$klasa_id')");
					$conn->close();
					
					 echo '<option value = 0 > ---Wybierz ucznia--- </option>';
					 while($u = $resultTMP->fetch_assoc())
					 {
						  echo '<option value ='.$u['uczen_ID'].' > '.$u['imie'].' '.$u['nazwisko'].' </option>';
					 }
					 ?>
				</select>
			</form>
		</div>
		</div>

		<div id="tresc">
			<div id="lewy">
			
			
			<?php	
			if($_SESSION['typ'] == "oceny" )
			{
				echo "<B> Oceny: </B><br/>";
				$conn=new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
				$k_id = $klasa_id;
				$result = $conn->query("CALL lista_osob_w_klasie($k_id)");
				$conn->close();
				
				$conn=new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
				$k_id = $klasa_id;
				$przedmiot_do_pokazu = $_SESSION['przedmiot'];
				$result4 = $conn->query("CALL oceny_z_przedmiotu_w_klasie($k_id,'$przedmiot_do_pokazu')");
				$conn->close();
				
				

				
				echo "<table border=1 style='font-size:15px;'>";
				if($result->num_rows > 0) {
					$nr = 1;
					
					echo "<tr><td>";
					echo "Nr";
					echo "</td><td>";
					echo "Imie i nazwisko";
					echo "</td><td id='ocena' colspan=30>";
					echo "Oceny";
					
					echo "</td></tr>";
					
					$uczen = $result4->fetch_assoc();
					while($row = $result->fetch_assoc()) {
						echo "<tr style:'hight:30px;'><td style='font-size:15px;'>";
						echo $nr . '.';
						echo "</td><td style='font-size:15px;'>";
						echo $row['imie'];
						echo " ";
						echo $row['nazwisko'];
						echo "</td>";
						$ucz_id = $row['uczen_ID'];
						$imie = $row['imie'];
						$nazw = $row['nazwisko'];
						$i = 0;
						if(isset($uczen['uczen_ID']) and $row['uczen_ID'] == $uczen['uczen_ID'])
						{
							
							while( isset($uczen['uczen_ID']) and $row['uczen_ID'] == $uczen['uczen_ID'])
							{
								
								echo "<td headers='ocena' style='width:20px;font-size:15px;'>";
								echo "<button style='width:20px;font-size:15px;'
								onClick='openForm2(\"".$uczen['ocena_ID']."\" , \"" . $imie ."\", \"" . $nazw."\", \"" . $uczen['stopien'] ."\", \"" . $uczen['waga'] ."\", \"" . $uczen['data'] ."\", \"" . $uczen['opis'] ."\")' > 
								<div class=\"tooltip\">
								".$uczen['stopien']."
									<span class=\"tooltiptext\">
									".$uczen['stopien']."<br>".$uczen['waga']."<br>".$uczen['opis']."<br>".$uczen['data']."
									</span>
								</div></button>";
								echo "</td>";
								$uczen = $result4->fetch_assoc();
								$i = $i +1;
								##\"".$uczen['ocena_ID']."\" , \"" . $imie ."\", \"" . $nazw."\", \"" . $uczen['stopien'] ."\", \"" . $uczen['waga'] ."\", \"" . $uczen['data'] ."\", \"" . $uczen['opis'] ."\"
							}
						}
						
						while( $i < 30 )
						{
							echo "<td headers='ocena' style='width:20px;font-size:15px;'></td>";
							$i = $i + 1;
						}
						
						echo "</tr>";
						$nr = $nr + 1;
					}
				}
				echo "</table>"; 
			
				
			}
			if($_SESSION['typ'] == "frekwencja" )
			{
				$conn=new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
				$k_id = $klasa_id;
				$result = $conn->query("CALL lista_osob_w_klasie($k_id)");
				$conn->close();
				
				$conn=new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
				$k_id = $klasa_id;
				$przedmiot_do_pokazu = $_SESSION['przedmiot'];
				$result4 = $conn->query("CALL frekwencja_z_przedmiotu_klasy($k_id,'$przedmiot_do_pokazu')");
				$conn->close();
				echo "<table border=1 style='font-size:15px;'>";
				if($result->num_rows > 0) {
					$nr = 1;
					
					echo "<tr><td>";
					echo "Nr";
					echo "</td><td>";
					echo "Imie i nazwisko";
					echo "</td><td id='frekwencja' colspan=30>";
					echo "Frekwencja";
					
					echo "</td></tr>";
					
					$uczen = $result4->fetch_assoc();
					while($row = $result->fetch_assoc()) {
						echo "<tr style:'hight:30px;'><td style='font-size:15px;'>";
						echo $nr . '.';
						echo "</td><td style='font-size:15px;'>";
						echo $row['imie'];
						echo " ";
						echo $row['nazwisko'];
						echo "</td>";
						$ucz_id = $row['uczen_ID'];
						$imie = $row['imie'];
						$nazw = $row['nazwisko'];
						$i = 0;
						
						
						if(isset($uczen['uczen_id']) and $row['uczen_ID'] == $uczen['uczen_id'])
						{
							while( isset($uczen['uczen_id']) and $row['uczen_ID'] == $uczen['uczen_id'])
							{
								
								
								if ($uczen['status']=='obecny')
								{
									$status='O';
									$color = "green";
								}	
								if($uczen['status']=='spóźniony')
								{
									$status='S';
								$color = "yellow";
								}
								if($uczen['status']=='nieobecny')
								{
									$status='N';
									$color = "red";
								}
								
								$id = $uczen['obecnosc_ID'];
								$start = $uczen['godz_start'];
								$koniec = $uczen['godz_koniec'];
								$godzina = $start . "-" . $koniec;
								$nauczyciel = $uczen['n_imie'] . " " . $uczen['n_nazwisko'] ;
								$uczen_dane = $uczen['u_imie'] . " " . $uczen['u_nazwisko'] ;
								$przedmiot = $uczen['przedmiot'];
								$tresc_uspr = $uczen['tresc_uspr'];
								
								if($uczen['czy_do_uspr']=='Y')
								{
									$color = "blue";
									$status .= '?';
									echo "<td headers='frekwencja' style='width:20px;font-size:15px;background-color:$color;'>";
									echo "
									<button 
									onClick='openForm(\"".$id."\" , \"" . $uczen['status'] ."\", \"" . $godzina ."\", \"" . $przedmiot ."\", \"" . $nauczyciel ."\", \"" . $uczen_dane ."\", \"" . $tresc_uspr ."\")' > 
									<div class=\"tooltip\">
									$status
										<span class=\"tooltiptext\">
										$przedmiot<br>$godzina
										</span>
									</div></button></td>";
								}
								else if($uczen['czy_uspr']=='Y')
								{
									$color = "pink";
									$status .= '*';
									echo "<td headers='frekwencja' style='width:20px;font-size:15px;background-color:$color;'>";
									echo "
									<div class=\"tooltip\" >
									$status
										<span class=\"tooltiptext\">
										$przedmiot<br>$godzina
										</span>
									</div></td>";
								}
								else
								{
									echo "<td headers='frekwencja' style='width:20px;font-size:15px;background-color:$color;'>";
									echo "
									<div class=\"tooltip\" >
									$status
										<span class=\"tooltiptext\">
										$przedmiot<br>$godzina
										</span>
									</div></td>";
								}
								
								
								
								$uczen = $result4->fetch_assoc();
								$i = $i +1;
							}
						}
						
						while( $i < 30 )
						{
							echo "<td headers='frekwencja' style='width:20px;font-size:15px;'></td>";
							$i = $i + 1;
						}
						
						echo "</tr>";
						$nr = $nr + 1;
					}
				}
				echo "</table>";
				
			
			echo "</tr></table>"; 	
			}				
				?>

		
		</div>
			</div>	
			
			
		<div class="form-popup" id="myForm">
		  <form onSubmit="usprawiedliw()" class="form-container" method="POST" >
			<h1>Usprawiedliwienie</h1>

			<p id="form_uczen"></p>
			<p id="form_status"></p>
			<p id="form_przedmiot"></p>
			<p id="form_nauczyciel"></p>
			<p id="form_godzina"></p>
			<textarea id="tresc_uspr" style="width:300px;height:150px;resize: none;" maxlength=250 readonly ></textarea>
			<button id="btn" type="submit" name="uspr"  >Usprawiedliw</button>
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