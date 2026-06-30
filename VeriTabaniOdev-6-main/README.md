# Emira · Günün Notu

React Native (Expo) ve yerel SQLite ile geliştirilmiş **Günün Notu** mobil uygulaması.

**Geliştirici:** Emira  
**Ders:** Veritabanı · Ödev 6  
**Veritabanı:** `EmiraNotes.db` (expo-sqlite)

## Özellikler

- **Create:** Yeni not ekleme
- **Read:** Notları en yeniden eskiye listeleme
- **Update:** Mevcut notu düzenleme
- **Delete:** Notu kalıcı silme (onay ile)
- **Offline:** Tüm veriler cihazda saklanır, internet gerekmez

## Teknolojiler

- React Native · Expo SDK 56
- expo-sqlite
- TypeScript

## Proje Yapısı

```
src/
├── app/
│   ├── _layout.tsx      # Ana layout
│   └── index.tsx        # Notlar ekranı
├── components/
│   └── note-card.tsx    # Not kartı bileşeni
├── hooks/
│   └── use-notes-database.ts  # SQLite CRUD hook'u
├── types/
│   └── note.ts          # Not tipi
└── constants/
    └── theme.ts         # Renk paleti
```

## Kurulum

1. Bağımlılıkları yükleyin:

```bash
npm install
```

2. Uygulamayı başlatın:

```bash
npm start
```

3. Terminalde:
   - `a` → Android emülatör / cihaz
   - `w` → Web tarayıcı
   - `i` → iOS simülatör (macOS)

Alternatif:

```bash
npm run android
npm run web
```

## Not

Expo Go ile test ederken telefon ve bilgisayarın aynı ağda olduğundan emin olun.
