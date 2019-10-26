<?php
$con=mysqli_connect ("localhost", "root", "") or die ('Cannot connect to the database: ' . mysql_error());
mysqli_select_db ($con,'units');
?>