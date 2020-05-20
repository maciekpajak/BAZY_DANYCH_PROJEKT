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

	
	
	</style>


</head>


<body>
	

	<?php 
		$conn=mysqli_connect("localhost", "root", "", "dziennik szkolny"); 
		                                   /*("adres IP", "username","password", "DB_name")*/
		
		
		
		$new_haslo="'haslo'"; /* są tu podwójne apostrofy tzn. 1. " 2. ' 3. dopiero zmienna 4. domkniecia apostrofow  */             
		$uzytkowanik_login="'U0003'"; /* jak wyżej */
		$sql="CALL zmiana_hasla_admin (" . $new_haslo . "," . $uzytkowanik_login . ")";
		$result = $conn->query($sql);

		
		
		
		
		$conn->close();
	?>

	
	
	
	

	
</body>





</html>