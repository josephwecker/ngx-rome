<?php

session_start();

$_SESSION['username'] = $_POST['username'];
$_SESSION['name'] = 'RANDOM TESTER!';

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Welcome "<?php echo $_SESSION['name']; ?>" (<?php echo $_SESSION['username']; ?>) to the test page 2!</title>
    <link rel="stylesheet" type="text/css" href="styles/css1.css"/>
    <link rel="stylesheet" type="text/css" href="styles/css2.css"/>
    <script type="text/javascript" src="js/script4.js"></script>
    <script type="text/javascript" src="js/script5.js"></script>
    <script type="text/javascript" src="js/script6.js"></script>
  </head>
  <body>
    <h1>Welcome <?php echo $_SESSION['name'] . ' (' . $_SESSION['username'] . ')'; ?></h1>
    <img src="images/image6.png"/>
    <p> Lorem ipsum dolor sit amet, consectetur adipiscing elit.
Quisque ante dui, convallis at eleifend id, pretium ut orci. Morbi a justo
nisl, sed accumsan nisl. Donec ac risus orci. Maecenas egestas congue nulla,
ac pharetra neque scelerisque a. Proin at dictum mauris. Fusce rutrum nulla
pulvinar velit molestie porttitor imperdiet orci sollicitudin. Aliquam in
elit sed neque placerat viverra sed a diam. Sed sed tortor est. Vivamus ut
metus enim, eu consequat neque. Pellentesque lacinia eros nec quam interdum
eleifend. Sed aliquam congue feugiat. Quisque volutpat sagittis massa a
vestibulum. Sed vitae ornare enim. Sed lacinia neque ac enim pellentesque ut
tristique enim adipiscing. Ut eu lacus velit, vel tincidunt magna.</p>
    <img src="images/image7.png"/>
<?php

$fields = array('first', 'second', 'third', 'forth', 'fifth');
$i = 0;
foreach($fields as $fld) {
	$i ++;
?>
    <div class="strange"><?php echo ($i * 7) . '---&gt;' . $fld; ?></div>
<?php } ?>

    <p> Suspendisse sit amet libero felis. Maecenas at nibh orci,
id ullamcorper magna. Nullam quam justo, tincidunt scelerisque facilisis sit
amet, ultrices a elit. Integer varius justo sit amet velit imperdiet sed
tristique turpis interdum. Vestibulum faucibus justo id odio dictum feugiat.
Mauris sed leo ipsum, ac semper sem. Donec pretium risus mattis dui
consectetur ultricies. Vestibulum posuere ullamcorper dictum. Nulla eu velit
neque. Nam tincidunt, magna vitae convallis facilisis, erat urna cursus ante,
at bibendum justo ipsum sed massa. Suspendisse molestie nulla gravida libero
pellentesque euismod. Donec ac velit commodo mauris ullamcorper dapibus.
Aenean sit amet sollicitudin eros. </p>
    <img src="images/image8.png"/>
    <h2>Current timestamp</h2>
    <?php echo time(); ?>
    <p> Maecenas odio orci, eleifend sed hendrerit sit amet,
fringilla id justo. Nullam turpis sapien, sagittis nec venenatis at,
malesuada id felis. Nullam augue turpis, aliquam ut congue at, tempus
egestas sapien. Aenean eget consequat nulla. Vivamus ut nulla lectus. Proin
lobortis pulvinar sapien, non congue eros laoreet tempor. Sed laoreet
fermentum fringilla. Nullam semper porta tempor. Donec vel augue nibh, ut
pulvinar velit. Cras blandit purus ut risus sodales vel varius mauris
ultrices. Suspendisse blandit dolor in dui elementum porttitor. Ut bibendum
nulla et tortor dapibus eleifend ac ac lacus. Aenean orci mauris, pulvinar
id gravida ut, suscipit eget lectus. Quisque ut urna eros, a dapibus nisi.
Morbi consectetur neque vitae leo adipiscing sed rutrum libero gravida.
Mauris varius laoreet dui, non aliquet odio ultrices rutrum. Duis a varius
massa. Integer lorem felis, consequat luctus fermentum eget, adipiscing quis
arcu. </p>
    <img src="images/image9.png"/>
    <img src="images/image10.png"/>
  </body>
</html>
