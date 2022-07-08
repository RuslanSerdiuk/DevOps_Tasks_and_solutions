<?php

$user = getenv('DB_USER');
$pass = getenv('DB_PW');
$name = getenv('DB_NAME');

$conn = mysqli_connect(  
  "db:3306",
  "$user",
  "$pass",
  "$name"
) or die(mysqli_error($mysqli)); 

?>