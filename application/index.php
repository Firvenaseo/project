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
                <h2>Товары</h2>
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
    <div id="content">
        <div id="left-container">
            <button onclick="showAddItem()">Добавить</button>
            <div id="new-container">
                <p id="title-add-edit">Изменение записи</p>
                <ul>
                    <li class="input-data"><span>Название телефона: </span><input id="name_phone"><br /></li>
                    <li class="input-data"><span>Цена: </span><input id="price"><br /></li>
                    <li class="input-data"><span>Цвет: </span><input id="color"><br /></li>
                    <li class="input-data"><span>Производитель: </span><input id="manufacturer"><br /></li>
                    <li class="input-data"><span>Страна: </span>
                        <select id="select-extra">
                            <option></option>
                        </select>
                    </li>
                </ul>
                <button onclick="hideItem()">Отмена</button>
                <button style="display: none;" , id="add-button" , onclick="addRow()">Добавить</button>
                <button style="display: none;" , id="edit-button" , onclick="editRow()">Изменить</button>
            </div>
        </div>


        <div id="right-container">
            <table id="main-container-table" cellspacing="0">
                <thead id="main-container-head">
                    <tr>
                        <th>Название телефона</th>
                        <th>Цена</th>
                        <th>Цвет</th>
                        <th>Производитель</th>
                        <th>Страна</th>
                        <th />
                    </tr>
                </thead>
                <tbody id="main-container">
                </tbody>
            </table>
        </div>
    </div>

    <script src="js/script.js"></script>
</body>