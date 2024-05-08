<head>
    <meta charset="utf-8" />
    <link href="css/style.css" rel="stylesheet">
</head>

<?php
session_start();
if (array_key_exists('IS_AUTH', $_SESSION)) {
    header('Location: index.php');
    die();
}
$dsn = "pgsql:host=localhost;port=5432;dbname=postgres;";
$pdo = new PDO($dsn, 'postgres', '1');

//$sql = 'select name, id from users 
 //where login = :login and pass = :password';
$sql = 'select name, id, pass from users where login = :login';

$hashed_password = password_hash($_POST['password'], PASSWORD_DEFAULT);


$stmt = $pdo->prepare($sql);
$stmt->bindParam(':login', $_POST['login']);
//$stmt->bindParam(':password', $_POST['password']);

$stmt->execute();
$row = $stmt->fetch(PDO::FETCH_ASSOC);
if ($row && password_verify($_POST['password'], $row['pass'])) {
    include('find_roles.php');
    $_SESSION['roles'] = get_roles($row['id']);
    $_SESSION['roles_name'] = get_roles_name($row['id']);
    $_SESSION['IS_AUTH'] = true;
    $_SESSION['name'] = $row['name'];
    $_SESSION['user_id'] = $row['id'];
    $_SESSION['login'] = $_POST['login'];
    header('Location: index.php');
    die();
} else {
    echo '<body id="login-page">
            <div id="login-form">
                <form action="authorization.php">
                    <span>Авторизация</span>
                    <p>Неверные логин или пароль!</p>
                    <input type="submit" value="Вернуться">
                    </form>
                    </div>
                </body>';
}