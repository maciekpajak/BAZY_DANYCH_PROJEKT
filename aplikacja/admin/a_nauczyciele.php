<?php

    session_start();
	
	if(!isset($_SESSION['uzytkownik_login']) || !isset($_SESSION['haslo']))
	{
		session_unset(); 
		session_destroy();
		header('Location: ../index.php');
	}
	
	if(isset($_SESSION['action'])) 
	{
		$duration = time() - (int)$_SESSION['action'];
			if($duration > $_SESSION['timeout']) 
			{
				session_unset(); 
				session_destroy();
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

	<link rel="stylesheet" href="../Styles/styleApp.css" type="text/css" />
	<link rel="Shortcut icon" href="favicon.ico" />
	
	<meta name="description" content="opis w google"/>
	<meta name="keywords" content="słowa po których google szuka"/>

	<meta http-equiv="X-UA_Compatible" content="IE=edge,chrome=1" />
	<meta name="author" content="Kowalski, Mielniczek, Pająk" />

</head>



<script>
// Set the date we're counting down to
	var countDownDate = new Date().getTime();
	countDownDate.setMinutes(now.getMinutes() + 30);
	alert(countDownDate);
	
	// Update the count down every 1 second
	var x = setInterval(function() {

	  // Get today's date and time
	  var now = new Date().getTime();

	  // Find the distance between now and the count down date
	  var distance = countDownDate - now;

	  // Time calculations for days, hours, minutes and seconds
	  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
	  var seconds = Math.floor((distance % (1000 * 60)) / 1000);

	  // Display the result in the element with id="demo"
	  document.getElementById("demo").innerHTML = minutes + "m " + seconds + "s ";

	  // If the count down is finished, write some text
	  if (distance < 0) {
		clearInterval(x);
		document.getElementById("demo").innerHTML = "EXPIRED";
	  }
}, 1000);
</script>



<body>

	<p id="demo"></p>



	<div id="container">
	
		<div id="logo">
		
			<h1>Zalogowano jako administrator</h1>
		
		</div>
		
		<a href="a_konto.php">
		<div id="inne">
		Zarządzanie kontem
		</div>
		</a>
		
		
		<a href="a_uczniowie.php">
		<div id="inne">
		Edycja uczniów 
		</div></a>
		
		
		<a href="a_rodzice.php">
		<div id="inne">
		 Edycja rodziców
		</div> </a>	
		
		
		<a href="a_nauczyciele.php">
		<div id="teraz">
		Edycja nauczycieli
		</div>
		</a>	
		
		
		
		
		
				<?php 
	unset($_SESSION['blad']);
	
	require_once "../connect.php";
	
	$conn=@new mysqli($IP, $username, $password, $DB_name); 
		                                   /*("adres IP", "username","password", "DB_name")*/
	if ($conn->connect_errno!=0)
	{
		echo "Error: ".$conn->connect_errno;
	}
	else
	{

		$login=$_SESSION['uzytkownik_login'];
		
		$haslo = $_SESSION['haslo'];
		
		
		
	
		
		
		//-----------------Szukanie--------------------------
		
		if(isset($_POST['ID_n']) OR isset($_POST['imie_n']) OR isset($_POST['nazwisko_n']) OR isset($_POST['nrtel_n']) OR isset($_POST['przedmiot_n']))
	{	

		$ID=$_POST['ID_n'];
		$imie=$_POST['imie_n'];
		$nazwisko=$_POST['nazwisko_n'];
		$nr_tel=$_POST['nrtel_n'];
		$przedmiot=$_POST['przedmiot_n'];
		
		$sql="SELECT * FROM nauczyciel_full_info WHERE ID='$ID' OR imie='$imie' OR nazwisko='$nazwisko' OR nr_tel='$nr_tel' OR przedmiot='$przedmiot'";
		$result = @$conn->query($sql);
		
		
		
		
		
		
	}
	
	else
	{
		
	}
	
	//--------------------Dodawanie--------------------------------------------------
	/*
			if(isset($_POST['login']) and isset($_POST['haslo']) and isset($_POST['imie']) and isset($_POST['nazwisko']) and isset($_POST['email']) and isset($_POST['nr_tel']) and isset($_POST['czy_wych']))
	{	

		$login=$_POST['login'];
		$haslo=$_POST['haslo'];
		$imie=$_POST['imie'];
		$nazwisko=$_POST['nazwisko'];
		$email=$_POST['email'];
		$nr_tel=$_POST['nr_tel'];
		$czy_wych=$_POST['czy_wych'];
		
		$result2 = $conn->query("CALL dodaj_nauczyciela('$login','$haslo','$imie','$nazwisko','$email','$nr_tel','$czy_wych')");
		
	
	}
	
	else
	{
		
	}		
		
		*/
	
		
		
			$conn->close();
			}
	
	
	?>
		<div id="tresc">
			<br/>
			<B> Szukaj nauczyciela: </B><br/>
			
			
			
			<form action="a_nauczyciele.php" method="post">

				
					<input name="ID_n" placeholder="ID">
					
					<input name="imie_n" placeholder="imię">
					
					<input name="nazwisko_n" placeholder="nazwisko">
					
					<input name="nrtel_n" placeholder="nr telefonu">
					
					<input name="przedmiot_n" placeholder="przedmiot">
					
					<button type="submit">Szukaj</button>
					
					</form>


<?php



		$sprawdzanie=0;
	if(isset($result)) {
		while($dane_nauczyciela = $result->fetch_assoc()) {
					
		if($sprawdzanie!=	$dane_nauczyciela['ID'])
		{
			echo "ID: ".$dane_nauczyciela['ID']." ";
			echo "nazwisko: ".$dane_nauczyciela['nazwisko']." ";
			echo "imię: ".$dane_nauczyciela['imie']." ";
			echo "nr telefonu: ".$dane_nauczyciela['nr_tel']." ";
			echo "email: ".$dane_nauczyciela['email']."<br/>";
			$sprawdzanie=$dane_nauczyciela['ID'];
		}
					}
		        }
?>			
		



<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
			<script language="javascript" type="text/javascript" >
		
				function dodaj_n() {
					
				 $.ajax({
					url: "dodaj_nauczyciela.php",
					data: {
						login: $('#login').val(),
						haslo: $('#haslo').val(),
						imie: $('#imie').val(),
						nazwisko: $('#nazwisko').val(),
						email: $('#email').val(),
						nr_tel: $('#nr_tel').val(),
						czy_wych: $('#czy_wych').val(),
						przedmiot_in: $('#przedmiot_in').val()
						}, 
				});
				window.alert("Nauczyciel został dodoany");
				
				}
		</script>
		
		
		
					<form action="a_nauczyciele.php" method="post">

				

					
					
					
					</form>
		
		
		
		
		
		
		
		<div>
		  <form onSubmit="dodaj_n()" class="form-container" method="POST" >
			<h1>Dodaj nauczyciela:</h1>
					<input id="login" name="login" placeholder="login" required>
					
					<input id="haslo" name="haslo" placeholder="hasło" type="password" required>
					
					<input id="imie" name="imie" placeholder="imię" required>
					
					<input id="nazwisko" name="nazwisko" placeholder="nazwisko" required>
					
					<input id="email" name="email" placeholder="e-mail" required>
					
					<input id="nr_tel" name="nr_tel" placeholder="nr telefonu" required>
					
					<input id="czy_wych" name="czy_wych" placeholder="czy wychowawca(Y/N)" required>
					
					<input id="przedmiot_in" name="przedmiot_in" placeholder="przedmiot nauczania" required>
			
			<button id="btn" type="submit" name="uspr"  >Dodaj</button>
			
		  </form>
		</div>


<?php
/*
if(isset($result2)) {
	echo "Coś zrobiło";
	}

*/
?>
		
		
		
		
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