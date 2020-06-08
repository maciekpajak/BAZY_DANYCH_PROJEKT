<?php 
	
		$login=$_GET['login'];
		$haslo=$_GET['haslo'];
		$pesel=$_GET['pesel'];
		$imie=$_GET['imie'];
		$nazwisko=$_GET['nazwisko'];
		$klasa=$_GET['klasa'];
		$opiekunowie_id=$_GET['opiekunowie_id'];
		$email=$_GET['email'];
		$ulica=$_GET['ulica'];
		$miejscowosc=$_GET['miejscowosc'];
		$kod=$_GET['kod'];
		$nr_domu=$_GET['nr_domu'];
		$nr_mieszkania=$_GET['nr_mieszkania'];
		
		
		//-------------------szukanie ID klasy
		require_once "../connect.php";
		
		$conn=@new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
	
		if ($conn->connect_errno!=0)
		{
			echo "Error: ".$conn->connect_errno;
		}
		else
		{
		
		$sql="SELECT * FROM klasa WHERE oddzial='$klasa'";
		$result = @$conn->query($sql);
		$conn->close();
		$klasa_ucznia= $result->fetch_assoc();
		$id_klasa=$klasa_ucznia['klasa_ID'];
		}
		
		
		//-------sprawdzanie ulicy
		require_once "../connect.php";
		
		$conn=@new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
	
		if ($conn->connect_errno!=0)
		{
			echo "Error: ".$conn->connect_errno;
		}
		else
		{
		
		$sql2="SELECT * FROM ulica WHERE nazwa='$ulica'";
		$result2 = @$conn->query($sql2);
		
		if($result2->num_rows > 0){
		$ulica_ucznia= $result2->fetch_assoc();
		$id_ulica=$ulica_ucznia['ulica_ID'];
		}
		
		else
		{
		$conn->query("INSERT INTO ulica (ulica.nazwa) VALUES ('$ulica')");
		$sql3="SELECT * FROM ulica WHERE nazwa='$ulica'";
		$result3 = @$conn->query($sql3);
		$ulica_ucznia= $result3->fetch_assoc();
		$id_ulica=$ulica_ucznia['ulica_ID'];
		}
		
		$conn->close();
		
		}
		
		
			//-------sprawdzanie miejscowowsci
		require_once "../connect.php";
		
		$conn=@new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
	
		if ($conn->connect_errno!=0)
		{
			echo "Error: ".$conn->connect_errno;
		}
		else
		{
		
		$sql4="SELECT * FROM miejscowosc WHERE nazwa='$miejscowosc'";
		$result4 = @$conn->query($sql4);
		
		if($result4->num_rows > 0){
		$miejscowosc_ucznia= $result4->fetch_assoc();
		$id_miejscowosc=$miejscowosc_ucznia['miejscowosc_ID'];
		}
		
		else
		{
		$conn->query("INSERT INTO miejscowosc (miejscowosc.nazwa) VALUES ('$miejscowosc')");
		$sql5="SELECT * FROM miejscowosc WHERE nazwa='$miejscowosc'";
		$result5 = @$conn->query($sql5);
		$miejscowosc_ucznia= $result5->fetch_assoc();
		$id_miejscowosc=$miejscowosc_ucznia['miejscowosc_ID'];
		}
		$conn->close();
		}
		
		/////-----------Szukanie ulica->miejscowosc
		require_once "../connect.php";
		
		$conn=@new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
	
		if ($conn->connect_errno!=0)
		{
			echo "Error: ".$conn->connect_errno;
		}
		else
		{
		
		$sql6="SELECT * FROM ulice_miejscowosci WHERE miejscowosc_id='$id_miejscowosc' AND ulica_id='$id_ulica'";
		$result6= @$conn->query($sql6);
		
		if($result6->num_rows > 0){
		$miejscowosc_ulica= $result6->fetch_assoc();
		$id_ulice_m=$miejscowosc_ulica['ulice_miejscowosci_ID'];
		}
		
		else
		{
		$conn->query("INSERT INTO ulice_miejscowosci (ulice_miejscowosci.miejscowosc_id, ulice_miejscowosci.ulica_id, ulice_miejscowosci.kod) VALUES ('$id_miejscowosc', '$id_ulica', '$kod' )");
		
		$sql7="SELECT * FROM ulice_miejscowosci WHERE miejscowosc_id='$id_miejscowosc' AND ulica_id='$id_ulica'";
		$result7= @$conn->query($sql7);
		$miejscowosc_ulica= $result7->fetch_assoc();
		$id_ulice_m=$miejscowosc_ulica['ulice_miejscowosci_ID'];
		}
		$conn->close();
		}
		
		
		///------ADRES ID 
		
		
		require_once "../connect.php";
		
		$conn=@new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
	
		if ($conn->connect_errno!=0)
		{
			echo "Error: ".$conn->connect_errno;
		}
		else
		{
		
		$sql8="SELECT * FROM adres WHERE ulice_miejscowosci_id='$id_ulice_m' AND nr_domu='$nr_domu' AND nr_mieszkania='$nr_mieszkania'";
		$result8= @$conn->query($sql8);
		
		if($result8->num_rows > 0){
		$adres_ucznia= $result8->fetch_assoc();
		$id_adres=$adres_ucznia['adres_ID'];
		}
		
		else
		{
		$conn->query("INSERT INTO adres (adres.ulice_miejscowosci_id, adres.nr_domu, adres.nr_mieszkania) VALUES ('$id_ulice_m', '$nr_domu', '$nr_mieszkania')");
		
		$sql9="SELECT * FROM adres WHERE ulice_miejscowosci_id='$id_ulice_m' AND nr_domu='$nr_domu' AND nr_mieszkania='$nr_mieszkania'";
		$result9= @$conn->query($sql9);
		$adres_ucznia= $result9->fetch_assoc();
		$id_adres=$adres_ucznia['adres_ID'];
		}
		$conn->close();
		}
		
		
		////--------dodawanie ucznia
		
		require_once "../connect.php";
		
		$conn=@new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
		
		
		if ($conn->connect_errno!=0)
		{
			echo "Error: ".$conn->connect_errno;
		}
		else
		{
		
		$conn->query("CALL dodaj_ucznia('$login','$haslo','$pesel','$id_adres','$id_klasa','$opiekunowie_id','$imie','$nazwisko','$email')");
		$conn->close();
		
		}
		
		
		
		
	?>