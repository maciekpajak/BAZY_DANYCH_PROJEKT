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
		
			<h1>Frekwencja na lekcji</h1>
		
		</div>
		<?php 
	unset($_SESSION['blad']);
	
	
	$conn=new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 

	$id_lekcji = $_SESSION['id_lekcji1'];
	if(isset($_POST['lista_uczniow'])){
		
		foreach($_POST['lista_uczniow'] as $id_ucz) {
			
			$status = "nieobecny";
			if(isset($_POST['list']) ){
				
				if (in_array($id_ucz,$_POST['list']))
				{
					$status = "obecny";
				}
			}
		$conn->query("CALL dodaj_obecnosc('$status','$id_ucz','$id_lekcji')");
	}
	
	
	$conn->query("UPDATE lekcja SET czy_spr_obec='Y' WHERE lekcja_ID='$id_lekcji'");
	
}


$conn->close();
	?>
	<div>
		
		

		<div id="tresc">
			<div id="lewy">
			Obecność została zatwierdzona. Kliknij 
		<a  href="javascript:window.opener.location.reload(true);window.close();">tutaj</a>
			aby zamknąć kartę.
		</div>
		</div>
		
		<div id="footer">
		e-dziennik
		</div>

	
	
		
	
	
</body>

</html>