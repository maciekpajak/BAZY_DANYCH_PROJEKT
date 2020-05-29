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
	<link rel="Shortcut icon" href="favicon.ico" />

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
		
		
		<a href="r_uwagi.php">
		<div id="inne">
		Dziennik uwag
		</div> </a>	
		
		
		<a href="r_platnosci.php">
		<div id="inne">
		Płatności
		</div>
		</a>
		<a href="r_usprawiedliwienia.php">
		<div id="teraz">
		Usprawiedliwienia
		</div>
		</a>		
		
    <!-- ------------------------------------------------------- -->
    
    TU PIERWSZY SKRYPT
    
    <div id="tresc">
			<div id="lewy">
			
			<B> Lista nieobecności: </B><br/>

			
		</div>
    
    TU BEDZIE SKRYPT CALY
    
    <!-- ------------------------------------------------------- -->
		
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