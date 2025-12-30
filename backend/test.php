<?php
$host = "localhost";
$port = "5432";
$db   = "velvetvanity";
$user = "postgres";
$pass = "Nour585858";

try {
    $pdo = new PDO(
        "pgsql:host=$host;port=$port;dbname=$db",
        $user,
        $pass,
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
    );
    echo "Connexion PostgreSQL OK";
} catch (PDOException $e) {
    echo "Erreur : " . $e->getMessage();
}
