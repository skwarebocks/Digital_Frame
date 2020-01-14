<?php
shell_exec("/var/www/html/refresh.sh");
header('Location: /index.php?p=photos');
?>
