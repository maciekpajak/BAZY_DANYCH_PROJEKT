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
				session_destroy();
				session_start();
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
		<div id="inne">
		 Oceny 
		</div></a>
		
		
		<a href="u_frekwencja.php">
		<div id="teraz">
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
		
		$result3 = $conn->query("CALL frekwencja_ucznia('$dane_ucznia[uczen_ID]')");
		
		$conn->close();
	}
	
	?>
		
		
		<div id="tresc">
		<div id="lewy">
			

<?php
				echo "<table>";
				echo "<tr class='header'><th  style='width:20%;'>Data</th>";
				echo "<th colspan=30 id='frekwencja' style='width:80%;'>Frekwencja</th></tr>";
				if($result3->num_rows > 0) {
					
					
					$data=0;
					
					echo "<tr>";
					$i=0;
					while($row3 = $result3->fetch_assoc())
					{		
						
						if ($row3['status']=='obecny'){$status='O';$color = "rgb(153, 255, 153)";}	
						if($row3['status']=='spóźniony'){$status='S'; $color = "rgb(204, 255, 255)";}
						if($row3['status']=='nieobecny'){$status='N';$color="rgb(255,102,102)";}
						if($row3['czy_do_uspr']=='Y'){$status .= '?';$color = "rgb(255, 255, 128)";}
						if($row3['czy_uspr']=='Y'){$status .= '*'; $color = "rgb(163, 102, 255)"; }
						$start= $row3['godz_start'];
						$koniec = $row3['godz_koniec'];
							
							
						if($row3['data']!=$data)
						{while( $i < 30 )
							{
								echo "<td headers='frekwencja' style='width:20px;font-size:15px;'></td>";
								$i = $i + 1;
							}
							$i=0;
							echo "</tr><tr><td>";
								echo $row3['data'];
							$data= $row3['data'];
						}
						
						echo "</td><td>
						<button class='button button3' style='background-color:$color;'>
						<div class='tooltip'>
						".$status."
						<span class='tooltiptext'>
						".$row3['przedmiot']."<br>"
						.$start."-".$koniec."
						</span>
						</div></td>";
							
						
					}
						while( $i < 30 )
						{
							echo "<td headers='frekwencja' style='width:20px;font-size:15px;'></td>";
							$i = $i + 1;
						}
						$i=0;
					
					
				}	
			echo "</table>"; 	
			?>
			
			
		
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

