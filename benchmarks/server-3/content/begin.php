<?php
session_start();
$_SESSION['username'] = $_REQUEST['username'];
$_SESSION['name'] = 'Test Dude';
header('Location: welcome1.html');
?>
