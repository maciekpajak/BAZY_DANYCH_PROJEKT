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
	
	<title>Konto ucznia</title>
	<META http-equiv="content-type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="../Styles/styleApp.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/form.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/table.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/myInput.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/button.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/modal.css" type="text/css" />
	<link rel="stylesheet" href="../Styles/tooltip.css" type="text/css" />
	
	<link rel="Shortcut icon" href="favicon.ico" />
	
	<meta name="description" content="opis w google"/>
	<meta name="keywords" content="słowa po których google szuka"/>

	<meta http-equiv="X-UA_Compatible" content="IE=edge,chrome=1" />
	<meta name="author" content="Kowalski, Mielniczek, Pająk" />

</head>


<body>
	
	<div id="container">
	
		<div id="logo">
		
			<h1>Zalogowano jako uczeń</h1>
		
		</div>
		
		<a href="u_konto.php">
		<div id="inne">
		Zarządzanie kontem
		</div>
		</a>
		
		
		<a href="u_oceny.php">
		<div id="teraz">
		 Oceny 
		</div></a>
		
		
		<a href="u_frekwencja.php">
		<div id="inne">
		 Frekwencja
		</div> </a>	
		
		
		<a href="u_terminarz.php">
		<div id="inne">
		 Terminarz 
		</div>
		</a>	
		
		<form action="../wyloguj.php" >
		<button class="button button2" style=" width:100px; height:30px; float: right;" id="btn" type="submit" >WYLOGUJ</button>
		</form>
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
	
		$sql2="SELECT * FROM uczen WHERE uzytkownik_login='$login' ";
		$result2 = @$conn->query($sql2);
		
		$dane_uzytkowanika=@mysqli_fetch_assoc($result);
		$dane_ucznia=@mysqli_fetch_assoc($result2);
		
		$sql3="select * from ocena_full_info as o where o.uczen_id = '$dane_ucznia[uczen_ID]' ORDER BY o.`przedmiot`, o.`data` ASC";
		$result3 = @$conn->query($sql3);
		
		$conn->close();
	}
	
	?>
		
		
		<div id="tresc">
		<div id="lewy">

		<?php
		    
		    echo "<table >";
			echo "<tr class='header'><th  style='width:20%;'>Przedmiot</th>";
			echo "<th colspan=30 id='ocena' style='width:80%;'>Oceny</th></tr>";
		    
		    if($result3->num_rows > 0) {
		        
		        $firstrow = $result3->fetch_assoc();
				echo "<tr><td>";
		        echo $firstrow['przedmiot'];
				if($firstrow['stopien'] == 6) {$color = "rgb(255, 0, 102)";}
				if($firstrow['stopien'] == 5) {$color = "rgb(153, 0, 0)";}
				if($firstrow['stopien'] == 4) {$color = "rgb(204, 102, 0)";}
				if($firstrow['stopien'] == 3) {$color = "rgb(0, 255, 0)";}
				if($firstrow['stopien'] == 2) {$color = "rgb(255, 255, 0)";}
				if($firstrow['stopien'] == 1) {$color = "rgb(0, 255, 255)";}
				if($firstrow['stopien'] == 0) {$color = "rgb(0, 0, 255)";}
		        echo "</td><td>
				<button class='button button3' style='background-color:$color;'>
					<div class='tooltip'>
							".$firstrow['stopien']."
								<span class='tooltiptext'>
									Ocena: ".$firstrow['stopien']." <br>
									Waga: ".$firstrow['waga']." <br>
									Nauczyciel: ".$firstrow['imie']." ".$firstrow['nazwisko']." <br>
									Przedmiot: ".$firstrow['przedmiot']." <br>
									Opis: ".$firstrow['opis']."
								</span>
					</div></button></td>";
		        $i=0;
		        while($row3 = $result3->fetch_assoc()) {
					
					if($row3['przedmiot'] != $firstrow['przedmiot']) {
		                
						while( $i < 30 )
							{
								echo "<td headers='ocena' style='width:20px;font-size:15px;'></td>";
								$i = $i + 1;
							}
							$i=0;
		                echo "</tr><tr><td>";
		                echo $row3['przedmiot'];
		                //echo "</td><td>";
		                $firstrow = $row3;
					}
					if($row3['stopien'] == 6) {$color = "rgb(255, 0, 102)";}
					if($row3['stopien'] == 5) {$color = "rgb(153, 0, 0)";}
					if($row3['stopien'] == 4) {$color = "rgb(204, 102, 0)";}
					if($row3['stopien'] == 3) {$color = "rgb(0, 255, 0)";}
					if($row3['stopien'] == 2) {$color = "rgb(255, 255, 0)";}
					if($row3['stopien'] == 1) {$color = "rgb(0, 255, 255)";}
					if($row3['stopien'] == 0) {$color = "rgb(0, 0, 255)";}
		            echo "</td><td>
					<button class='button button3' style='background-color:$color;'>
					<div class='tooltip'>
							".$row3['stopien']."
								<span class='tooltiptext'>
									Ocena: ".$row3['stopien']." <br>
									Waga: ".$row3['waga']." <br>
									Nauczyciel: ".$row3['imie']." ".$row3['nazwisko']." <br>
									Przedmiot: ".$row3['przedmiot']." <br>
									Opis: ".$row3['opis']."
								</span>
					</div></buttn></td>";
					$i = $i +1;
		        }
				while( $i < 30 )
				{
					echo "<td headers='ocena' style='width:20px;font-size:15px;'></td>";
					$i = $i + 1;
				}
		    }
		   
		   echo "</tr></table>"; 
		?>
		
		</div>
		</div>
		
		
		<div id="footer">
		e-dziennik
		</div>
	
	
	
	</div>
	
</body>

</html>