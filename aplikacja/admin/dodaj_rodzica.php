<?php 
	

		
		
		$login=$_GET['login'];
		$haslo=$_GET['haslo'];
		$imie=$_GET['imie'];
		$nazwisko=$_GET['nazwisko'];
		$nr_tel=$_GET['nr_tel'];
		$email=$_GET['email'];
		if (isset ($_GET['opiekunowie_id']))
		{
		$opiekunowie_id=$_GET['opiekunowie_id'];
		}
		
		else
			
			{
				
		require_once "../connect.php";
		
		$conn=@new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
		

		
		
		if ($conn->connect_errno!=0)
		{
			echo "Error: ".$conn->connect_errno;
		}
		else
		{
								
			$sql2="SELECT opiekunowie_ID FROM opiekunowie WHERE opiekunowie_ID=LAST_INSERT_ID()";
			$result2 = $conn->query($sql2);
			$o_id=$result2->fetch_assoc();
			$opiekunowie_id=$o_id['opiekunowie_id'];
			
			$conn->close();
				
				
			}}
			

		
		require_once "../connect.php";
		
		$conn=@new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
		

		
		
		if ($conn->connect_errno!=0)
		{
			echo "Error: ".$conn->connect_errno;
		}
		else
		{
								
			$conn->query("CALL dodaj_rodzica('$login','$haslo','$imie','$nazwisko','$nr_tel','$email','$opiekunowie_id')");
			
			
			
			$conn->close();
			
		}
	//}
	?>