<?php 
	
    if(isset($_GET['id'])) {
		$id = $_GET['id'];
		
		require_once "../connect.php";
		
		$conn=@new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
		
		if ($conn->connect_errno!=0)
		{
			echo "Error: ".$conn->connect_errno;
		}
		else
		{
			
			$conn->query("UPDATE obecnosc AS o SET o.czy_do_uspr = 'N', o.czy_uspr = 'Y' WHERE o.obecnosc_ID = '$id'");
				
			
			$conn->close();
		}
	}
	?>
	
