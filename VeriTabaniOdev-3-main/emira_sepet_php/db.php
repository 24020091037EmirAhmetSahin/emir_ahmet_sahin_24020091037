<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

$server = "localhost";
$database = "emira_sepet_db";
$user = "emira";
$pass = "emira123";

if (!extension_loaded('pdo_mysql')) {
    die("HATA: pdo_mysql eklentisi aktif değil. php.ini dosyasını kontrol edin.");
}

try {
    $conn = new PDO("mysql:host=$server;dbname=$database;charset=utf8mb4", $user, $pass);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Bağlantı Hatası: " . $e->getMessage());
}
?>