<?php
include('../db_connect.php');

$entity_body = file_get_contents('php://input');
$post_data = json_decode($entity_body, true);

if(!$post_data) {
    $result_data = [
        "error" => 1,
        "errorMsg" => "Не переданы входные параметры."
    ];
    echo json_encode($result_data, JSON_UNESCAPED_UNICODE);
    die();
}

// Место для валидации 

if (array_key_exists('id', $post_data)) { // Изменить
    $sql = " update main set
                name_phone = :name_phone,
                price = :price,
                color = :color,
                manufacturer = :manufacturer,
                extra_id = :extra_id
              where id = :id;
    ";
    $stmt = $pdo->prepare($sql);
    $stmt->bindParam(':id', $post_data['id']);
} else { // Добавить
    $sql = "insert into main 
        (name_phone,   price, color,  manufacturer, extra_id) VALUES
        (:name_phone, :price, :color, :manufacturer, :extra_id); 
    ";
    $stmt = $pdo->prepare($sql);
}
// Валидация 
if ($post_data['name_phone'] === "") $post_data['name_phone'] = null;
if ($post_data['price'] === "") $post_data['price'] = null;
if ($post_data['color'] === "") $post_data['color'] = null;
if ($post_data['extra_id'] === "") $post_data['extra_id'] = null;

if ($post_data['price'] < 0){ 
    $result_data = [
    "error" => 1,
    "errorMsg" => "Цена не может быть меньше нуля."
    ];
    echo json_encode($result_data, JSON_UNESCAPED_UNICODE);
    die();
}
// Вычисляемое поле
if ($post_data['price'] >= 200000) $post_data['manufacturer'] = "Apple";

$stmt->bindParam(':name_phone', $post_data['name_phone']);
$stmt->bindParam(':price', $post_data['price']);
$stmt->bindParam(':color', $post_data['color']);
$stmt->bindParam(':manufacturer', $post_data['manufacturer']);
$stmt->bindParam(':extra_id', $post_data['extra_id']);
echo get_json($stmt);
?>
