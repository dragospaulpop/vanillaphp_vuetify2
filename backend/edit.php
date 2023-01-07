<?php
  require_once('./cors.php');
  require_once('./secure.php');

  if ($loggedIn) {
    require_once('parseRequestJson.php');

    $title = isset($requestData['title']) ? trim($requestData['title']) : null;
    $description = isset($requestData['description']) ? trim($requestData['description']) : null;
    $id = isset($requestData['id']) ? $requestData['id'] : null;
    $id_user = $_SESSION['id_user'];
    if ($id && $id_user && $title && strlen($title) > 0 && $description && strlen($description) > 0) {
      require_once('./mysql.php');

      $connection = connect();
      editTodo($connection, $id, $id_user, $title, $description);

      header('Content-Type: application/json');

      echo json_encode([
        'status' => 'a-ok, edited'
      ]);
    } else {
      require_once('handlePreflightAnd401.php');
    }
  } else {
    require_once('handlePreflightAnd401.php');
  }
?>