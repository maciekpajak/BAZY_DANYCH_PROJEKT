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
	<link rel="stylesheet" href="../Styles/modal.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/tooltip.css" type="text/css" />
	<link rel="Shortcut icon" href="favicon.ico" />

	<meta http-equiv="X-UA_Compatible" content="IE=edge,chrome=1" />
	<meta name="author" content="Kowalski, Mielniczek, Pająk" />

</head>

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
		<div id="teraz">
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
		<div id="inne">
		Klasa wychowawcza
		</div></a>';	
		
		?>
		
		
		<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
		<script language="javascript" type="text/javascript">


				function openForm2(id, imie, nazwisko, ocena, waga, data, opis ) {
							//id,imie, nazwisko, ocena, waga, data, opis  
				$oc_id = id;
				   document.getElementById("form2_uczen").innerHTML = imie + ' ' + nazwisko;
				   
				   document.getElementById("form2_data").innerHTML = data;
				   document.getElementById("opis_oceny2").innerHTML = opis;
				   
				   document.getElementById('select2_stopien').value = ocena;
				   document.getElementById('select2_waga').value = waga;
				   
				  document.getElementById("myForm2").style.display = "block";
				}

				function closeForm2() {
				  document.getElementById("myForm2").style.display = "none";
				}

				function edytuj() {
					
				var element_stopien2 = document.getElementById("select2_stopien");
				var s2 = element_stopien2.options[element_stopien2.selectedIndex].text;
				window.alert($oc_id);
				var element_waga2 = document.getElementById("select2_waga");
				var w2 = element_waga2.options[element_waga2.selectedIndex].text;
				 $.ajax({
					url: "edytujOcene.php",
					data: {
						ocena_id: $oc_id,
						stopien: s2,
						waga: w2,
						opis: $('#opis_oceny2').val()
						}, 
				});
				window.alert("Ocena została edytowana");
				document.getElementById("myForm2").style.display = "none";
				}


				function openForm(id,imie, nazwisko, np_id) {
			  
				$ucz_id = id;
				$np_id = np_id;
				  document.getElementById("form_uczen").innerHTML = imie + ' ' + nazwisko;
				  document.getElementById("myForm").style.display = "block";
				}

				function closeForm() {
				  document.getElementById("myForm").style.display = "none";
				}
				
				function dodaj() {
					
				var element_stopien = document.getElementById("select_stopien");
				var s = element_stopien.options[element_stopien.selectedIndex].text;
				window.alert(s);
				var element_waga = document.getElementById("select_waga");
				var w = element_waga.options[element_waga.selectedIndex].text;
				 $.ajax({
					url: "dodajOcene.php",
					data: {
						stopien: s,
						waga: w,
						opis: $('#opis_oceny').val(),
						uczen_id: $ucz_id,
						np_id:  $np_id 
						}, 
				});
				window.alert("Ocena została dodana");
				document.getElementById("myForm").style.display = "none";
				}


				function onChangeCmb() {
					
				var element = document.getElementById("cmbMake");
				var value = element.options[element.selectedIndex].value;
				var v = JSON.parse(value);
				 $.ajax({
					url: "./wyborKlasy.php",
					data: {
						id_klasy: v.k_id,
						np_klasy: v.np_id 
						}, 
				});
				setTimeout(function(){ window.location.reload(true); }, 100);
				}
				
				
				
					
	</script>
		
		
		<div id="tresc">
			<div id="lewy">
			<div>
				<form method="POST" >
					  <select class="myInput" style='  float: right; 'id="cmbMake" name="Make"  onchange="onChangeCmb()">
						 <?php
						 if(!isset($_SESSION['klasa_do_pokazu']))
						 { echo "<option value='0' selected>--Wybierz klasę--</option>";	 }
						 while($klasy = $result3 ->fetch_assoc() )
							 {
								$id_klasy =$klasy['klasa_ID'];
								$np_id = $klasy['nauczyciel_przedmiotu_ID'];
							   $values = '{"k_id":' . $id_klasy . ',"np_id":' .$np_id . '}';
							   if(isset($_SESSION['klasa_do_pokazu']) and $_SESSION['klasa_do_pokazu'] == $klasy['klasa_ID']){
							   echo '<option value='.$values.' selected>'.$klasy['oddzial'].' '.$klasy['przedmiot_nazwa'].'</option>';
							   }
							   else{
								   echo '<option value='.$values.'>'.$klasy['oddzial'].' '.$klasy['przedmiot_nazwa'].'</option>';
							   }
							 }
						 ?>
					</select>
				</form>
			</div>
			<br/><br/>
			
			<?php	
			if(isset($_SESSION['klasa_do_pokazu']) and $_SESSION['klasa_do_pokazu'] != 0)
				{
					
					$conn=new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
					$k_id = $_SESSION['klasa_do_pokazu'];
		
					$result = $conn->query("CALL lista_osob_w_klasie($k_id)");
					$conn->close();
					
					$conn=new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
					$k_id = $_SESSION['klasa_do_pokazu'];
		
					$result4 = $conn->query("CALL oceny_nauczyciela_w_klasie($n_id,$k_id)");
					$conn->close();
					
					

					
					echo "<table >";
					if($result->num_rows > 0) {
						$nr = 1;
						
						echo "<tr class='header'><th>";
						echo "Nr";
						echo "</th><th>";
						echo "Imie i nazwisko";
						echo "</th><th id='ocena' colspan=30>";
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
									
									if($uczen['stopien'] == 6) {$color = "rgb(255, 0, 102)";}
									if($uczen['stopien'] == 5) {$color = "rgb(153, 0, 0)";}
									if($uczen['stopien'] == 4) {$color = "rgb(204, 102, 0)";}
									if($uczen['stopien'] == 3) {$color = "rgb(0, 255, 0)";}
									if($uczen['stopien'] == 2) {$color = "rgb(255, 255, 0)";}
									if($uczen['stopien'] == 1) {$color = "rgb(0, 255, 255)";}
									if($uczen['stopien'] == 0) {$color = "rgb(0, 0, 255)";}
									echo "<td headers='ocena' style='width:20px;font-size:15px;'>";
									echo "<button class='button button3' style='background-color:$color;'
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
							$np_id = $_SESSION['np_klasy'];
							echo "<td><button class='button button2' style='width:30px;height:30px;'
							onClick='openForm(\"".$ucz_id."\" ,\"".$imie."\" , \"" . $nazw ."\", \"" . $np_id ."\"  )'
							style='display:inline-block;'>
							+
							</button></td>";
							
							
							echo "</tr>";
							$nr = $nr + 1;
						}
					}
					echo "</table>"; 
				}
				?>
			
			
		
			
		<div class="modal" id="myForm">
		  <form onSubmit="dodaj()" class="modal-content" method="POST" >
			<h1>Nowa ocena</h1>

			Uczeń: <p id="form_uczen" style="display:inline"></p><br>
			Data: <p id="form_data" style="display:inline"></p><br>
			<p style="display:inline"> Ocena:
			<select class='myInput' id="select_stopien" onchange="" required>
			<option value= 0>0</option>
			<option value= 1>1</option>
			<option value= 2>2</option>
			<option value= 3>3</option>
			<option value= 4>4</option>
			<option value= 5>5</option>
			<option value= 6>6</option>
			</select>
			</p><br>
			<p style="display:inline"> Waga: 
			<select class='myInput'  id="select_waga" onchange="" required>
			<option value= 0>0</option>
			<option value= 1>1</option>
			<option value= 2>2</option>
			<option value= 3>3</option>
			<option value= 4>4</option>
			<option value= 5>5</option>
			<option value= 6>6</option>
			<option value= 3>7</option>
			<option value= 4>8</option>
			<option value= 5>9</option>
			</select>
			</p><br>
			<textarea id="opis_oceny" style="width:100%;height:150px;resize: none;" maxlength=100 placeholder="Opis oceny"  > </textarea>
			<button class="button button2" style=" width:100px; height:30px; float: right;" type="button" onclick="closeForm()">Anuluj</button>
			<button class="button button2" style=" width:100px; height:30px; float: right;" id="btn" type="submit"  >Zatwierdź</button>
		  </form>
		</div>
		
		
		<div class="modal" id="myForm2">
		  <form onSubmit="edytuj()" class="modal-content" method="POST" >
			<h1>Edycja oceny</h1>

			Uczeń: <p id="form2_uczen" style="display:inline"></p><br>
			Data: <p id="form2_data" style="display:inline"></p><br>
			<p style="display:inline"> Ocena:
			<select class='myInput' id="select2_stopien" onchange="" required>
			<option value= 0>0</option>
			<option value= 1>1</option>
			<option value= 2>2</option>
			<option value= 3>3</option>
			<option value= 4>4</option>
			<option value= 5>5</option>
			<option value= 6>6</option>
			</select>
			</p><br>
			<p style="display:inline"> Waga: 
			<select class='myInput' id="select2_waga" onchange="" required>
			<option value= 0>0</option>
			<option value= 1>1</option>
			<option value= 2>2</option>
			<option value= 3>3</option>
			<option value= 4>4</option>
			<option value= 5>5</option>
			<option value= 6>6</option>
			<option value= 7>7</option>
			<option value= 8>8</option>
			<option value= 9>9</option>
			</select>
			</p><br>
			<textarea id="opis_oceny2" style="width:100%;height:150px;resize: none;" maxlength=100 placeholder="Opis oceny" > </textarea>
			<button class="button button2" style=" width:100px; height:30px; float: right;" type="button" onclick="closeForm2()">Anuluj</button>
			<button class="button button2" style=" width:100px; height:30px; float: right;" id="btn" type="submit"  >Zatwierdź</button>
		  </form>
		</div>
		
		
		</div>
			</div>	
		
		
		<div id="footer">
		e-dziennik
		</div>

	
	
	
	
	</div>
</body>

</html>