<?php
$servername = "localhost";
$username = "crimsonw_270737_myshopadmin";
$password = "q;RTZlfA)Xe.";
$dbname = "crimsonw_270737_myshopdb";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) 
    {die("Connection failed: " . $conn->connect_error);
    }


?>