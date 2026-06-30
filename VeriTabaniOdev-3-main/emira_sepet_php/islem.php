<?php
require_once 'db.php';

error_reporting(E_ALL);
ini_set('display_errors', 1);

// Sepet Ekleme
if (isset($_POST['sepet_ekle'])) {
    try {
        $stmt = $conn->prepare("INSERT INTO sepet (musteri_adi, durum) VALUES (?, ?)");
        $stmt->execute([$_POST['musteri_adi'], $_POST['durum']]);
        header("Location: index.php");
        exit;
    } catch (PDOException $e) {
        die("🚨 SEPET EKLENEMEDİ! Hata detayı: " . $e->getMessage());
    }
}

// Ürün Ekleme
if (isset($_POST['urun_ekle'])) {
    try {
        $stmt = $conn->prepare("INSERT INTO sepet_urun (sepet_id, urun_adi, adet, fiyat) VALUES (?, ?, ?, ?)");
        $fiyat = str_replace(',', '.', $_POST['fiyat']);
        
        $stmt->execute([$_POST['sepet_id'], $_POST['urun_adi'], $_POST['adet'], $fiyat]);
        header("Location: index.php?sepet_id=" . $_POST['sepet_id']);
        exit;
    } catch (PDOException $e) {
        die("🚨 ÜRÜN EKLENEMEDİ! Hata detayı: " . $e->getMessage());
    }
}

// Sepet Silme
if (isset($_GET['sepet_sil'])) {
    try {
        $stmt = $conn->prepare("DELETE FROM sepet WHERE id = ?");
        $stmt->execute([$_GET['sepet_sil']]);
        header("Location: index.php");
        exit;
    } catch (PDOException $e) {
        die("🚨 SEPET SİLİNEMEDİ! Hata detayı: " . $e->getMessage());
    }
}

// Ürün Silme
if (isset($_GET['urun_sil'])) {
    try {
        $stmt = $conn->prepare("DELETE FROM sepet_urun WHERE id = ?");
        $stmt->execute([$_GET['urun_sil']]);
        header("Location: index.php?sepet_id=" . $_GET['sepet_id']);
        exit;
    } catch (PDOException $e) {
        die("🚨 ÜRÜN SİLİNEMEDİ! Hata detayı: " . $e->getMessage());
    }
}
?>