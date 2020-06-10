<?php

$conn=new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
$id = $_GET['id_term'];
$conn->query("DELETE FROM terminarz WHERE terminarz_ID = '$id'");
$conn->close();

?>