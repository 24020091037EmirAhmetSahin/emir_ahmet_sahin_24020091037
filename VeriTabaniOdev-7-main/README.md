# Emira Not Defteri — Veri Tabanı Ödev 7
<img width="1919" height="1012" alt="5 1" src="https://github.com/user-attachments/assets/3e2c29a4-e8da-405b-ad16-db8b98a9dc55" />

**Geliştirici:** Emira  
**Ders:** Veri Tabanları  
**Teknoloji:** React Native (Expo) + Firebase Firestore

Firebase Firestore kullanılarak geliştirilmiş, gerçek zamanlı veri senkronizasyonu sunan çapraz platform bir not defteri uygulaması.

## Özellikler

- **Gerçek Zamanlı Veritabanı:** Firestore `onSnapshot` ile anlık veri akışı
- **Tam CRUD:** Not ekleme, okuma, güncelleme ve silme
- **Modern Arayüz:** Mor-pembe temalı, karanlık mod odaklı tasarım
- **Çapraz Platform:** Android, iOS ve Web desteği

## Kurulum

```bash
cd EmiraNotDefteri
npm install
npx expo start
```

Terminalde `w` tuşuna basarak web sürümünü açabilirsin.

## Proje Yapısı

```
EmiraNotDefteri/
├── src/
│   ├── app/
│   │   ├── index.tsx          # Ana not ekranı
│   │   ├── hakkimda.tsx       # Hakkımda sayfası
│   │   └── _layout.tsx        # Uygulama düzeni
│   ├── emiraFirebaseConfig.js # Firebase bağlantı ayarları
│   └── constants/theme.ts     # Renk paleti ve tema
├── app.json
└── package.json
```

## Teknolojiler

| Katman | Teknoloji |
|--------|-----------|
| Framework | React Native & Expo (Expo Router) |
| Veritabanı | Firebase Firestore |
| Dil | TypeScript / JavaScript |

---

© 2026 Emira · Veri Tabanı Ödev 7
