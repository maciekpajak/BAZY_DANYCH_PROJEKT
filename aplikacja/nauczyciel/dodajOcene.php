<?php

$conn=new mysqli("localhost", "id13767441_dzienn", "bU#@]PEwH^DgS7cp", "id13767441_dziennik"); 
$stopien = $_GET['stopien'];
$waga = $_GET['waga'];
$uczen_id = $_GET['uczen_id'];
$np_id = $_GET['np_id'];
if($_GET['opis'] == '')
{$opis = "Brak opisu";}
else
{$opis = $_GET['opis'];}
$conn->query("CALL dodaj_ocene('$stopien', $waga, '$opis', $uczen_id, $np_id)");
$conn->close();

?>