<?php
require 'veritabani.php';
$stmt = $pdo->query('SELECT * FROM Tarifler ORDER BY olusturulma_tarihi DESC');
$tarifler = $stmt->fetchAll();
?>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Emira Mutfak | Tarif Portalı</title>
    <link rel="stylesheet" href="assets/emira-stil.css">
</head>
<body>
<div class="container">
    <header class="site-header">
        <div class="brand">
            <span class="brand-badge">Emira'nın Tarif Defteri</span>
            <h1>Lezzetli Tarifler</h1>
            <p>Veri Tabanı Ödevi — PHP & SQLite</p>
        </div>
        <a href="yonetim.php" class="btn btn-primary">Yönetim Paneli</a>
    </header>

    <div class="grid">
        <?php if (empty($tarifler)): ?>
            <p class="empty-state">Henüz tarif eklenmemiş. Yönetim panelinden ilk tarifinizi ekleyin.</p>
        <?php else: ?>
            <?php foreach ($tarifler as $tarif): ?>
                <article class="card">
                    <div class="card-img-wrap">
                        <?php if ($tarif['fotograf_url']): ?>
                            <img src="<?= htmlspecialchars($tarif['fotograf_url']) ?>" alt="<?= htmlspecialchars($tarif['baslik']) ?>">
                        <?php else: ?>
                            <img src="https://images.unsplash.com/photo-1495521821757-a1efb6729352?w=800&q=80" alt="Varsayılan yemek">
                        <?php endif; ?>
                        <span class="card-tag">Tarif</span>
                    </div>
                    <div class="card-body">
                        <h2><?= htmlspecialchars($tarif['baslik']) ?></h2>
                        <p><?= htmlspecialchars(mb_substr($tarif['detay'], 0, 110)) ?>...</p>
                        <a href="tarif-detay.php?id=<?= $tarif['id'] ?>" class="btn btn-detail">Tarifi Oku</a>
                    </div>
                </article>
            <?php endforeach; ?>
        <?php endif; ?>
    </div>

    <footer class="site-footer">
        &copy; <?= date('Y') ?> Emira — Veri Tabanı Ödev 4
    </footer>
</div>
</body>
</html>
