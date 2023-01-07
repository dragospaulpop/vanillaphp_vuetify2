<?php
  require_once('cors.php');
  require_once('session_config.php');
  require_once('./secure.php');
  require_once('./mysql.php');

  if ($loggedIn) {
    $connection = connect();

    $todos = readTodos($connection);

    header('Content-Type: application/json');

    echo json_encode($todos);
  } else {
    require_once('handlePreflightAnd401.php');
  }
?>