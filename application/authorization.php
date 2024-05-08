<?php
session_start();
if (array_key_exists('IS_AUTH', $_SESSION)) {
    header('Location: index.php');
    die();
}
?>

<head>
    <meta charset="utf-8" />
    <link href="css/style.css" rel="stylesheet">
</head>

<body id="login-page">
    <div id="login-form">
        <form action="login.php" method="POST">
            <span>Авторизация</span>
            <input name="login" placeholder="Логин">
            <input name="password" type="password" placeholder="Пароль">
            <input type="submit" value="Ок">
        </form>
    </div>
</body>