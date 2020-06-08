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
		<div id="teraz">
		Edycja uczniów 
		</div></a>
		
		
		<a href="a_rodzice.php">
		<div id="inne">
		 Edycja rodziców
		</div> </a>	
		
		
		<a href="a_nauczyciele.php">
		<div id="inne">
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
		
		
		
	
		$result3=$conn->query("SELECT MAX(opiekunowie_id)+1 FROM rodzic_full_info");
		$pisz=mysqli_fetch_assoc($result3);
		$_SESSION['o_id']=$pisz['MAX(opiekunowie_id)+1'];
		//-----------------Szukanie--------------------------
		
		if(isset($_POST['ID_u']) OR isset($_POST['klasa_u']) OR isset($_POST['imie_u']) OR isset($_POST['nazwisko_u']) OR isset($_POST['pesel_u']) OR isset($_POST['email_u']) OR isset($_POST['opiekunowie_id_u']))
	{	

		$ID=$_POST['ID_u'];
		$klasa=$_POST['klasa_u'];
		$imie=$_POST['imie_u'];
		$nazwisko=$_POST['nazwisko_u'];
		$pesel=$_POST['pesel_u'];
		$email=$_POST['email_u'];
		$opiekunowie_id=$_POST['opiekunowie_id_u'];
		
		$sql="SELECT * FROM uczen_full_info WHERE uczen_ID='$ID' OR oddzial='$klasa' OR imie='$imie' OR nazwisko='$nazwisko' OR pesel='$pesel' OR email='$email' OR opiekunowie_id='$opiekunowie_id'";
		$result = @$conn->query($sql);
		
		
	}
	
	else
	{
		
	}
	

		
		
			$conn->close();
			}
	
	
	?>
		<div id="tresc">
			
		



<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
			<script language="javascript" type="text/javascript" >
		
				function dodaj_u() {
					
				 $.ajax({
					url: "dodaj_ucznia.php",
					data: {
						login: $('#login').val(),
						haslo: $('#haslo').val(),
						pesel: $('#pesel').val(),
						imie: $('#imie').val(),
						nazwisko: $('#nazwisko').val(),
						klasa: $('#klasa').val(),
						opiekunowie_id: $('#opiekunowie_id').val(),
						email: $('#email').val(),
						ulica: $('#ulica').val(),
						miejscowosc: $('#miejscowosc').val(),
						kod: $('#kod').val(),
						nr_domu: $('#nr_domu').val(),
						nr_mieszkania: $('#nr_mieszkania').val()
						
						} 
				});
				window.alert("uczeń został dodany");
				
				}
		</script>
		

		<div>
		
		
		  <form onSubmit="dodaj_u()" class="form-container" method="POST" >
			
			
			<h1>Dodaj ucznia:</h1>
				
		
		
		
	
			
					<input id="login" name="login" placeholder="login" required>
					
					<input id="haslo" name="haslo" placeholder="hasło" type="password" required>
					
					<input id="pesel" name="pesel" placeholder="pesel"  required>
					
					<input id="imie" name="imie" placeholder="imię" required>
					
					<input id="nazwisko" name="nazwisko" placeholder="nazwisko" required>
					
					<input id="klasa" name="klasa" placeholder="klasa" required>
					
					<input id="opiekunowie_id" name="opiekunowie_id" placeholder="ID opiekunów" required>
					
					<input id="email" name="email" placeholder="e-mail" required>
					
					<input id="ulica" name="ulica" placeholder="ulica" required>
					
					<input id="miejscowosc" name="miejscowosc" placeholder="miejscowość" required>
					
					<input id="kod" name="kod" placeholder="kod" required>
					
					<input id="nr_domu" name="nr_domu" placeholder="nr domu" required>
					
					<input id="nr_mieszkania" name="nr_mieszkania" placeholder="nr mieszkania" required>
					
					
			
			<button id="btn" type="submit" name="uspr"  >Dodaj</button>
			
		  </form>
		</div>
		
		

			
			<h3> Szukaj ucznia: </h3>
			
			
			
			<form action="a_uczniowie.php" method="post">

				
					<input name="ID_u" placeholder="ID ucznia">
					
					<input name="klasa_u" placeholder="klasa">
					
					<input name="imie_u" placeholder="imię">
					
					<input name="nazwisko_u" placeholder="nazwisko">
					
					<input name="pesel_u" placeholder="pesel">
					
					<input name="email_u" placeholder="e-mail">
					
					<input name="opiekunowie_id_u" placeholder="ID opiekunów">
					
					<button type="submit">Szukaj</button>
					
					</form>


<?php



		$sprawdzanie=0;
	if(isset($result)) {
		
		
		echo "<table border=5><tr><td>ID ucznia</td><td>klasa</td><td>nazwisko</td><td>imię</td><td>pesel</td><td>email</td><td>ID opiekunów</td><td>adres";
		while($dane_ucznia= $result->fetch_assoc()) {
					
		
			echo "</td></tr><tr>";
			
			echo 
							
			"<td>".$dane_ucznia['uczen_ID']."</td>".
			"<td>".$dane_ucznia['oddzial']."</td>".
			"<td>".$dane_ucznia['nazwisko']."</td>".
			"<td>".$dane_ucznia['imie']."</td>".
			"<td>".$dane_ucznia['pesel']."</td>".
			"<td>".$dane_ucznia['email']."</td>".
			"<td>".$dane_ucznia['opiekunowie_id']."</td>".
			"<td>".$dane_ucznia['ulica']." ".$dane_ucznia['nr_domu']."/".$dane_ucznia['nr_mieszkania']." ".$dane_ucznia['miejscowosc']." ".$dane_ucznia['kod'];
			
		
					}
					echo "</td></tr><br/></table>";
		        }
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