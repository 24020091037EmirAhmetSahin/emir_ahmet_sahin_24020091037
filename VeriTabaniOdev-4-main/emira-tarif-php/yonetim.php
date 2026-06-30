<?php
require 'veritabani.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['ekle'])) {
    $stmt = $pdo->prepare('INSERT INTO Tarifler (baslik, detay, fotograf_url) VALUES (?, ?, ?)');
    $stmt->execute([$_POST['baslik'], $_POST['detay'], $_POST['foto_url']]);
    header('Location: yonetim.php');
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['guncelle'])) {
    $stmt = $pdo->prepare('UPDATE Tarifler SET baslik = ?, detay = ?, fotograf_url = ? WHERE id = ?');
    $stmt->execute([$_POST['baslik'], $_POST['detay'], $_POST['foto_url'], $_POST['id']]);
    header('Location: yonetim.php');
    exit;
}

if (isset($_GET['sil']) && is_numeric($_GET['sil'])) {
    $stmt = $pdo->prepare('DELETE FROM Tarifler WHERE id = ?');
    $stmt->execute([(int) $_GET['sil']]);
    header('Location: yonetim.php');
    exit;
}

$tarifler = $pdo->query('SELECT * FROM Tarifler ORDER BY id DESC')->fetchAll();
?>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yönetim Paneli | Emira Mutfak</title>
    <link rel="stylesheet" href="assets/emira-stil.css">
</head>
<body>
<div class="container">
    <header class="site-header">
        <div class="brand">
            <span class="brand-badge">CRUD İşlemleri</span>
            <h1>Tarif Yönetimi</h1>
            <p>Ekle · Güncelle · Sil · Listele</p>
        </div>
        <a href="index.php" class="btn btn-ghost">&larr; Ana Sayfa</a>
    </header>

    <div class="admin-layout">
        <section class="panel">
            <h2>Yeni Tarif Ekle</h2>
            <form method="POST">
                <div class="form-group">
                    <label for="baslik">Yemek Adı</label>
                    <input type="text" id="baslik" name="baslik" placeholder="Örn: Karnıyarık" required>
                </div>
                <div class="form-group">
                    <label for="foto_url">Fotoğraf URL</label>
                    <input type="text" id="foto_url" name="foto_url" placeholder="https://...">
                </div>
                <div class="form-group">
                    <label for="detay">Tarif Detayı</label>
                    <textarea id="detay" name="detay" rows="6" placeholder="Malzemeler ve yapılış..." required></textarea>
                </div>
                <button type="submit" name="ekle" class="btn btn-green">Tarifi Kaydet</button>
            </form>
        </section>

        <section class="panel">
            <h2>Kayıtlı Tarifler</h2>
            <div style="overflow-x:auto;">
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Başlık</th>
                        <th>İşlemler</th>
                    </tr>
                    <?php foreach ($tarifler as $t): ?>
                        <tr>
                            <td><strong>#<?= $t['id'] ?></strong></td>
                            <td><?= htmlspecialchars($t['baslik']) ?></td>
                            <td class="action-links">
                                <button class="btn btn-edit"
                                    data-id="<?= $t['id'] ?>"
                                    data-baslik="<?= htmlspecialchars($t['baslik']) ?>"
                                    data-foto="<?= htmlspecialchars($t['fotograf_url'] ?? '') ?>"
                                    data-detay="<?= htmlspecialchars($t['detay']) ?>"
                                    onclick="openModal(this)">Düzenle</button>
                                <a href="?sil=<?= $t['id'] ?>" class="btn btn-delete"
                                    onclick="return confirm('Bu tarifi silmek istediğinize emin misiniz?');">Sil</a>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </table>
            </div>
        </section>
    </div>

    <footer class="site-footer">
        &copy; <?= date('Y') ?> Emira — Veri Tabanı Ödev 4
    </footer>
</div>

<div id="editModal" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal()">&times;</span>
        <h2>Tarifi Güncelle</h2>
        <form method="POST">
            <input type="hidden" name="id" id="modal_id">
            <div class="form-group">
                <label>Yemek Adı</label>
                <input type="text" name="baslik" id="modal_baslik" required>
            </div>
            <div class="form-group">
                <label>Fotoğraf URL</label>
                <input type="text" name="foto_url" id="modal_foto">
            </div>
            <div class="form-group">
                <label>Tarif Detayı</label>
                <textarea name="detay" id="modal_detay" rows="6" required></textarea>
            </div>
            <button type="submit" name="guncelle" class="btn btn-green">Değişiklikleri Kaydet</button>
        </form>
    </div>
</div>

<script>
function openModal(button) {
    document.getElementById('modal_id').value = button.getAttribute('data-id');
    document.getElementById('modal_baslik').value = button.getAttribute('data-baslik');
    document.getElementById('modal_foto').value = button.getAttribute('data-foto');
    document.getElementById('modal_detay').value = button.getAttribute('data-detay');
    document.getElementById('editModal').style.display = 'flex';
}

function closeModal() {
    document.getElementById('editModal').style.display = 'none';
}

window.onclick = function (event) {
    if (event.target === document.getElementById('editModal')) {
        closeModal();
    }
};
</script>
</body>
</html>
