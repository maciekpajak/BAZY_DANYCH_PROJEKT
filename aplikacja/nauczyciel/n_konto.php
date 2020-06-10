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
		
			$conn->close();
			}

	?>

	<div id="container">
	
	
		
		
		<div id="logo">
		
			<h1>Zalogowano jako nauczyciel</h1>
		
		</div>
		
		<a href="n_konto.php">
		<div id="teraz">
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
		<div id="inne">
		Klasa wychowawcza
		</div></a>';	
		
		?>


		<div id="tresc">
			<div id="lewy">
			
			<B> Dane: </B><br/>
			<div id="dane">
				imie:  <?php echo $dane_uzytkowanika['imie'] ; ?>  <br/>
				nazwisko: <?php echo $dane_uzytkowanika['nazwisko'] ; ?>   <br/>
				Nr tel: <?php echo $dane_nauczyciela['nr_tel'] ; ?>  <br/>
				login: <?php echo $dane_uzytkowanika['uzytkownik_login'] ; ?><br/>
				email: <?php echo $dane_uzytkowanika['email'] ; ?><br/>
			</div>
			
			</div>
	
				
					<div id="prawy">	
					</div>		
				<div id="prawy">			
						
					</form>
					<B> Zmiana loginu: </B><br/>
					<form action="../zmiana_login.php" method="post">
						<div id="zmianahasla">
							nowy login:<br/>
							<input name="nowy_login"><br/>
							hasło:<br/>
							<input type="password" name="haslo_L"><br/>
							<button type="submit">Zatwierdź</button>
							
							
						</div>
					</form>
					</div>

					<div id="prawy">	
					</div>
					  <div id="prawy">	
					</div> 
					<div id="prawy">
					
					<form action="zmiana_hasla.php" method="post">
				
						<B> Zmiana hasła: </B><br/>
						<div id="zmianahasla">
							stare hasło:<br/>
							<input type="password" name="stare"> <br/>
							nowe hasło:<br/>
							<input type="password" name="nowe"><br/>
							powtórz nowe hasło:<br/>
							<input type="password" name="p_nowe"><br/>
							<button type="submit">Zatwierdź</button>
							
						</div>
				</div>	

		</div>
		
		
		<div id="footer">
		e-dziennik
		</div>

	
	
	</div>
	
</body>

</html>