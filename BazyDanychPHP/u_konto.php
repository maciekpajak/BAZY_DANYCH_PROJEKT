<?php
session_start();
?>


<!DOCTYPE HTML>

<html lang="pl">
<head>
	<meta charset="utf-8" />
	<title>Tytuł</title>
	<meta name="description" content="opis w google"/>
	<meta name="keywords" content="słowa po których google szuka"/>

	<meta http-equiv="X-UA_Compatible" content="IE=edge,chrome=1" />
	<meta name="author" content="Kowalski, Mielniczek, Pająk" />

	<style>
	#container
	{
	border:  solid ;
	width: 1000px;
	margin-left: auto;
	margin-right: auto;
	
	
	}
	#logo
	{
	background:gray;
	text-align: center;
	padding: 15px;
	text-align: center;
	
	}
	#konto
	{
	border:  solid black;	
	float: left;
	background-color: lightgray;
	min-height: 25px;
	text-align: center;
	padding: 5px;
	color: black
	}
	
	
	#oceny
	{
	border:solid black;	
	float: left;
	min-height: 25px;
	text-align: center;
	padding: 5px;
	color: black
	
	}
	#frekwencja 
	{
	border:  solid black;
	float: left;
	min-height: 25px;
	padding: 5px;
	color: black
	
	}
	#terminarz 
	{
	border:  solid black;
	float: left;
	min-height: 25px;
	text-align: center;
	padding: 5px;
	color: black
	}
	
	
	#tresc
	{
	clear: both;
	text-align: left;
	min-height: 650px;
	}
	#lewy
	{
	float: left;
	padding:50px;
	margin-top:50px;
	text-align: left;
	margin-left:15px;
	font-size: 24px;
	min-width:400px;
	}
	#dane
	{
	margin-top:10px;
	
	text-align: left;
	margin-left:45px;
	font-size: 24px;
	line-height:1.7;
	}
	
	#prawy
	{	float: left;
	
	margin-top:100px;
	text-align: left;
	
	font-size: 24px;
	min-width:50px;
	}
	#zmianahasla
	{
	line-height:1.7;
	}
	
	
	
	#footer
	{
	clear: both;
	background-color: black;
	color: white;
	text-align: center;
	padding:20px;
	}
	
	
	
	</style>


</head>


<body>
		<?php 
	require_once "connect.php";
	
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
		
		
		$sql="SELECT * FROM uzytkownik WHERE uzytkownik_login='$login' AND haslo='$haslo'";
		$result = @$conn->query($sql);
	
					
		$dane_uzytkowanika=@mysqli_fetch_assoc($result);
		
				
				
		
		
		
		
			$conn->close();
			}
	
	
	?>
	<div id="container">
	
		<div id="logo">
		
			<h1>Zalogowano jako uczeń</h1>
		
		</div>
		
		<a href="u_konto.html">
		<div id="konto">
		Zarządzanie kontem
		</div>
		</a>
		
		
		<a href="u_oceny.html">
		<div id="oceny">
		 Oceny 
		</div></a>
		
		
		<a href="u_frekwencja.html">
		<div id="frekwencja">
		 Frekwencja
		</div> </a>	
		
		
		<a href="u_terminarz.html">
		<div id="terminarz">
		 Terminarz 
		</div>
		</a>	
		
		
		
		
		
		
		<div id="tresc">
			<div id="lewy">
			
			<B> Dane: </B><br/>
			<div id="dane">
				imie:  <?php echo $dane_uzytkowanika['imie'] ; ?>  <br/>
				nazwisko: <?php echo $dane_uzytkowanika['nazwisko'] ; ?>   <br/>
				klasa:  <br/>
				pesel: <br/>
				adres: <br/>
				login: <?php echo $dane_uzytkowanika['uzytkownik_login'] ; ?><br/>
				email: <?php echo $dane_uzytkowanika['email'] ; ?><br/>
			</div>
			
			</div>
			<div id="prawy">
				<B> Zmiana hasła: </B><br/>
				<div id="zmianahasla">
					stare hasło:<br/>
					<input type="text" name="stare"> <br/>
					nowe hasło:<br/>
					<input type="text" name="stare"><br/>
					powtórz nowe hasło:<br/>
					<input type="text" name="stare"><br/>
					<button type="button">Zatwierdź</button>
				</div>
				
			</div>
		
		</div>
		
		
		
		
		
		
		
		
		
		<div id="footer">
		e-dziennik
		</div>
	
	
	
	
	
	
	
	</div>
	
</body>





</html>