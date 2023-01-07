<?php
  if (isset($_GET['session_id'])) {
    $session_id = $_GET['session_id'];
  } else {
    require_once('parseRequestJson.php');
    $session_id = $requestData['session_id'];
  }

  if ($session_id) {
    // Set the session ID
    session_id($session_id);
    // Start the session
    session_start();

    if (isset($_SESSION['user'])) {
      $loggedIn = true;
    }
  } else {
    $loggedIn = false;
  }
?>