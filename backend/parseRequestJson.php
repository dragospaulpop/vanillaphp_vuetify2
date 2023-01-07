<?php
  // Read the request body
  $request_body = file_get_contents('php://input');

  // Parse the JSON into a PHP value
  $requestData = json_decode($request_body, true);
?>