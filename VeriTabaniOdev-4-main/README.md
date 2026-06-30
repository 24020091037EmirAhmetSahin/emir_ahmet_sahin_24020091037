# Emira Mutfak — Veri Tabanı Ödev 4
<img width="1914" height="993" alt="2 1" src="https://github.com/user-attachments/assets/b3f5526b-50d2-430a-bda1-6d318b6b0188" />

**Geliştirici:** Emira  
**Ders:** Veri Tabanı Sistemleri  
**Proje:** Çoklu dil ve VTYS entegrasyonlu yemek tarifi portalı

Bu proje, aynı iş mantığı ve arayüz tasarımına sahip bir yemek tarifi uygulamasının üç farklı platformda geliştirilmiş versiyonlarını içerir.

---

## Teknoloji Eşleşmeleri

| Klasör | Dil / Platform | Veritabanı |
| :--- | :--- | :--- |
| **emira-tarif-php** | PHP 8.x | SQLite (yerel, kurulum gerektirmez) |
| **yemektarif-asp** | ASP.NET Web Forms (C#) | Microsoft SQL Server |
| **yemekTarif-jsp** | Java JSP (Maven) | PostgreSQL |

---

## Tasarım

Tüm platformlarda **Emira Mutfak** teması kullanılır:

- Koyu yeşil gradient arka plan
- Fraunces + Outfit fontları
- Krem renkli kartlar ve bakır/altın vurgular
- Responsive grid yapısı

Paylaşılan stil dosyası: `assets/emira-stil.css`

---

## PHP Sürümünü Çalıştırma (Önerilen)

PHP 8.3 kurulu olmalıdır. Proje SQLite kullanır; MySQL kurulumu gerekmez.

```powershell
cd emira-tarif-php
php -S localhost:8080
```

Tarayıcıda aç: **http://localhost:8080**

İlk çalıştırmada `emira_tarifler.sqlite` otomatik oluşturulur ve 3 örnek tarif eklenir.

### PHP Dosya Yapısı

| Dosya | Açıklama |
| :--- | :--- |
| `index.php` | Ana sayfa — tarif listesi |
| `tarif-detay.php` | Tek tarif detay sayfası |
| `yonetim.php` | CRUD yönetim paneli |
| `veritabani.php` | SQLite bağlantısı ve tablo kurulumu |
| `assets/emira-stil.css` | Ortak stil dosyası |

---

## ASP.NET Sürümü

1. Visual Studio ile `yemektarif-asp/YemekTarif/YemekTarif.csproj` dosyasını açın.
2. `Web.config` içindeki MSSQL bağlantı dizesini güncelleyin.
3. MSSQL'de `Tarifler` tablosunu oluşturun (aşağıdaki şema).
4. IIS Express ile `Default.aspx` sayfasını çalıştırın.

---

## JSP Sürümü

1. PostgreSQL'de `emira_tarif_db` veritabanını oluşturun.
2. `index.jsp`, `crud.jsp`, `detay.jsp` dosyalarındaki bağlantı bilgilerini güncelleyin.
3. Maven ile derleyip Tomcat'e deploy edin:

```bash
cd yemekTarif-jsp
mvn clean package
```

---

## Veritabanı Şeması (MSSQL / PostgreSQL / MySQL)

| Sütun | Tip | Özellik |
| :--- | :--- | :--- |
| `id` | INT / SERIAL | Primary Key, Auto Increment |
| `baslik` | VARCHAR(255) | Not Null |
| `detay` | TEXT | Not Null |
| `fotograf_url` | VARCHAR(255) | Nullable |
| `olusturulma_tarihi` | DATETIME / TIMESTAMP | Default: NOW |

---

## Özellikler

- Tarif listeleme (kart görünümü)
- Tarif detay sayfası
- CRUD yönetim paneli (ekle, güncelle, sil)
- Modal ile düzenleme (PHP ve ASP)

---

## Notlar

- PHP sürümü **hemen çalışır** durumda (SQLite + örnek veri).
- ASP ve JSP sürümleri için ilgili veritabanı sunucusunun kurulu ve yapılandırılmış olması gerekir.
- Bağlantı bilgilerini kendi ortamınıza göre güncellemeyi unutmayın.

---

*© 2026 Emira — Veri Tabanı Ödev 4*
