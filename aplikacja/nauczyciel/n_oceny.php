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
setTimeout( function() { alert("Your session expired."); location.reload(); }, 180*1000);

</script>
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
		
		$sql3="SELECT * FROM nauczyciel_full_info WHERE ID='$dane_nauczyciela[nauczyciel_ID]'";
		$result3 = @$conn->query($sql3);
		$dane_nauczyciela_przedmiotu=@mysqli_fetch_assoc($result3);
		
		$sql4="SELECT * FROM ocena_full WHERE nauczyciel_przedmiotu_id='$dane_nauczyciela_przedmiotu[nauczyciel_przedmiotu_ID]' ";
		$result4 = @$conn->query($sql4);
		
		$oceny=@mysqli_fetch_assoc($result4);
		
		
		$conn->close();	
			}

	?>

	<div id="container">
	
		<div id="logo">
		
			<h1>Zalogowano jako nauczyciel</h1>
		
		</div>
		
		<a href="n_konto.php">
		<div id="inne">
		Zarządzanie kontem
		</div>
		</a>
				
		<a href="n_lekcje.php">
		<div id="inne">
		Lekcje (temat i frekwencja)
		</div> </a>
		
		<a href="n_oceny.php">
		<div id="teraz">
		Oceny 
		</div></a>
		
		<a href="n_oceny_koncowe.php">
		<div id="inne">
		Oceny końcowe 
		</div></a>
		
		<a href="n_terminarz.php">
		<div id="inne">
		Terminarz
		</div></a>
		
		<a href="n_uwagi.php">
		<div id="inne">
		Uwagi 
		</div></a>
		<?php
		if($dane_nauczyciela['czy_wych']=="Y")
		
		echo '<a href="n_klasa_wych.php">
		<div id="inne">
		Klasa wychowawcza
		</div></a>';	
		
		?>


		<div id="tresc">
			<div id="lewy">
			
			<B> Oceny: </B><br/>	

		

		<?php
		    
		    
		    
		    if($oceny) {
		        
		        $firstrow = $result4->fetch_assoc();
		        echo $firstrow['przedmiot'];
		        echo '<div class="tooltip">'.$firstrow['stopien'].'span class="tooltiptext">waga: '.$firstrow['waga'].'<br>nauczyciel: '.$firstrow['imie'].' '.$firstrow['nazwisko'].' <br>
								opis: '.$firstrow['opis'].'
							</span>
					</div></td>';
		        
		        while($row3 = $result4->fetch_assoc()) {
					
					if($row3['przedmiot'] != $firstrow['przedmiot']) {
		                
		                echo "</tr><tr><td>";
		                echo $row3['przedmiot'];
		                //echo "</td><td>";
		                $firstrow = $row3;
					}
		            
		            echo '</td><td>
					<div class="tooltip">
							'.$row3['stopien'].'
							<span class="tooltiptext">
								waga: '.$row3['waga'].' <br>
								nauczyciel: '.$row3['imie'].' '.$row3['nazwisko'].' <br>
								opis: '.$row3['opis'].'
							</span>
					</div></td>';
		        }
		    }
		   
		   
		?>
		
		<div >
		<form method="POST" >
				
			<div class="custom-select" style="width:400px;">
			  <select id="cmbMake" name="Make"  onchange="document.getElementById('selected_text').value=this.options[this.selectedIndex].text">
				 <option value = 0 > ---Wybierz ucznia--- </option>
				 <?php
				 while($dzieci = $result3 ->fetch_assoc() )
					 {
					   echo '<option value="'.$dzieci['uczen_ID'].'">'.$dzieci['imie']. ' ' .$dzieci['nazwisko'].' ' .$dzieci['oddzial'].'</option>';
					 }
				 ?>
			</select>
			</div>
			<button class ="button" type="submit" name="search" > Zatwierdź </button>
		</form>
			 <script type="text/javascript" src="../combobox.js"></script>
			
			
			<?php

			if(isset($_POST['search']))
			//if(isset($_POST['Make']))
			{
				$_SESSION['wybrane_dziecko_id']= $_POST['Make'];
			}
			 ?>
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