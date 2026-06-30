<?php
require 'db.php';

// URL'den ID gelmemişse veya geçersizse ana sayfaya yolla
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    header('Location: index.php');
    exit;
}

$id = $_GET['id'];

// İlgili tarifi veritabanından çek
$stmt = $pdo->prepare('SELECT * FROM Tarifler WHERE id = ?');
$stmt->execute([$id]);
$tarif = $stmt->fetch();

// Tarif bulunamadıysa ana sayfaya yolla
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
    <title><?= htmlspecialchars($tarif['baslik']) ?> | Tarif Detayı</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background: #fdfdfd; margin: 0; padding: 0; color: #333; }
        .hero { position: relative; height: 50vh; min-height: 400px; background-color: #333; display: flex; align-items: flex-end; justify-content: center; overflow: hidden; }
        .hero img { position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; opacity: 0.6; z-index: 1; }
        .hero-content { position: relative; z-index: 2; text-align: center; color: white; padding: 40px; width: 100%; background: linear-gradient(to top, rgba(0,0,0,0.8), transparent); }
        .hero h1 { font-size: 3rem; margin: 0 0 10px 0; text-shadow: 2px 2px 10px rgba(0,0,0,0.5); }
        .hero p { opacity: 0.8; margin: 0; font-size: 1.1rem; }
        
        .container { max-width: 800px; margin: -40px auto 50px; position: relative; z-index: 3; background: white; padding: 40px; border-radius: 20px; box-shadow: 0 15px 40px rgba(0,0,0,0.08); }
        .content { line-height: 1.8; font-size: 1.1rem; color: #444; white-space: pre-wrap; /* Satır atlamalarını korur */ }
        
        .nav-bar { position: absolute; top: 20px; left: 20px; z-index: 10; }
        .back-btn { background: rgba(255,255,255,0.2); backdrop-filter: blur(5px); color: white; text-decoration: none; padding: 10px 20px; border-radius: 50px; font-weight: 600; border: 1px solid rgba(255,255,255,0.4); transition: 0.3s; }
        .back-btn:hover { background: white; color: #333; }
    </style>
</head>
<body>

<div class="nav-bar">
    <a href="index.php" class="back-btn">&larr; Menüye Dön</a>
</div>

<div class="hero">
    <?php if($tarif['fotograf_url']): ?>
        <img src="<?= htmlspecialchars($tarif['fotograf_url']) ?>" alt="Yemek">
    <?php else: ?>
        <img src="https://images.unsplash.com/photo-1495521821757-a1efb6729352?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80" alt="Varsayılan Yemek">
    <?php endif; ?>
    
    <div class="hero-content">
        <h1><?= htmlspecialchars($tarif['baslik']) ?></h1>
        <p>Eklenme Tarihi: <?= date('d.m.Y H:i', strtotime($tarif['olusturulma_tarihi'])) ?></p>
    </div>
</div>

<div class="container">
    <h2>Nasıl Yapılır?</h2>
    <hr style="border: 0; height: 1px; background: #eee; margin-bottom: 30px;">
    
    <div class="content"><?= htmlspecialchars($tarif['detay']) ?></div>
</div>

</body>
</html>