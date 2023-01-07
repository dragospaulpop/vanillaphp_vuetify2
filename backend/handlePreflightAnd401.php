<?php

  if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    echo 'yeah, sure, come in, make yourself at home';
  } else {
    header('Content-Type: application/json');
    http_response_code(401);

    $msg = 'Mmm... Tho shall provide credentials to access this restricted area!';

    echo json_encode([
      'msg' => $msg
    ]);
  }
?>