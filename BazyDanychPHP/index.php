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
	
	
	padding:50px;
	text-align: center;
	
	}
	
	#tresc
	{
	
	font-size:25px;
	margin-left:400px;
	margin-bottom:50px;
	line-height:1.5;
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
	
	<div id="container">
	
		<div id="logo">
		
			<h1>Dziennik elektroniczny</h1>
		
		</div>
		
		<form action="zaloguj.php" method="post">
		<div id="tresc">
		
		login:<br/>
		<input type="text" name="login"/><br/>
		hasło:<br/>
		<input type="password" name="haslo"/><br/>
		<a href="niepamietamhasla.php" style="font-size:20px">
		Nie pamiętam hasła
		</a>
		<br/>
		<button type="submit">Zaloguj</button>
		<br/>
		<?php
		
		if(isset($_SESSION['blad']))
		echo $_SESSION['blad'];
		?>
		
		
		
		</div>
		</form>
		
		
		
		
		<div id="footer">
		e-dziennik
		</div>
	
	
	
	
	
	
	
	</div>
	
</body>





</html>