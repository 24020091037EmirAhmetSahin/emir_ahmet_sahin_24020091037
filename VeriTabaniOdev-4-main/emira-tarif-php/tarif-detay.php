<?php
require 'veritabani.php';

if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    header('Location: index.php');
    exit;
}

$id = (int) $_GET['id'];
$stmt = $pdo->prepare('SELECT * FROM Tarifler WHERE id = ?');
$stmt->execute([$id]);
$tarif = $stmt->fetch();

if (!$tarif) {
    header('Location: index.php');
    exit;
}
?>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= htmlspecialchars($tarif['baslik']) ?> | Emira Mutfak</title>
    <link rel="stylesheet" href="assets/emira-stil.css">
</head>
<body>
<div class="container">
    <div class="nav-top">
        <a href="index.php" class="btn btn-ghost">&larr; Ana Sayfaya Dön</a>
    </div>

    <div class="hero">
        <?php if ($tarif['fotograf_url']): ?>
            <img src="<?= htmlspecialchars($tarif['fotograf_url']) ?>" alt="<?= htmlspecialchars($tarif['baslik']) ?>">
        <?php else: ?>
            <img src="https://images.unsplash.com/photo-1495521821757-a1efb6729352?w=1200&q=80" alt="Varsayılan yemek">
        <?php endif; ?>
        <div class="hero-overlay"></div>
        <div class="hero-content">
            <h1><?= htmlspecialchars($tarif['baslik']) ?></h1>
            <p class="hero-meta">Eklenme: <?= date('d.m.Y H:i', strtotime($tarif['olusturulma_tarihi'])) ?></p>
        </div>
    </div>

    <div class="detail-panel">
        <h2>Nasıl Yapılır?</h2>
        <hr class="detail-divider">
        <div class="detail-content"><?= htmlspecialchars($tarif['detay']) ?></div>
    </div>

    <footer class="site-footer">
        &copy; <?= date('Y') ?> Emira — Veri Tabanı Ödev 4
    </footer>
</div>
</body>
</html>
