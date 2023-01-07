<?php
  require_once('./cors.php');
  require_once('./secure.php');

  if ($loggedIn) {
    require_once('parseRequestJson.php');

    $title = isset($requestData['title']) ? trim($requestData['title']) : null;
    $description = isset($requestData['description']) ? trim($requestData['description']) : null;

    if ($title && strlen($title) > 0 && $description && strlen($title) > 0) {
      require_once('./mysql.php');

      $connection = connect();
      addTodo($connection, $title, $description);
    }

    header('Content-Type: application/json');

    echo json_encode([
      'status' => 'a-ok, added'
    ]);
  } else {
    require_once('handlePreflightAnd401.php');
  }
?>