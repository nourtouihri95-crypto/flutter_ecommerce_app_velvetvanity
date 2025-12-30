<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require "config.php";

$fullname = $_POST['fullname'] ?? null;
$email = $_POST['email'] ?? null;
$password = $_POST['password'] ?? null;

if (!$fullname || !$email || !$password) {
    echo json_encode([
        "success" => false,
        "message" => "Missing parameters"
    ]);
    exit;
}

$stmt = $pdo->prepare("SELECT id FROM users WHERE email = :email");
$stmt->execute(['email' => $email]);

if ($stmt->fetch()) {
    echo json_encode([
        "success" => false,
        "message" => "Email already exists"
    ]);
    exit;
}

$stmt = $pdo->prepare(
    "INSERT INTO users (fullname, email, password, role)
     VALUES (:fullname, :email, :password, 'user')"
);

$stmt->execute([
    'fullname' => $fullname,
    'email' => $email,
    'password' => $password
]);

echo json_encode([
    "success" => true,
    "message" => "Account created successfully"
]);
