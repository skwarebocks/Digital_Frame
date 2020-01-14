<?php
$visitor = $_SERVER['REMOTE_ADDR'];
if (preg_match("/10.0.0.*/",$visitor)) {
      header('Location: wificonfig/index.html');
} else {
      header('Location: frame.php');
};
?>
