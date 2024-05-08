<?php

$myPwd1 = '123456789'; // $2y$10$VEZnQcZc5Y/eVvtRhhJXDu.8ZgQzMVB/EhfmDI0Ylq8AI.gXd.nNG
$myPwd2 = '1w4r6y8i';  // $2y$10$2fyKRn6kGnAqiVt17ITZbORbeqCyPZVwT6rXetFmfvEH3okjSSnbK
$myPwd3 = 'qwert13';   // $2y$10$/6QdtAJEPc0IQJvxldLhGutRcs2blUVeRa68sYHg2lcgwiQZkqGFi
$myPwd4 = 'mypassword'; // $2y$10$7Iz9JPwgQiYd/DjvG/Xa8OVfgC8aLg8nZ4mSu4hhjQxB50pIbjkfK

$hash = password_hash($myPwd4, PASSWORD_DEFAULT);
var_dump($hash);

$verifyPwd = password_verify($myPwd4, $hash);
var_dump($verifyPwd);

?>