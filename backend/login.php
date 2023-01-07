<?php
  require_once('cors.php');
  require_once('session_config.php');

  require_once('parseRequestJson.php');

  $user = isset($requestData['user']) ? trim($requestData['user']) : null;
  $pass = isset($requestData['pass']) ? trim($requestData['pass']) : null;

  if ($user && $pass) {
    require_once('mysql.php');
    $connection = connect();
    $user = login($connection, $user, $pass);

    if ($user !== false) {
      session_start();
      $session_id = session_id();
      $_SESSION['user'] = $user['username'];
      $_SESSION['id_user'] = $user['id'];

      header('Content-Type: application/json');

      echo json_encode([
        'session_id' => $session_id,
        'username' => $user['username'],
        'id_user' => $user['id']
      ]);
    } else {
      header('Content-Type: application/json');
      http_response_code(401);

      $msg = 'Credentiale invalide. Pls try again.';

      echo json_encode([
        'msg' => $msg
      ]);
    }
  } else {
    require_once('handlePreflightAnd401.php');
  }
?>