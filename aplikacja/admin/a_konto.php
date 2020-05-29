<?php
session_start();
?>


<!DOCTYPE HTML>

<html lang="pl">
<head>
    
	<meta charset="utf-8" />
	<title>Zarządzanie kontem administratora</title>
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
		
			<h1>Zalogowano jako Admin</h1>
		
		</div>
		
		<a href="a_konto.php">
		<div id="teraz">
		Zarządzanie kontem
		</div>
		</a>
		
		
		<a href="a_edycja_kont.php">
		<div id="inne">
		Edycja kont użytkowanika 
		</div></a>
		
		
		<a href="a_edycja_uczniow.php">
		<div id="inne">
		Edycja uczniów 
		</div></a>
			
			
		<a href="a_edycja_rodzicow.php">
		<div id="inne">
		Edycja rodziców 
		</div></a>
		
		<a href="a_edycja_pracownikow.php">
		<div id="inne">
		Edycja pracowników 
		</div></a>
		
		<a href="a_edycja_klas.php">
		<div id="inne">
		Edycja klas 
		</div></a>
		
		<a href="a_nagany.php">
		<div id="inne">
		Nagany 
		</div></a>
		
		<a href="a_swiadectwa.php">
		<div id="inne">
		Generuj świadectwa 
		</div></a>
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
		
		
		$sql="SELECT * FROM uzytkownik WHERE uzytkownik_login='$login' AND haslo='$haslo'";
		$result = @$conn->query($sql);
	
		$sql2="SELECT * FROM rodzic WHERE uzytkownik_login='$login' ";
		$result2 = @$conn->query($sql2);
		
		$dane_uzytkowanika=@mysqli_fetch_assoc($result);
		$dane_rodzica=@mysqli_fetch_assoc($result2);
				

		

		
		
			$conn->close();
			}
	
	
	?>
		<div id="tresc">
			<div id="lewy">
			
			<B> Dane: </B><br/>
			<div id="dane">
				imie:  <?php echo $dane_uzytkowanika['imie'] ; ?>  <br/>
				nazwisko: <?php echo $dane_uzytkowanika['nazwisko'] ; ?>   <br/>
				login: <?php echo $dane_uzytkowanika['uzytkownik_login'] ; ?><br/>
				email: <?php echo $dane_uzytkowanika['email'] ; ?><br/>
			</div>
			
			</div>
			
			
			
			
			
<form action="zmiana_hasla.php" method="post">
			<div id="prawy">
				<B> Zmiana hasła: </B><br/>
				<div id="zmianahasla">
					stare hasło:<br/>
					<input type="password" name="stare"> <br/>
					nowe hasło:<br/>
					<input type="password" name="nowe"><br/>
					powtórz nowe hasło:<br/>
					<input type="password" name="p_nowe"><br/>
					<button type="submit">Zatwierdź</button>
					
					
					</form>
				</div>
				
			</div>
				

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