<?php
session_start();
if (!array_key_exists('IS_AUTH', $_SESSION)) {
    header('Location: authorization.php');
    die();
}
?>

<head>
    <link href="css/style.css" rel="stylesheet">
</head>

<body>
    <div class="main">
        <div class="header">
            <div class="header-item">
                <h2>Роли</h2>
            </div>
            <div class="right-element">
                <div class="header-item">
                    <a>Пользователь: </a>
                    <a class="bold">
                        <?php
                        echo $_SESSION['login'];
                        ?>
                    </a>
                </div>
                <div class="header-item" style="place-self: right;">
                    <form action='logout.php'>
                        <input type='submit' value='Выход'>
                    </form>
                </div>
            </div>
        </div>
    <div id="admin">

            <?php
            // Получаем список ролей пользователя из $_SESSION
            $userRoles = $_SESSION['roles_name'];
            // Выводим информацию о ролях пользователя
            echo 'Роли вашего пользователя:<br>';
            foreach ($userRoles as $role) {
                if ($role === 'Администратор') {
                    echo '<strong>' . ' - ' . $role . '</strong><br>';
                } else {
                    echo ' - ' . $role . '<br>';
                }
            }
            if (in_array('ADM', $_SESSION['roles']) or in_array('STAT', $_SESSION['roles'])) {
                $dsn = "pgsql:host=localhost;port=5432;dbname=postgres;";
                $pdo = new PDO($dsn, 'postgres', '1');
                //$stmt = $pdo->query('
                $stmt = $pdo->prepare('
                    select u.login "Логин",
                    u.name "Имя пользователя",
                    string_agg(r.name, \', \') "Роли"
                    from users u
                    left join user_roles ur on ur.user = u.id
                    left join roles r on r.id = ur.role
                    group by u.login, u.name
                    order by u.login');
                // $stmt    
                $stmt->execute();
                echo '<table id="admin-table">';
                echo "<tr><th>Логин</th><th>Имя</th><th>Роль</th></tr>";
                while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                    echo "<tr><td>" . $row['Логин'] . "</td><td>" . $row['Имя пользователя'] . "</td><td>" . $row['Роли'] . "</td></tr>";
                }
                echo "</table>";
                //$stmt = $pdo->query('
                $stmt = $pdo->prepare('
                    select e.name as Поле, count(e.id) as "Кол-во"
                    from extra e
                    join main m on m.extra_id = e.id
                    group by e.name
                    order by "Кол-во" DESC');
                // $stmt    
                $stmt->execute();    
                echo '<table id="admin-table">';
                echo "<tr><th>Поле</th><th>Количество</th></tr>";
                while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                    echo "<tr><td>" . $row['Поле'] . "</td><td>" . $row['Кол-во'] . "</td></tr>";
                }
                echo "</table>";
            } else {
                echo '<p id=not-allowed> У вас не достаточно привилегий для просмотра данной страницы</p>';
                die();
            }
            ?>
        </div>
