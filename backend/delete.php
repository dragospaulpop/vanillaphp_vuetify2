<?php
  require_once('./cors.php');
  require_once('./secure.php');

  if ($loggedIn) {
    require_once('parseRequestJson.php');

    $id = isset($requestData['id']) ? $requestData['id'] : null;

    if ($id) {
      require_once('./mysql.php');
      $connection = connect();
      deleteTodo($connection, $id, $_SESSION['id_user']);
    }

    header('Content-Type: application/json');

    echo json_encode([
      'status' => 'a-ok, deleted'
    ]);
  }else {
    require_once('handlePreflightAnd401.php');
  }
?>