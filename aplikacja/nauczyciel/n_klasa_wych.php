<?php
session_start();




if(!isset($_SESSION['typ'])){
$_SESSION['typ'] = "oceny";
}
if(!isset($_SESSION['przedmiot'])){
$_SESSION['przedmiot'] = "matematyka";
}
?>


<!DOCTYPE HTML>

<html lang="pl">
<head>
	<meta charset="utf-8" />
	<title>Klasa wychowawcza</title>
	<meta name="description" content="opis w google"/>
	<meta name="keywords" content="słowa po których google szuka"/>

   <link rel="stylesheet" href="../Styles/styleApp.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/form.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/table.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/myInput.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/button.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/modal.css" type="text/css" />
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
	
	$conn=@new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
	
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
		
		
		<a href="n_terminarz.php">
		<div id="inne">
		Terminarz
		</div></a>
		
		<form action="../wyloguj.php" >
		<button class="button button2" style=" width:100px; height:30px; float: right;" id="btn" type="submit" >WYLOGUJ</button>
		</form>
		
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
		
		
		<div id="tresc">
			<div id="lewy">
			
			
			<div>
		
		
			<form method="POST" >
				  <select class='myInput' id="cmbMake3" name="Make"  onchange="onChangeCmb3()" style=" float: right;">
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
						 if(isset($_SESSION['uczen']) and $_SESSION['uczen'] == $u['uczen_ID']){
						  echo '<option value ='.$u['uczen_ID'].' > '.$u['imie'].' '.$u['nazwisko'].' </option>';
						 }
						 else{
							echo '<option value ='.$u['uczen_ID'].' > '.$u['imie'].' '.$u['nazwisko'].' </option>';
						 }
					 }
					 ?>
				</select>
			</form>
		</div>
		<div>
			<form method="POST" >
				  <select class='myInput' id="cmbMake2" name="Make2"  onchange="onChangeCmb2()" style=" float: right;">
					 <?php
					 $conn=new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
					 $resultTMP = $conn->query("SELECT * FROM przedmiot");
					$conn->close();
					 while($p = $resultTMP->fetch_assoc())
					 {
						 if(isset($_SESSION['przedmiot']) and $_SESSION['przedmiot'] == $p['przedmiot_nazwa']){
						 echo '<option value =\''.$p['przedmiot_nazwa'].'\' selected> '.$p['przedmiot_nazwa'].' </option>';
						 }
						 else{
							echo '<option value =\''.$p['przedmiot_nazwa'].'\' > '.$p['przedmiot_nazwa'].' </option>'; 
						 }
					 }
					 ?>
				</select>
			</form>
		</div>
		<div>
		<div>
			<form method="POST" >
				  <select class='myInput' id="cmbMake" name="Make"  onchange="onChangeCmb()" style=" float: right;">
					 <?php
					 if(isset($_SESSION['typ']) and $_SESSION['typ'] == "oceny"){
						 echo '<option value="oceny" selected>Oceny</option>';
						}
						else{
						echo '<option value="oceny">Oceny</option>';
						}
					 if(isset($_SESSION['typ']) and $_SESSION['typ'] == "frekwencja"){
						 echo '<option value="frekwencja" selected>Frekwencja</option>';
						}
						else{
						echo '<option value="frekwencja">Frekwencja</option>';
						}
					 ?>
				</select>
			</form>
		</div>
		</div>
		<br><br>
			
			
			
			
			
			
			
			
			<?php	
			if($_SESSION['typ'] == "oceny" )
			{
				echo "<br/>";
				$conn=new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
				$k_id = $klasa_id;
				$result = $conn->query("CALL lista_osob_w_klasie($k_id)");
				$conn->close();
				
				$conn=new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
				$k_id = $klasa_id;
				$przedmiot_do_pokazu = $_SESSION['przedmiot'];
				$result4 = $conn->query("CALL oceny_z_przedmiotu_w_klasie($k_id,'$przedmiot_do_pokazu')");
				$conn->close();
				
				

				
				echo "<table>";
				if($result->num_rows > 0) {
					$nr = 1;
					
					echo "<tr class='header'><th style='width:1%;'>";
					echo "Nr";
					echo "</th ><th style='width:20%;'>";
					echo "Imie i nazwisko";
					echo "</th><th id='ocena' colspan=30 style='width:79%;'>";
					echo "Oceny";
					
					echo "</td></tr>";
					
					$uczen = $result4->fetch_assoc();
					while($row = $result->fetch_assoc()) {
						echo "<tr><td>";
						echo $nr . '.';
						echo "</td><td >";
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
								
								if($uczen['stopien'] == 6) {$color = "rgb(255, 0, 102)";}
								if($uczen['stopien'] == 5) {$color = "rgb(153, 0, 0)";}
								if($uczen['stopien'] == 4) {$color = "rgb(204, 102, 0)";}
								if($uczen['stopien'] == 3) {$color = "rgb(0, 255, 0)";}
								if($uczen['stopien'] == 2) {$color = "rgb(255, 255, 0)";}
								if($uczen['stopien'] == 1) {$color = "rgb(0, 255, 255)";}
								if($uczen['stopien'] == 0) {$color = "rgb(0, 0, 255)";}
								echo "<td headers='ocena' >";
								echo "<button class='button button3' style='background-color:$color;'>
								<div class=\"tooltip\" >
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
				echo "<table>";
				if($result->num_rows > 0) {
					$nr = 1;
					
					echo "<tr class='header'><th style='width:1%;'>";
					echo "Nr";
					echo "</th><th style='width:20%;'>";
					echo "Imie i nazwisko";
					echo "</th><th id='frekwencja' colspan=30 style='width:79%;'>";
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
									$color = "rgb(153, 255, 153)";
								}	
								if($uczen['status']=='spóźniony')
								{
									$status='S';
								$color = "rgb(204, 255, 255)";
								}
								if($uczen['status']=='nieobecny')
								{
									$status='N';
									$color = "rgb(255, 102, 102)";
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
									$color = "rgb(255, 255, 128)";
									$status .= '?';
									echo "<td headers='frekwencja' >";
									echo "
									<button class='button button3' style='background-color:$color;'
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
									$color = "rgb(163, 102, 255)";
									$status .= '*';
									echo "<td headers='frekwencja' >";
									echo "<button class='button button3' style='background-color:$color;'>
									<div class=\"tooltip\" >
									$status
										<span class=\"tooltiptext\">
										$przedmiot<br>$godzina
										</span>
									</div></button></td>";
								}
								else
								{
									echo "<td headers='frekwencja' >";
									echo "<button class='button button3' style='background-color:$color;'>
									<div class=\"tooltip\" >
									$status
										<span class=\"tooltiptext\">
										$przedmiot<br>$godzina
										</span>
									</div></button></td>";
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
			
		
		
		<div id="footer">
		e-dziennik
		</div>

	
	
	
	
	</div>
</body>

</html>