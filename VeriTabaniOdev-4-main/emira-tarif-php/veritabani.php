<?php
$dbPath = __DIR__ . '/emira_tarifler.sqlite';

try {
    $pdo = new PDO("sqlite:$dbPath", null, null, [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);

    $pdo->exec("
        CREATE TABLE IF NOT EXISTS Tarifler (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            baslik TEXT NOT NULL,
            detay TEXT NOT NULL,
            fotograf_url TEXT,
            olusturulma_tarihi DATETIME DEFAULT CURRENT_TIMESTAMP
        )
    ");

    $count = (int) $pdo->query('SELECT COUNT(*) FROM Tarifler')->fetchColumn();
    if ($count === 0) {
        $ornekler = [
            [
                'Mercimek Çorbası',
                "1 su bardağı kırmızı mercimek\n1 adet soğan\n2 yemek kaşığı salça\nTuz, karabiber\n\nMercimekleri yıkayın. Soğanı kavurun, salçayı ekleyin. Mercimek ve su ilave edip 25 dakika pişirin. Blenderdan geçirip servis edin.",
                'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800&q=80',
            ],
            [
                'Fırın Makarna',
                "400 g penne makarna\n2 su bardağı krema\n200 g kaşar peyniri\nTuz, karabiber\n\nMakarnayı haşlayın. Krema ve peyniri eritin. Fırın kabına alıp 180°C'de 20 dakika pişirin.",
                'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=800&q=80',
            ],
            [
                'Avokado Salatası',
                "2 adet olgun avokado\n1 adet domates\nYarım limon suyu\nZeytinyağı, tuz\n\nAvokadoları küp doğrayın. Domates ve limon suyu ekleyin. Zeytinyağı ile servis edin.",
                'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800&q=80',
            ],
        ];

        $stmt = $pdo->prepare('INSERT INTO Tarifler (baslik, detay, fotograf_url) VALUES (?, ?, ?)');
        foreach ($ornekler as $ornek) {
            $stmt->execute($ornek);
        }
    }
} catch (PDOException $e) {
    die('Veritabanı bağlantı hatası: ' . htmlspecialchars($e->getMessage()));
}
