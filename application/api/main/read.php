<?php
include('../db_connect.php');

$sql = "
select m.*,
       e.name extra_name,
       e.id extra_id
  from main m
       left join extra e on e.id = m.extra_id 
 order by m.name_phone
";

$stmt = $pdo->prepare($sql);
echo get_json($stmt);
?>
