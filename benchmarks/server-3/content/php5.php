<?php
session_start();
echo $_SESSION['name'] . ' (' . $_SESSION['username'] . ')';
?>
