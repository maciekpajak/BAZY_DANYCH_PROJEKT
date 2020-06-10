<?php

    session_start();
	
	if(!isset($_SESSION['uzytkownik_login']) || !isset($_SESSION['haslo']))
	{
		session_unset(); 
		session_destroy();
		session_start();
		header('Location: ../index.php');
	}
	
	if(isset($_SESSION['action'])) 
	{
		$duration = time() - (int)$_SESSION['action'];
			if($duration > $_SESSION['timeout']) 
			{
				session_destroy();
				session_start();
				header('Location: ../index.php');
			}
	}
 
	$_SESSION['action'] = time();
?>

<script type="text/javascript">
setTimeout( function() { alert("Twoja sesja zakończyła się"); location.reload(); }, 180*1000);
</script>


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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>

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


	<div >
		<div id="tresc">
			<div id="lewy">
			
			<script language="javascript" type="text/javascript" >
			
				$(document).ready(function(){
			  $("#myInput").on("keyup", function() {
				var value = $(this).val().toLowerCase();
				$("#myTable tr").filter(function() {
				  $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
				});
			  });
			});
			
			
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
				setTimeout(function(){ window.location.reload(true); }, 1000);
				document.getElementById("myForm").style.display = "none";
				
			  }
			  
			   function openForm2(id , klasa, data, godz, przedmiot) {
				  
				  $id_lekcji = id;
				  document.getElementById("form2_data").innerHTML = data;
				  document.getElementById("form2_godz").innerHTML = godz;
				  document.getElementById("form2_przedmiot").innerHTML = przedmiot;
				  document.getElementById("form2_klasa").innerHTML = klasa;
				  document.getElementById("myForm2").style.display = "block";
				}
			  
			  function closeForm2() {
				  document.getElementById("myForm2").style.display = "none";
				}
				
				function zaplanuj() {
					
				$.ajax({
					url: "./zaplanuj.php",
					data: {
						id_lekcji: $id_lekcji,
						opis: $('#opis_wydarzenia').val(),
						typ: $('#form2_typ').val()
					}, 
				});
					
				  document.getElementById("myForm2").style.display = "none";
				}
				
			function myFunction() {
			  // Declare variables
			  var input, filter, table, tr, td, i, txtValue;
			  input = document.getElementById("kiedy");
			  filter = input.value.toUpperCase();
			  table = document.getElementById("Table");
			  tr = table.getElementsByTagName("tr");
			  var today = new Date();
				//var today = new Date("2020-09-01T09:00:00"); //data do tesów
				if(filter == "T")
				{
					
				  for (i = 0; i < tr.length; i++) {
					td = tr[i].getElementsByTagName("td")[0];
					if (td) {
					  txtValue = td.textContent || td.innerText;
					  var date = new Date(txtValue);
					  if (date.valueOf() === today.valueOf() ) {
						tr[i].style.display = "";
					  } else {
						tr[i].style.display = "none";
					  }
					}
				  }
			  }
			  
			  else if(filter == "F")
				{
					
				  for (i = 0; i < tr.length; i++) {
					td = tr[i].getElementsByTagName("td")[0];
					td2 = tr[i].getElementsByTagName("td")[1];
					if (td) {
					  txtValue = td.textContent || td.innerText;
					  txtValue2 = td2.textContent || td2.innerText;
					  var dateWithTime = txtValue + "T" + txtValue2;
					  var date = new Date(dateWithTime);
					  if (date.valueOf() > today.valueOf() ) {
						tr[i].style.display = "";
					  } else {
						tr[i].style.display = "none";
					  }
					}
				  }
			  }
			  else if(filter == "P")
				{
					
				  for (i = 0; i < tr.length; i++) {
					td = tr[i].getElementsByTagName("td")[0];
					td2 = tr[i].getElementsByTagName("td")[1];
					if (td) {
					  txtValue = td.textContent || td.innerText;
					  txtValue2 = td2.textContent || td2.innerText;
					  var dateWithTime = txtValue + "T" + txtValue2;
					  var date = new Date(dateWithTime);
					  if (date.valueOf() < today.valueOf() ) {
						tr[i].style.display = "";
					  } else {
						tr[i].style.display = "none";
					  }
					}
				  }
			  }
			  else{
					
				  for (i = 0; i < tr.length; i++) {
						tr[i].style.display = "";
				  }
			  }
			}
			</script>
			
			<div>
				<form >
					<input class="myInput"  type="text"  id="myInput" placeholder="Wyszukaj.." style='width: 200px;float:right;' ></input><br>
				  <select class="myInput" onchange="myFunction()" id="kiedy" style='width: 200px;float:right; '>
				  <option value="all">Wszystkie</option>
				  <option value="f">Przyszłe</option>
				  <option value="p">Przeszłe</option>
				  <option value="t">Dzisiaj</option>
				  </select>
				</form>
			</div>
			<br>
			<?php
			date_default_timezone_set('Europe/Warsaw');
			$date = date('Y-m-d', time());
			#$d=mktime(11, 40, 54, 8, 12, 2014);
			#$date1 = date('G:i:s', $d);
			#$date = "2020-09-12"; //data do testowania
		    if($result3->num_rows > 0) {
				
				echo "<table id='Table'>";
				echo "<tr class='header'>";
				echo "<th style='width:10%;'>Data</th>";
				echo "<th style='width:10%;'>Godzina</th>";
				echo "<th style='width:10%;'>Przedmiot</th>";
				echo "<th style='width:10%;'>Sala</th>";
				echo "<th style='width:10%;'>Klasa</th>";
				echo "<th style='width:10%;'>Temat</th>";
				echo "<th style='width:20%;' colspan=3></th>";
				echo '</tr>';
				echo "<tbody id='myTable'>";
		        while($row3 = $result3->fetch_assoc()) {
					
					echo "<tr>";
					echo "<td>" . $row3['data'] . "</td>";
					echo "<td>" . $row3['godz_start'] . "</td>";
					echo "<td>" . $row3['przedmiot'] . "</td>";
					echo "<td>" . $row3['sala'] . "</td>";
					echo "<td>" . $row3['oddzial'] . "</td>";
					echo "<td>";
					echo '<textarea style="resize: vertical; width:200px;hight:20px; max-height: 300px; min-height: 20px;" disabled>' .$row3['temat'].'</textarea>';
					echo "</td>";
					$temat = $row3['temat'];
					
					$id_klasy = $row3['klasa_id'];
					$id_lekcji = $row3['lekcja_ID'];
					$oddzial_klasy = $row3['oddzial'];
					
					echo "<td>";
					echo "
					<button class='button button2' onClick='openForm(\"".$id_lekcji."\" , \"" . $temat ."\")'> 
						Edytuj temat
					</button>";
					
					echo '</td><td>';
					if($row3['czy_spr_obec'] == 'N' )
					{
						if ( $row3['data'] == $date and $row3['godz_start'] <= time() ){
						echo "
						<button  class='button button2'   onClick='sprawdzObecnosc(\"".$id_klasy."\" , \"".$id_lekcji."\" ,\"" . $oddzial_klasy."\")'>
							Sprawdź obecność
						</button>";}
						else{
							echo "
						<button class='button' style='width:70px;height:70px;' disabled>
							Sprawdź obecność
						</button>";}
					}
					else
					{
						echo "
						<button class='button button2'  onClick='edytujObecnosc(\"".$id_klasy."\" , \"".$id_lekcji."\" ,\"" . $oddzial_klasy."\")'>
							Edytuj obecność
						</button>";
					}
					
					echo '</td><td>';
					$data = $row3['data'];
					$godz = $row3['godz_start'];
					$przedmiot = $row3['przedmiot'];
					
					echo "
						<button class='button button2' onClick='openForm2(\"".$id_lekcji."\" ,\"" . $oddzial_klasy."\",\"" . $data."\",\"" . $godz."\",\"" . $przedmiot."\")'>
							Zaplanuj
						</button>";
					
					
					echo '</td></tr>';
					
					
		        }
				echo "</tbody>";
				echo '</table>';
		    }
			
			
			?>
			

			</div>
		</div>
		
		
		<div class="modal" id="myForm">
		  <form onSubmit="edytujTemat()" class="modal-content" method="POST" style="height:300px">
			<h1>Edytuj temat</h1>
			<textarea id="textarea_temat" style="width:100%;height:150px;resize: none;" maxlength=100 ></textarea>
			<button class="button button2" style=" width:100px; height:30px; float: right;" type="button" onclick="closeForm()">Anuluj</button>
			<button class="button button2" style=" width:100px; height:30px; float: right;" id="btn" type="submit" name="uspr"  >Zatwierdź</button>
		  </form>
		</div>	
		
		<div class="modal" id="myForm2">
		  <form onSubmit="zaplanuj()" class="modal-content" method="POST" >
			<h1>Zaplanuj</h1>
			Data:  <p id="form2_data" style="display:inline"></p><br>
			Godzina:  <p id="form2_godz" style="display:inline"></p><br>
			Klasa:  <p id="form2_klasa" style="display:inline"></p><br>
			Przemiot:  <p id="form2_przedmiot" style="display:inline"></p><br><br>
			<select class="myInput" id="form2_typ">
			<option value="Sprawdzian"> Sprawdzian </option>
			<option value="Kartkówka"> Kartkówka </option>
			<option value="Zadanie domowe"> Zadanie domowe </option>
			<option value="Inne"> Inne </option>
			</select><br><br>
			<textarea id="opis_wydarzenia" style="width:100%;height:150px;resize: none;" maxlength=100 ></textarea><br><br><br>
			<button class="button button2" style=" width:100px; height:30px; float: right;" type="button" onclick="closeForm2()">Anuluj</button>
			<button class="button button2" style=" width:100px; height:30px; float: right;" id="btn" type="submit" name="uspr"  >Zatwierdź</button>
		  </form>
		</div>	
		
		
		

		
		<div id="footer">
		e-dziennik
		</div>

	
	
	</div>
	
</body>

</html>