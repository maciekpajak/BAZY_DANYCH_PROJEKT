<?php 
	
    if(isset($_GET['id']) and isset($_GET['tresc'])) {
		$id = $_GET['id'];
		$tresc = $_GET['tresc'];
		
		require_once "../connect.php";
		
		$conn=@new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
		
		if ($conn->connect_errno!=0)
		{
			echo "Error: ".$conn->connect_errno;
		}
		else
		{
			echo $id ;
			$conn->query("UPDATE obecnosc AS o SET o.czy_do_uspr = 'Y', o.tresc_uspr = '$tresc' WHERE o.obecnosc_ID = '$id'");
				
			
			$conn->close();
		}
	}
	?>