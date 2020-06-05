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

<style>
body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box;}

/* Button used to open the contact form - fixed at the bottom of the page */
.open-button {
  background-color: #555;
  color: white;
  padding: 16px 20px;
  border: none;
  cursor: pointer;
  opacity: 0.8;
  position: fixed;
  bottom: 23px;
  right: 28px;
  width: 280px;
}

/* The popup form - hidden by default */
.form-popup {
  display: none;
  position: fixed;
  bottom: 100px;
  right: 500px;
  border: 3px solid #f1f1f1;
  z-index: 9;
}

/* Add styles to the form container */
.form-container {
  max-width: 300px;
  width: 300px;
  hight: 300px;
  padding: 10px;
  background-color: white;
}

/* Full-width input fields */
.form-container input[type=text], .form-container input[type=password] {
  width: 100%;
  hight: 100px:
  padding: 15px;
  margin: 5px 0 22px 0;
  border: none;
  background: #f1f1f1;
}

/* When the inputs get focus, do something */
.form-container input[type=text]:focus, .form-container input[type=password]:focus {
  background-color: #ddd;
  outline: none;
}

/* Set a style for the submit/login button */
.form-container .btn {
  background-color: #4CAF50;
  color: white;
  padding: 16px 20px;
  border: none;
  cursor: pointer;
  width: 100%;
  margin-bottom:10px;
  opacity: 0.8;
}

/* Add a red background color to the cancel button */
.form-container .cancel {
  background-color: red;
}

/* Add some hover effects to buttons */
.form-container .btn:hover, .open-button:hover {
  opacity: 1;
  
textarea {
  width: 100%;
  height: 200px;
  padding: 12px 20px;
  box-sizing: border-box;
  border: 2px solid #ccc;
  border-radius: 4px;
  background-color: #f8f8f8;
  resize: none;
}
}
</style>

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
						if ($row3['status']!='obecny')
						{	
							if($row3['czy_uspr']=='Y')
							{
								$status='U';
							$color = "green";
							}
							else
							{
								if($row3['status']=='spóźniony')
								{
									$status='S';
								$color = "yellow";
								}
								if($row3['status']=='nieobecny')
								{
									$status='N';
								$color = "red";
								}
							}
							$start = $row3['godz_start'];
							$koniec = $row3['godz_koniec'];
							$godzina = $start . "-" . $koniec;
							$nauczyciel = $row3['imie'] . " " . $row3['nazwisko'] ;
							$przedmiot = $row3['przedmiot'];
							
							$id = $row3['obecnosc_ID'];
							
							if($row3['data']!=$data)
							{
								echo "<tr><td>";
								echo $row3['data'];
								$data=$row3['data'];
							}	
							echo "</td><td>
							<button style=\"background-color:$color\" 
							onClick='openForm(\"".$id."\" , \"" . $row3['status'] ."\", \"" . $godzina ."\", \"" . $przedmiot ."\", \"" . $nauczyciel ."\")' > 
							<div class=\"tooltip\">
							$status
								<span class=\"tooltiptext\">
								$przedmiot<br>$godzina
								</span>
							</div></button></td>";
							
						}
					}
				}	
			
			echo "</tr></table>"; 	
			}
			?>
			
			<script language="javascript" type="text/javascript">
			  function openForm(id , status, godzina, przedmiot, nauczyciel) {
				  
				  $id_obecnosci_do_uspr = id;
				  document.getElementById("form_status").innerHTML = status;
				  document.getElementById("form_przedmiot").innerHTML = przedmiot;
				  document.getElementById("form_nauczyciel").innerHTML = nauczyciel;
				  document.getElementById("form_godzina").innerHTML = godzina;
				  document.getElementById("myForm").style.display = "block";
				  
				}

				function closeForm() {
				  document.getElementById("myForm").style.display = "none";
				}
				
				function usprawiedliw() {
					
				 $.ajax({
					url: "usprawiedliw.php",
					data: {
						id: $id_obecnosci_do_uspr,
						tresc: $('#textarea').val()
						}, 
				});
				document.getElementById("demo").innerHTML = $id_obecnosci_do_uspr ;
				document.getElementById("myForm").style.display = "none";
				}
			</script>
		
		</div>
		</div>
		
		<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
		
		<div class="form-popup" id="myForm">
		  <form onSubmit="usprawiedliw()" class="form-container" method="POST" >
			<h1>Usprawiedliwienie</h1>

			<p id="form_status"></p>
			<p id="form_przedmiot"></p>
			<p id="form_nauczyciel"></p>
			<p id="form_godzina"></p>
			<textarea id="textarea" style="width:300px;height:150px;resize: none;" maxlength=250 placeholder="Treść usprawiedliwienia" required ></textarea>
			<button id="btn" type="submit" name="uspr"  >Login</button>
			<button type="button" onclick="closeForm()">Close</button>
		  </form>
		</div>
		
		<p id="demo">Dem</p>
		<form action="../wyloguj.php" >

		<button type="submit">wyloguj</button>
		</form>
		
		
		<div id="footer">
		e-dziennik
		</div>
	
	
	
	</div>
	
</body>

</html>

