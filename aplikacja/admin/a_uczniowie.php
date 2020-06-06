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
			if(isset($_POST['add_ID_n']) OR isset($_POST['add_imie_n']) OR isset($_POST['add_nazwisko_n']) OR isset($_POST['add_nrtel_n']) OR isset($_POST['add_przedmiot_n']))
	{	

		$ID=$_POST['add_ID_n'];
		$imie=$_POST['add_imie_n'];
		$nazwisko=$_POST['add_nazwisko_n'];
		$nr_tel=$_POST['add_nrtel_n'];
		$przedmiot=$_POST['add_przedmiot_n'];
		
		$sql2="SELECT * FROM nauczyciel_full_info WHERE ID='$ID' OR imie='$imie' OR nazwisko='$nazwisko' OR nr_tel='$nr_tel' OR przedmiot='$przedmiot'";
		$result2 = @$conn->query($sql2);
	
	}
	
	else
	{
		
	}		
		
		
	
		
		
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
		<B> Dodaj nauczyciela: </B><br/>
					<form action="a_nauczyciele.php" method="post">

				
					<input name="add_ID_n" placeholder="ID">
					
					<input name="add_imie_n" placeholder="imię">
					
					<input name="add_nazwisko_n" placeholder="nazwisko">
					
					<input name="add_nrtel_n" placeholder="nr telefonu">
					
					<input name="add_przedmiot_n" placeholder="przedmiot">
					
					<button type="submit">Dodaj</button>
					
					</form>
<?php
if(isset($result2)) {
	echo "Nauczyciel został dodany prawidłowo";
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