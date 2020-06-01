<?php

    session_start();
	
	if(!isset($_SESSION['uzytkownik_login']) || !isset($_SESSION['haslo']))
	{
		session_unset(); 
		session_destroy();
		session_start();
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
	<link rel="stylesheet" type="text/css" href="../Styles/tooltip.css">
	<link rel="Shortcut icon" href="favicon.ico" />
	
	<meta name="description" content="opis w google"/>
	<meta name="keywords" content="słowa po których google szuka"/>

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
		
		
		<a href="r_frekwencja.php">
		<div id="teraz">
		 Frekwencja
		</div> </a>	
		
		
		<a href="r_terminarz.php">
		<div id="inne">
		 Terminarz 
		</div>
		</a>	
		
		
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
	
		$sql2="SELECT * FROM rodzic WHERE uzytkownik_login='$login' ";
		$result2 = @$conn->query($sql2);
		
		$dane_uzytkowanika=@mysqli_fetch_assoc($result);
		$dane_rodzica=@mysqli_fetch_assoc($result2);
		
		if(isset($_SESSION['wybrane_dziecko_id']) and $_SESSION['wybrane_dziecko_id'] != 0)
			{
				
				$uczen_id = $_SESSION['wybrane_dziecko_id'];
				$result3 = $conn->query("CALL frekwencja_ucznia($uczen_id)");
			}
		$conn->close();
	}
	
	?>
		
		
		<div id="tresc">
		<div id="lewy">
			<B> Frekwencja: </B><br/>
			

		<?php
		
		if(isset($_SESSION['wybrane_dziecko_id']) and $_SESSION['wybrane_dziecko_id'] != 0  )
			{
			echo "<table border=5>";
			
				
				if($result3->num_rows > 0) {
				
					$data=0;
					while($row3 = $result3->fetch_assoc())
					{		
						
						
						if ($row3['status']=='obecny')
							{
							}

						else
						{	
							if($row3['status']=='spóźniony')
							{$status='S';}
							if($row3['status']=='nieobecny')
							{$status='N';}
							$start = $row3['godz_start'];
							$koniec = $row3['godz_koniec'];
							
							
							if($row3['data']==$data)
							{
								
								echo '</td><td>
								<button> 
								<div class="tooltip">
								'.$status.'
								<span class="tooltiptext">
								'.$row3['przedmiot'].
								'<br>'
								.$start.
								'-'
								.$koniec.
								'
								</span>
								</div></button></td>';
								
								
								
							}
							else{
								
								echo "<tr><td>";

								echo $row3['data'];
								$data=$row3['data'];
								
								
								echo '</td><td>
								<button> 
								<div class="tooltip">
								'.$status.'
								<span class="tooltiptext">
								'.$row3['przedmiot'].
								'<br>'
								.$start.
								'-'
								.$koniec.
								'
								</span>
								</div></button></td>';
								
							}
							
						}
						
					
					}
				}	
			
			echo "</tr></table>"; 	
			}
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

