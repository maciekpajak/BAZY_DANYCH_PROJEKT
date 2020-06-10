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
	
	<title>Konto ucznia</title>
	<META http-equiv="content-type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="../Styles/styleApp.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/form.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/table.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/myInput.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/button.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/modal.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/tooltip.css" type="text/css" />
	
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
		<div id="teraz">
		 Frekwencja
		</div> </a>	
		
		
		<a href="r_terminarz.php">
		<div id="inne">
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
		
		
		
		if(isset($_SESSION['wybrane_dziecko_id']) and $_SESSION['wybrane_dziecko_id'] != 0)
			{
				$uczen_id = $_SESSION['wybrane_dziecko_id'];
				
				$result3 = $conn->query("CALL frekwencja_ucznia($uczen_id)");
			}	
		
		
	}
	
	?>
	
		<div id="tresc">
		<div id="lewy">
			
		<?php
		
		if(isset($_SESSION['wybrane_dziecko_id']) and $_SESSION['wybrane_dziecko_id'] != 0  )
			{
				echo "<table>";
				echo "<tr class='header'><th  style='width:20%;'>Data</th>";
				echo "<th colspan=30 id='frekwencja' style='width:80%;'>Frekwencja</th></tr>";
				if($result3->num_rows > 0) {
					$data=0;
					echo "<tr>";
					$i=0;
					while($row3 = $result3->fetch_assoc())
					{		
						if ($row3['status']=='obecny'){$status='O';$color = "rgb(153, 255, 153)";}	
						if($row3['status']=='spóźniony'){$status='S'; $color = "rgb(204, 255, 255)";}
						if($row3['status']=='nieobecny'){$status='N';$color="rgb(255,102,102)";}
						if($row3['czy_do_uspr']=='Y'){$status .= '?';$color = "rgb(255, 255, 128)";}
						if($row3['czy_uspr']=='Y'){$status .= '*'; $color = "rgb(163, 102, 255)"; }
						
						$start = $row3['godz_start'];
						$koniec = $row3['godz_koniec'];
						$godzina = $start . "-" . $koniec;
						$nauczyciel = $row3['imie'] . " " . $row3['nazwisko'] ;
						$przedmiot = $row3['przedmiot'];
						
						$id = $row3['obecnosc_ID'];
						
						if($row3['data']!=$data)
						{while( $i < 30 )
							{
								echo "<td headers='frekwencja' style='width:20px;font-size:15px;'></td>";
								$i = $i + 1;
							}
							$i=0;
							echo "</tr><tr><td>";
								echo $row3['data'];
							$data= $row3['data'];
						}
						echo "</td><td>
						<button class='button button3' style='background-color:$color;' 
						onClick='openForm(\"".$id."\" , \"" . $row3['status'] ."\", \"" . $godzina ."\", \"" . $przedmiot ."\", \"" . $nauczyciel ."\")' > 
						<div class=\"tooltip\">
						$status
							<span class=\"tooltiptext\">
							$przedmiot<br>$godzina
							</span>
						</div></button></td>";
							
						
						
					}
					while( $i < 30 )
					{
						echo "<td headers='frekwencja' style='width:20px;font-size:15px;'></td>";
						$i = $i + 1;
					}
				}	
			
				echo "</tr></table>"; 	
			}
			?>
			

		</div>
		</div>
		
		
		<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
			<script language="javascript" type="text/javascript" >
			  function openForm(id , status, godzina, przedmiot, nauczyciel) {
				  
				  $id_obecnosci_do_uspr = id;
				  document.getElementById("form_status").innerHTML = status;
				  document.getElementById("form_przedmiot").innerHTML = przedmiot;
				  document.getElementById("form_nauczyciel").innerHTML = nauczyciel;
				  document.getElementById("form_godzina").innerHTML = godzina;
				  document.getElementById("myForm").style.display = "block";
				}

				function closeForm() {
				  document.getElementById("myForm").style.display = "none";
				}
				
				function usprawiedliw() {
					
				 $.ajax({
					url: "usprawiedliw.php",
					data: {
						id: $id_obecnosci_do_uspr,
						tresc: $('#textarea').val()
						}, 
				});
				window.alert("Usprawiedliwienie zostało pomyślnie wysłane");
				document.getElementById("myForm").style.display = "none";
				}
				
				
				function onChangeCmb() {
						
					var element = document.getElementById("cmbMake");
					var value = element.options[element.selectedIndex].value;
					 $.ajax({
						url: "cmbChange.php",
						data: {
							id_wysw_ucznia: value
							}, 
					});
					window.alert("Zmianiono ucznia");
					}
		</script>
		
		
		
		<div class="modal" id="myForm">
		  <form onSubmit="usprawiedliw()" class="modal-content" method="POST" >
			<h1>Usprawiedliwienie</h1>

			<p id="form_status" style="display:inline"></p><br><br>
			Przedmiot: <p id="form_przedmiot" style="display:inline"></p><br><br>
			Nauczyciel: <p id="form_nauczyciel" style="display:inline"></p><br><br>
			Godzina: <p id="form_godzina" style="display:inline"></p><br><br>
			<textarea id="textarea" style="width:100%;height:150px;resize: none;" maxlength=100 placeholder="Treść usprawiedliwienia..." required > </textarea>
			<button class="button button2" style=" width:100px; height:30px; float: right;" type="button" onclick="closeForm()">Anuluj</button>
			<button class="button button2" style=" width:100px; height:30px; float: right;" id="btn" type="submit"  >Zatwierdź</button>
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

