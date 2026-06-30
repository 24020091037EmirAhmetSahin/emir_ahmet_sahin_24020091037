<?php
$config = require __DIR__ . '/config.php';

function emira_kisalt($metin, $uzunluk = 90) {
    $metin = $metin ?? '';
    return strlen($metin) <= $uzunluk ? $metin : substr($metin, 0, $uzunluk) . '...';
}

try {
    if (!extension_loaded('pdo_mysql')) {
        throw new RuntimeException('pdo_mysql eklentisi aktif değil.');
    }
    $dsn = sprintf('mysql:host=%s;dbname=%s;charset=%s', $config['host'], $config['dbname'], $config['charset']);
    $pdo = new PDO($dsn, $config['username'], $config['password']);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
} catch (Throwable $e) {
    die(
        'MySQL bağlantı hatası: ' . htmlspecialchars($e->getMessage()) .
        '<br><br><a href="kurulum.php">Kurulum sayfasına git</a>'
    );
}
