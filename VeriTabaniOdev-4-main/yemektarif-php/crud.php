<?php
require 'db.php';

// --- CREATE (Yeni Tarif Ekleme) ---
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['ekle'])) {
    $baslik = $_POST['baslik'];
    $detay = $_POST['detay'];
    $foto_url = $_POST['foto_url'];
    $sql = "INSERT INTO Tarifler (baslik, detay, fotograf_url) VALUES (?, ?, ?)";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$baslik, $detay, $foto_url]);
    header("Location: crud.php");
    exit;
}

// --- UPDATE (Tarif Güncelleme) ---
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['guncelle'])) {
    $id = $_POST['id'];
    $baslik = $_POST['baslik'];
    $detay = $_POST['detay'];
    $foto_url = $_POST['foto_url'];
    $sql = "UPDATE Tarifler SET baslik = ?, detay = ?, fotograf_url = ? WHERE id = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$baslik, $detay, $foto_url, $id]);
    header("Location: crud.php");
    exit;
}

// --- DELETE (Tarif Silme) ---
if (isset($_GET['sil'])) {
    $id = $_GET['sil'];
    $sql = "DELETE FROM Tarifler WHERE id = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$id]);
    header("Location: crud.php");
    exit;
}

// --- READ (Tarifleri Listeleme) ---
$stmt = $pdo->query('SELECT * FROM Tarifler ORDER BY id DESC');
$tarifler = $stmt->fetchAll();
?>
<!DOCTYPE html>
<html lang="tr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tarif Yönetimi Paneli</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f0f2f5;
            margin: 0;
            padding: 30px;
            color: #333;
        }

        .nav {
            margin-bottom: 30px;
        }

        .nav a {
            text-decoration: none;
            color: #fff;
            background: #2c3e50;
            padding: 10px 20px;
            border-radius: 8px;
            transition: 0.3s;
        }

        .nav a:hover {
            background: #34495e;
        }

        .container {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 30px;
            max-width: 1400px;
            margin: 0 auto;
        }

        .panel {
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
        }

        h2 {
            margin-top: 0;
            color: #2c3e50;
            font-size: 1.5rem;
            margin-bottom: 25px;
        }

        input,
        textarea,
        button {
            width: 100%;
            margin-bottom: 20px;
            padding: 15px;
            border-radius: 10px;
            border: 1px solid #e1e5eb;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
            background: #f8f9fa;
        }

        input:focus,
        textarea:focus {
            outline: none;
            border-color: #3498db;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }

        .btn-submit {
            background: #2ecc71;
            color: white;
            border: none;
            cursor: pointer;
            font-weight: 600;
            font-size: 1rem;
            transition: 0.3s;
        }

        .btn-submit:hover {
            background: #27ae60;
            transform: translateY(-2px);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #f8f9fa;
            padding: 15px;
            text-align: left;
            color: #7f8c8d;
            border-bottom: 2px solid #e1e5eb;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #e1e5eb;
            vertical-align: middle;
        }

        /* İşlem butonlarının bulunduğu hücreyi flex yapıyoruz ki yan yana ok gibi dursunlar */
        .action-links {
            display: flex;
            gap: 10px;
            /* Butonlar arasına eşit boşluk */
            align-items: center;
        }

        /* Hem link hem buton etiketlerini birebir aynı boyuta getiriyoruz */
        .action-links a,
        .action-links button {
            text-decoration: none;
            padding: 0 16px;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: 500;
            cursor: pointer;
            border: none;
            font-family: 'Poppins', sans-serif;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            height: 38px;
            /* İkisine de sabit yükseklik verdik, sorun çözüldü */
            box-sizing: border-box;
            margin: 0;
            transition: 0.2s ease;
        }

        .btn-edit {
            background: #f39c12;
            color: white;
        }

        .btn-delete {
            background: #e74c3c;
            color: white;
        }

        /* Modal (Popup) CSS */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4);
            backdrop-filter: blur(5px);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: #fff;
            padding: 30px;
            border-radius: 20px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.2);
            position: relative;
            animation: slideDown 0.3s ease-out;
        }

        .close-btn {
            position: absolute;
            top: 15px;
            right: 20px;
            font-size: 28px;
            font-weight: bold;
            color: #aaa;
            cursor: pointer;
        }

        .close-btn:hover {
            color: #333;
        }

        @keyframes slideDown {
            from {
                transform: translateY(-50px);
                opacity: 0;
            }

            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @media (max-width: 900px) {
            .container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

    <div class="nav">
        <a href="index.php">&larr; Ana Ekrana Dön</a>
    </div>

    <div class="container">
        <div class="panel">
            <h2>✨ Yeni Tarif Ekle</h2>
            <form method="POST">
                <input type="text" name="baslik" placeholder="Yemek Adı" required>
                <input type="text" name="foto_url" placeholder="Fotoğraf URL">
                <textarea name="detay" rows="6" placeholder="Tarif Detayları" required></textarea>
                <button type="submit" name="ekle" class="btn-submit">Tarifi Kaydet</button>
            </form>
        </div>

        <div class="panel">
            <h2>📋 Kayıtlı Tarifler</h2>
            <div style="overflow-x:auto;">
                <table>
                    <tr>
                        <th width="5%">ID</th>
                        <th width="65%">Yemek Başlığı</th>
                        <th width="30%">İşlemler</th>
                    </tr>
                    <?php foreach ($tarifler as $t): ?>
                        <tr>
                            <td><strong>#<?= $t['id'] ?></strong></td>
                            <td><?= htmlspecialchars($t['baslik']) ?></td>
                            <td class="action-links">
                                <!-- Düzenle Butonu (Data attribute'ları ile veriyi JS'e yolluyoruz) -->
                                <button class="btn-edit" data-id="<?= $t['id'] ?>"
                                    data-baslik="<?= htmlspecialchars($t['baslik']) ?>"
                                    data-foto="<?= htmlspecialchars($t['fotograf_url']) ?>"
                                    data-detay="<?= htmlspecialchars($t['detay']) ?>"
                                    onclick="openModal(this)">Düzenle</button>
                                <a href="?sil=<?= $t['id'] ?>" class="btn-delete"
                                    onclick="return confirm('Silmek istediğine emin misin?');">Sil</a>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </table>
            </div>
        </div>
    </div>

    <!-- DÜZENLEME MODALI (POPUP) -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close-btn" onclick="closeModal()">&times;</span>
            <h2>✏️ Tarifi Güncelle</h2>
            <form method="POST">
                <input type="hidden" name="id" id="modal_id">
                <input type="text" name="baslik" id="modal_baslik" required>
                <input type="text" name="foto_url" id="modal_foto">
                <textarea name="detay" id="modal_detay" rows="6" required></textarea>
                <button type="submit" name="guncelle" class="btn-submit" style="background: #3498db;">Değişiklikleri
                    Kaydet</button>
            </form>
        </div>
    </div>

    <script>
        // Modal Açma Fonksiyonu
        function openModal(button) {
            document.getElementById('modal_id').value = button.getAttribute('data-id');
            document.getElementById('modal_baslik').value = button.getAttribute('data-baslik');
            document.getElementById('modal_foto').value = button.getAttribute('data-foto');
            document.getElementById('modal_detay').value = button.getAttribute('data-detay');

            document.getElementById('editModal').style.display = 'flex';
        }

        // Modal Kapatma Fonksiyonu
        function closeModal() {
            document.getElementById('editModal').style.display = 'none';
        }

        // Modal dışına tıklayınca kapanması için
        window.onclick = function (event) {
            var modal = document.getElementById('editModal');
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>

</body>

</html>