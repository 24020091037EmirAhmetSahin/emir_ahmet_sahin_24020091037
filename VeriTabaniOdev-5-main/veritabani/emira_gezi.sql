-- EmiraGezi PostgreSQL kurulumu
-- psql -U postgres -f veritabani/emira_gezi.sql

SELECT 'CREATE DATABASE "EmiraGeziDB"' 
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'EmiraGeziDB')\gexec

\connect EmiraGeziDB

CREATE TABLE IF NOT EXISTS Cities (
    ID SERIAL PRIMARY KEY,
    SehirAdi VARCHAR(100) NOT NULL,
    Bolge VARCHAR(50),
    Nufus INTEGER
);

CREATE TABLE IF NOT EXISTS Places (
    ID SERIAL PRIMARY KEY,
    SehirID INTEGER REFERENCES Cities(ID),
    MekanAdi VARCHAR(150) NOT NULL,
    Aciklama TEXT,
    Tur VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Events (
    ID SERIAL PRIMARY KEY,
    MekanID INTEGER REFERENCES Places(ID),
    EtkinlikAdi VARCHAR(150),
    Tarih DATE,
    Ucret DECIMAL(10,2) DEFAULT 0
);

CREATE TABLE IF NOT EXISTS Guides (
    ID SERIAL PRIMARY KEY,
    RehberAdi VARCHAR(100),
    UzmanlikAlani VARCHAR(100),
    Iletisim VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS City_Guide_Match (
    SehirID INTEGER REFERENCES Cities(ID),
    RehberID INTEGER REFERENCES Guides(ID),
    PRIMARY KEY (SehirID, RehberID)
);

TRUNCATE City_Guide_Match, Events, Places, Guides, Cities RESTART IDENTITY CASCADE;

INSERT INTO Cities (SehirAdi, Bolge, Nufus) VALUES
('İstanbul', 'Marmara', 15840900),
('Ankara', 'İç Anadolu', 5800000),
('İzmir', 'Ege', 4400000),
('Antalya', 'Akdeniz', 2700000),
('Trabzon', 'Karadeniz', 810000);

INSERT INTO Places (SehirID, MekanAdi, Aciklama, Tur) VALUES
(1, 'Ayasofya', 'Bizans ve Osmanlı mimarisinin eşsiz örneği.', 'Tarihi Eser'),
(1, 'Galata Kulesi', 'İstanbul''un panoramik manzarası.', 'Tarihi Eser'),
(2, 'Anıtkabir', 'Atatürk''ün anıt mezarı ve müzesi.', 'Müze'),
(3, 'Efes Antik Kenti', 'Antik dünyanın en iyi korunmuş kentlerinden.', 'Tarihi Eser'),
(4, 'Kaleiçi', 'Tarihi Osmanlı evleri ve dar sokaklar.', 'Tarihi Eser');

INSERT INTO Events (MekanID, EtkinlikAdi, Tarih, Ucret) VALUES
(1, 'Gece Turu', '2026-07-15', 250.00),
(2, 'Gün Batımı Konseri', '2026-08-01', 0),
(3, 'Anıtkabir Rehberli Tur', '2026-07-20', 50.00);

INSERT INTO Guides (RehberAdi, UzmanlikAlani, Iletisim) VALUES
('Emre Yılmaz', 'Tarihi Mekanlar', '0532 111 2233'),
('Selin Kaya', 'Doğa ve Trekking', '0544 555 6677'),
('Can Demir', 'Gastronomi', '0555 888 9900');

INSERT INTO City_Guide_Match (SehirID, RehberID) VALUES
(1, 1), (1, 3), (2, 1), (4, 2);
