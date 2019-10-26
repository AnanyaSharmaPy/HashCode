<?php
	session_start();
	require_once('dbconfig/config.php');
?>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<title>Lets Build</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<div id="main-wrapper">
	<center><h2>Sign Up Form</h2></center>
		<form action="register.php" method="post">
			<div class="imgcontainer">
				<img src="imgs/avatar.png" alt="Avatar" class="avatar">
			</div>
			<div class="inner_container">
				<label><b>Name</b></label>
				<input type="text" placeholder="Enter name" name="username" required>
				<label><b>Phone Number</b></label>
				<input type="number" placeholder="Enter Phone number" name="phone" required>
				<label><b>Location</b></label>
				<input type="text" placeholder="Enter Address" name="address" required>
				<button name="register" class="sign_up_btn" type="submit">Sign Up</button>
				<center><a href="form.php">
                <button type="button" class="back_btn">Login</button></a></center>
			</div>
		</form>
		
		<?php
			if(isset($_POST['register']))
			{
				@$username=$_POST['username'];
				@$address=$_POST['address'];
				
                $query = "insert into store values('$eth_address',0)";
                $query_run = mysqli_query($con,$query);
                if($query_run)
                {
                    echo '<script type="text/javascript">alert("Registered.. Welcome")</script>';
                    $_SESSION['username'] = $username;
                    $_SESSION['eth_addr'] = $eth_address;
                    header( "Location: form.php");
                }
                else
                {
                    echo '<p class="bg-danger msg-block">Registration Unsuccessful due to server error. Please try later</p>';
                }
			}
			else
			{
			}
		?>
	</div>
</body>
</html>