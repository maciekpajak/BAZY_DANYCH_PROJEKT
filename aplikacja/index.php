<?php
	session_start();
?>
<!DOCTYPE HTML>

<html lang="pl">
<head>
	<meta charset="utf-8" />
	<title>Dziennik elektroniczny</title>
	<meta name="description" content="opis w google"/>
	<meta name="keywords" content="słowa po których google szuka"/>

    <link rel="stylesheet" href="Styles/styleLogin.css" type="text/css" />
    <link rel="stylesheet" href="Styles/button.css" type="text/css" />

	<meta http-equiv="X-UA_Compatible" content="IE=edge,chrome=1" />
	<meta name="author" content="Kowalski, Mielniczek, Pająk" />

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
		<button class="button button2" style=" width:100px; height:30px; f"  type="submit"  >ZALOGUJ</button>
		<br/>
		<?php
		
		if(isset($_SESSION['blad']))
		{
		echo $_SESSION['blad'];
		
		}
		?>
		
		
		
		</div>
		</form>
		
		
		
		
		<div id="footer">
		e-dziennik
		</div>
	
	
	
	
	
	
	
	</div>
	
</body>





</html>