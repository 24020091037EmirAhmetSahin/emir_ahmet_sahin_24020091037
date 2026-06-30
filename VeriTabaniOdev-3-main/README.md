# Emira Sepet Yönetim Sistemi
<img width="876" height="747" alt="1 2" src="https://github.com/user-attachments/assets/044fae7c-7ad9-4fde-9bb9-5b74bf60785e" />
<img width="885" height="752" alt="1 1" src="https://github.com/user-attachments/assets/e5123082-7d4e-4dfa-810e-9f9b0fc08ea6" />

**Geliştirici:** Emira  
**Ders:** Veritabanı Yönetim Sistemleri

Bu proje, ilişkisel veritabanı üzerinde CRUD işlemlerini farklı platformlarda gösteren çoklu istemcili bir sepet yönetim uygulamasıdır.

---

## Proje İçeriği

| Klasör | Platform | Açıklama |
|--------|----------|----------|
| `EmiraSepet-java` | Java Swing | Koyu tema, H2 gömülü veritabanı — kurulum gerektirmeden çalışır |
| `emira_sepet_php` | PHP | Web tabanlı sepet yönetimi |
| `EmiraSepetForm` | C# WinForms | Masaüstü uygulama |
| `EmiraSepetASP` | ASP.NET | Web Forms uygulaması |

---

## Hızlı Başlangıç (Java)

En kolay çalıştırma yolu Java sürümüdür. Harici SQL Server kurulumu gerekmez; veritabanı `data/emira_sepet_db` altında otomatik oluşturulur.

### Gereksinimler

- Java JDK 17 veya üzeri
- `lib/h2-2.2.224.jar` (projede dahil)

### Çalıştırma

```bat
cd EmiraSepet-java
calistir.bat
```

veya manuel:

```bat
javac -encoding UTF-8 -cp lib\h2-2.2.224.jar -d build\classes src\emirasepet\*.java
java -cp lib\h2-2.2.224.jar;build\classes emirasepet.EmiraSepetUygulamasi
```

---

## Veritabanı Şeması

MySQL / SQL Server için:

```sql
CREATE DATABASE emira_sepet_db;
USE emira_sepet_db;

CREATE TABLE sepet (
    id INT PRIMARY KEY AUTO_INCREMENT,
    musteri_adi VARCHAR(100) NOT NULL,
    durum VARCHAR(50) DEFAULT 'aktif'
);

CREATE TABLE sepet_urun (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sepet_id INT NOT NULL,
    urun_adi VARCHAR(100) NOT NULL,
    adet INT DEFAULT 1,
    fiyat DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (sepet_id) REFERENCES sepet(id) ON DELETE CASCADE
);
```

SQL Server için `AUTO_INCREMENT` yerine `IDENTITY(1,1)` kullanın.

### Bağlantı Ayarları (PHP / C# / ASP)

```
Sunucu : localhost
Veritabanı : emira_sepet_db
Kullanıcı : emira
Şifre : emira123
```

---

## Özellikler

- Sepet oluşturma, listeleme ve silme
- Sepete ürün ekleme / çıkarma
- Anlık toplam tutar hesaplama
- Master-detail ilişki (`ON DELETE CASCADE`)
- Form doğrulama kontrolleri

---

## Ekran Görüntüsü

Java uygulaması koyu tema ve teal vurgu rengiyle tasarlanmıştır. Başlık çubuğunda **Emira Sepet Yönetimi** görünür.

---

*Emira — Veritabanı Yönetim Sistemleri Ödevi*
