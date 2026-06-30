# Veritabanı Yönetim Sistemleri — Emira (Ödev 5)
<img width="1919" height="903" alt="3 3" src="https://github.com/user-attachments/assets/50635560-a930-4207-893d-2471d8c53e01" />
<img width="1919" height="912" alt="3 2" src="https://github.com/user-attachments/assets/ec0bf328-2a93-4aac-99c1-03b88542f4fb" />
<img width="1919" height="991" alt="3 1" src="https://github.com/user-attachments/assets/6c5afce1-cbdf-40ed-ab03-8eecf7eabb27" />

Üç ayrı web uygulaması: farklı backend + farklı veritabanı.

| # | Proje | Klasör | Teknoloji | Veritabanı |
|---|-------|--------|-----------|------------|
| 1 | **EmiraGezi** | `SehirRehberi/` | JSP + Java | PostgreSQL |
| 2 | **EmiraSinema** | `EmiraSinema/` | PHP | MySQL |
| 3 | **EmiraKlinik** | `HastaneOtomasyon/` | ASP.NET C# | MS SQL Server |

---

## Hızlı Başlatma

```powershell
# 1) PostgreSQL (proje içi, port 5433)
.\baslat_postgres.bat

# 2) Şehir Rehberi — JSP (port 9090)
.\baslat_gezi.bat

# 3) Mini IMDb — PHP (port 8888)
.\baslat_sinema.bat
# İlk sefer: http://localhost:8888/kurulum.php → MySQL şifreni gir

# 4) Hastane — Visual Studio ile HastaneOtomasyon.sln aç
# SQL: veritabani\emira_klinik_mssql.sql
```

---

## 1️⃣ EmiraGezi — Şehir Rehberi (JSP & PostgreSQL)

**Özellikler:** Dark mode, ILIKE arama, INNER JOIN, Many-to-Many (`City_Guide_Match`)

- Ana sayfa: http://localhost:9090/index.jsp
- Arama: http://localhost:9090/Arama.jsp
- Şehir detay: `SehirDetay.jsp?cityId=1`
- Mekan detay: `MekanDetay.jsp?placeId=1`

**Veritabanı:** Proje içi PostgreSQL (`veritabani/postgres_data`, port **5433**)

```powershell
.\baslat_postgres.bat
cd SehirRehberi
.\mvnw.cmd jetty:run
```

---

## 2️⃣ EmiraSinema — Mini IMDb (PHP & MySQL)

**Özellikler:** JOIN sorguları, tam CRUD (ekle / güncelle / sil)

| Sayfa | Açıklama |
|-------|----------|
| `index.php` | Film vitrini |
| `film_detay.php?filmId=1` | Detay + oyuncu kadrosu |
| `film_ekle.php` | Yeni film |
| `film_duzenle.php?filmId=1` | Güncelle / sil |
| `oyuncu_profil.php?oyuncuId=1` | Oyuncu filmografisi |
| `kategori.php?turId=1` | Tür filtresi |

**Kurulum:**
1. `php.ini` → `extension=pdo_mysql` aktif olmalı
2. http://localhost:8888/kurulum.php → MySQL root şifreni gir
3. `config.php` otomatik oluşur

```powershell
cd EmiraSinema
php -S localhost:8888
```

---

## 3️⃣ EmiraKlinik — Hastane Otomasyonu (ASP.NET & MS SQL)

**Özellikler:** `SqlTransaction`, `Rollback/Commit`, `SCOPE_IDENTITY()`, parametreli sorgular

**Veritabanı kurulumu:**
```powershell
sqlcmd -S localhost -E -i veritabani\emira_klinik_mssql.sql
```

**Çalıştırma:** Visual Studio → `HastaneOtomasyon\HastaneOtomasyon.sln` → IIS Express

`Web.config` → `EmiraKlinikDB` bağlantı dizesi

---

## Geliştirici

**Emira** — Veritabanı Yönetim Sistemleri Ödev 5
