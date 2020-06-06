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
		<div id="teraz">
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
		
		
		
	
		
		
		//-----------------Szukanie--------------------------
		
		if(isset($_POST['ID_r']) OR isset($_POST['imie_r']) OR isset($_POST['nazwisko_r']) OR isset($_POST['nrtel_r']) OR isset($_POST['email_r']) OR isset($_POST['opiekunowie_id_r']))
	{	

		$ID=$_POST['ID_r'];
		$imie=$_POST['imie_r'];
		$nazwisko=$_POST['nazwisko_r'];
		$nr_tel=$_POST['nrtel_r'];
		$email=$_POST['email_r'];
		$opiekunowie_id=$_POST['opiekunowie_id_r'];
		
		$sql="SELECT * FROM rodzic_full_info WHERE rodzic_ID='$ID' OR imie='$imie' OR nazwisko='$nazwisko' OR nr_telefonu='$nr_tel' OR email='$email' OR opiekunowie_id='$opiekunowie_id'";
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
		
				function dodaj_r() {
					
				 $.ajax({
					url: "dodaj_rodzica.php",
					data: {
						login: $('#login').val(),
						haslo: $('#haslo').val(),
						imie: $('#imie').val(),
						nazwisko: $('#nazwisko').val(),
						nr_tel: $('#nr_tel').val(),
						email: $('#email').val(),
						opiekunowie_id: $('#opiekunowie_id').val(),
						
						}, 
				});
				window.alert("Rodzic został dodany");
				
				}
		</script>
		

		<div>
		
		
		  <form onSubmit="dodaj_r()" class="form-container" method="POST" >
			
			
			<h1>Dodaj rodzica:</h1>
			
			
					<input id="login" name="login" placeholder="login" required>
					
					<input id="haslo" name="haslo" placeholder="hasło" type="password" required>
					
					<input id="imie" name="imie" placeholder="imię" required>
					
					<input id="nazwisko" name="nazwisko" placeholder="nazwisko" required>
					
					<input id="nr_tel" name="nr_tel" placeholder="nr telefonu" required>
					
					<input id="email" name="email" placeholder="e-mail" required>
					
					<input id="opiekunowie_id" name="opiekunowie_id" placeholder="ID opiekunów">
					

			
			<button id="btn" type="submit" name="uspr"  >Dodaj</button>
			
		  </form>
		</div>
		
		

			
			<h3> Szukaj rodzica: </h3>
			
			
			
			<form action="a_rodzice.php" method="post">

				
					<input name="ID_r" placeholder="ID rodzica">
					
					<input name="imie_r" placeholder="imię">
					
					<input name="nazwisko_r" placeholder="nazwisko">
					
					<input name="nrtel_r" placeholder="nr telefonu">
					
					<input name="email_r" placeholder="e-mail">
					
					<input name="opiekunowie_id_r" placeholder="ID opiekunów">
					
					<button type="submit">Szukaj</button>
					
					</form>


<?php



		$sprawdzanie=0;
	if(isset($result)) {
		
		
		echo "<table border=5><tr><td>ID rodzica</td><td>nazwisko</td><td>imię</td><td>nr telefonu</td><td>email</td><td>ID opiekunów";
		while($dane_rodzica = $result->fetch_assoc()) {
					
		if($sprawdzanie!=	$dane_rodzica['rodzic_ID'])
		{	echo "</td></tr><tr>";
			$sprawdzanie=$dane_rodzica['rodzic_ID'];
			echo 
							
			"<td>".$dane_rodzica['rodzic_ID']."</td>".
			"<td>".$dane_rodzica['nazwisko']."</td>".
			"<td>".$dane_rodzica['imie']."</td>".
			"<td>".$dane_rodzica['nr_telefonu']."</td>".
			"<td>".$dane_rodzica['email']."</td>".
			"<td>".$dane_rodzica['opiekunowie_id'];
			
		}
		else
		{
		
		}
		
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