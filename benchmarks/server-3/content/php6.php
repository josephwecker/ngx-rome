<?php

$fields = array('first', 'second', 'third', 'forth', 'fifth');
$i = 0;
foreach($fields as $fld) {
	$i ++;
?>
    <div class="strange"><?php echo ($i * 7) . '---&gt;' . $fld; ?></div>
<?php } ?>

