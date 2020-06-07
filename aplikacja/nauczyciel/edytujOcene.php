<?php

$conn=new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
$ocena_id = $_GET['ocena_id'];
$stopien = $_GET['stopien'];
$waga = $_GET['waga'];
if($_GET['opis'] == '')
{$opis = "Brak opisu";}
else
{$opis = $_GET['opis'];}
$conn->query("UPDATE ocena SET stopien='$stopien',waga='$waga',opis='$opis' WHERE ocena_ID='$ocena_id' ");
$conn->close();

?>