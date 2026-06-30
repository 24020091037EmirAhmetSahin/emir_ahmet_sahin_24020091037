<?php 
require_once __DIR__ . '/db.php';

error_reporting(E_ALL);
ini_set('display_errors', 1);

// Bağlantı nesnesini kontrol et
if (!isset($conn) || $conn === null) {
    die("HATA: Veritabanı bağlantısı kurulamamış. Lütfen db.php dosyasını kontrol edin.");
}
?>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Emira Sepet Yönetimi | PHP</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #14b8a6;
            --primary-hover: #0d9488;
            --danger: #f43f5e;
            --danger-hover: #e11d48;
            --success: #2dd4bf;
            --success-hover: #14b8a6;
            --bg-color: #0f172a;
            --card-bg: #1e293b;
            --text-main: #f1f5f9;
            --text-muted: #94a3b8;
            --border-color: #334155;
        }

        body { 
            font-family: 'DM Sans', sans-serif; 
            background: linear-gradient(160deg, #0f172a 0%, #134e4a 100%);
            color: var(--text-main);
            margin: 0; 
            padding: 30px;
            min-height: 100vh;
            display: flex; 
            flex-direction: column;
            align-items: center;
        }

        .hero {
            width: 100%;
            max-width: 1200px;
            margin-bottom: 24px;
            padding: 24px 28px;
            background: linear-gradient(90deg, #0d9488, #14b8a6);
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.25);
        }

        .hero h1 {
            margin: 0;
            font-size: 1.8rem;
            color: white;
        }

        .hero p {
            margin: 6px 0 0;
            color: #ccfbf1;
        }

        .container {
            display: flex;
            gap: 25px;
            width: 100%;
            max-width: 1200px;
            align-items: flex-start;
        }

        .panel { 
            background: var(--card-bg); 
            padding: 25px; 
            border-radius: 12px; 
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06); 
            flex: 1; 
        }

        h2 { 
            margin-top: 0; 
            font-size: 1.25rem; 
            color: var(--text-main); 
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        .form-group { 
            display: flex;
            gap: 10px;
            margin-bottom: 20px; 
            background: #0f172a;
            padding: 15px;
            border-radius: 8px;
            border: 1px solid var(--border-color);
        }

        input, select { 
            padding: 10px 12px; 
            border: 1px solid var(--border-color); 
            border-radius: 6px; 
            font-family: inherit;
            flex: 1;
            outline: none;
            transition: border-color 0.2s;
            background: #0f172a;
            color: var(--text-main);
        }

        input:focus, select:focus {
            border-color: var(--primary);
        }

        button { 
            background: var(--primary); 
            color: white; 
            padding: 10px 15px;
            cursor: pointer; 
            border: none; 
            border-radius: 6px; 
            font-weight: 500;
            transition: background-color 0.2s;
        }

        button:hover { background: var(--primary-hover); }
        button.btn-success { background: var(--success); }
        button.btn-success:hover { background: var(--success-hover); }

        table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 10px; 
        }

        th, td { 
            border-bottom: 1px solid var(--border-color); 
            padding: 14px 12px; 
            text-align: left; 
            font-size: 0.95rem;
        }

        th { 
            background-color: #0f172a; 
            color: var(--text-muted); 
            font-weight: 600; 
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 0.05em;
        }

        tr:hover { background-color: #334155; }

        .btn-sil { 
            color: var(--danger); 
            text-decoration: none; 
            font-weight: 600; 
            padding: 6px 10px;
            border-radius: 4px;
            background: #fee2e2;
            transition: all 0.2s;
        }

        .btn-sil:hover { 
            background: var(--danger);
            color: white;
        }

        .sepet-link {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
        }

        .sepet-link:hover {
            text-decoration: underline;
        }

        .durum-badge {
            padding: 4px 8px;
            border-radius: 9999px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: capitalize;
        }
        
        .durum-aktif { background: #dbeafe; color: #1e40af; }
        .durum-tamamlandi { background: #d1fae5; color: #065f46; }
        .durum-iptal { background: #fee2e2; color: #991b1b; }

        .toplam-tutar {
            text-align: right;
            font-size: 1.1rem;
            font-weight: 700;
            padding-top: 15px;
            margin-top: 15px;
            border-top: 2px dashed var(--border-color);
            color: var(--text-main);
        }

        .footer {
            margin-top: 40px;
            text-align: center;
            color: var(--text-muted);
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

<div class="hero">
    <h1>Emira Sepet Yönetimi | PHP</h1>
    <p>PHP · Veritabanı Yönetim Sistemleri · Emira</p>
</div>

<div class="container">
    <div class="panel">
        <h2>🛍️ Sepet Listesi</h2>
        <form action="islem.php" method="POST" class="form-group">
            <input type="text" name="musteri_adi" placeholder="Müşteri Adı" required>
            <select name="durum" style="flex: 0.5;">
                <option value="aktif">Aktif</option>
                <option value="tamamlandi">Tamamlandı</option>
                <option value="iptal">İptal</option>
            </select>
            <button type="submit" name="sepet_ekle">Yeni Sepet</button>
        </form>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Müşteri</th>
                    <th>Durum</th>
                    <th>İşlem</th>
                </tr>
            </thead>
            <tbody>
                <?php
                $sorgu = $conn->query("SELECT * FROM sepet ORDER BY id DESC");
                while ($row = $sorgu->fetch(PDO::FETCH_ASSOC)):
                    $badgeClass = 'durum-' . htmlspecialchars($row['durum']);
                ?>
                <tr>
                    <td>#<?= $row['id'] ?></td>
                    <td><a href="index.php?sepet_id=<?= $row['id'] ?>" class="sepet-link"><?= htmlspecialchars($row['musteri_adi']) ?></a></td>
                    <td><span class="durum-badge <?= $badgeClass ?>"><?= htmlspecialchars($row['durum']) ?></span></td>
                    <td><a href="islem.php?sepet_sil=<?= $row['id'] ?>" class="btn-sil" onclick="return confirm('Sepeti ve içindeki tüm ürünleri silmek istediğinize emin misiniz?')">Sil</a></td>
                </tr>
                <?php endwhile; ?>
            </tbody>
        </table>
    </div>

    <?php if (isset($_GET['sepet_id'])): 
        $s_id = $_GET['sepet_id'];
        $genel_toplam = 0;
    ?>
    <div class="panel">
        <h2>🛒 Sepet Detayı (Sepet #<?= (int)$s_id ?>)</h2>
        <form action="islem.php" method="POST" class="form-group">
            <input type="hidden" name="sepet_id" value="<?= $s_id ?>">
            <input type="text" name="urun_adi" placeholder="Ürün Adı" required>
            <input type="number" name="adet" value="1" min="1" style="flex: 0.3;" title="Adet">
            <input type="number" step="0.01" name="fiyat" placeholder="Birim Fiyat (₺)" required style="flex: 0.5;">
            <button type="submit" name="urun_ekle" class="btn-success">+ Ekle</button>
        </form>

        <table>
            <thead>
                <tr>
                    <th>Ürün Adı</th>
                    <th>Adet</th>
                    <th>Birim F.</th>
                    <th>Ara Toplam</th>
                    <th>İşlem</th>
                </tr>
            </thead>
            <tbody>
                <?php
                $urunSorgu = $conn->prepare("SELECT * FROM sepet_urun WHERE sepet_id = ?");
                $urunSorgu->execute([$s_id]);
                
                $urunler = $urunSorgu->fetchAll(PDO::FETCH_ASSOC);
                
                if(count($urunler) > 0):
                    foreach ($urunler as $urun):
                        $ara_toplam = $urun['adet'] * $urun['fiyat'];
                        $genel_toplam += $ara_toplam;
                ?>
                <tr>
                    <td><?= htmlspecialchars($urun['urun_adi']) ?></td>
                    <td><?= $urun['adet'] ?>x</td>
                    <td><?= number_format($urun['fiyat'], 2) ?> ₺</td>
                    <td><strong><?= number_format($ara_toplam, 2) ?> ₺</strong></td>
                    <td><a href="islem.php?urun_sil=<?= $urun['id'] ?>&sepet_id=<?= $s_id ?>" class="btn-sil">✕</a></td>
                </tr>
                <?php 
                    endforeach; 
                else:
                ?>
                    <tr>
                        <td colspan="5" style="text-align: center; color: #9ca3af; padding: 20px;">Bu sepete henüz ürün eklenmemiş.</td>
                    </tr>
                <?php endif; ?>
            </tbody>
        </table>

        <div class="toplam-tutar">
            Genel Toplam: <span style="color: var(--success); font-size: 1.4rem;"><?= number_format($genel_toplam, 2) ?> ₺</span>
        </div>
    </div>
    <?php endif; ?>
</div>

<div class="footer">
    Veritabanı Yönetim Sistemleri Ödevi | Geliştirici: Emira
</div>

</body>
</html>