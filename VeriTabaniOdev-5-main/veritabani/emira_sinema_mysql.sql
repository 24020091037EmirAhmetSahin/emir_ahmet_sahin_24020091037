-- EmiraSinema MySQL kurulum scripti
-- mysql -u root -p < veritabani/emira_sinema_mysql.sql

CREATE DATABASE IF NOT EXISTS emira_sinema_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE emira_sinema_db;

DROP TABLE IF EXISTS casting;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS directors;
DROP TABLE IF EXISTS genres;

CREATE TABLE genres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(100) NOT NULL
);

CREATE TABLE directors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    experience_years INT
);

CREATE TABLE actors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    birth_date DATE,
    biography TEXT
);

CREATE TABLE movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    release_year INT,
    genre_id INT,
    director_id INT,
    summary TEXT,
    poster_image LONGBLOB,
    FOREIGN KEY (genre_id) REFERENCES genres(id),
    FOREIGN KEY (director_id) REFERENCES directors(id)
);

CREATE TABLE casting (
    id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT,
    actor_id INT,
    role_name VARCHAR(150),
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    FOREIGN KEY (actor_id) REFERENCES actors(id) ON DELETE CASCADE
);

INSERT INTO genres (id, genre_name) VALUES
(1, 'Dram'), (2, 'Aksiyon'), (3, 'Komedi'), (4, 'Bilim Kurgu');

INSERT INTO directors (id, full_name, experience_years) VALUES
(1, 'Nuri Bilge Ceylan', 28),
(2, 'Çağan Irmak', 22),
(3, 'Deniz Gamze Ergüven', 12);

INSERT INTO actors (id, full_name, birth_date, biography) VALUES
(1, 'Haluk Bilginer', '1954-06-16', 'Oscar ödüllü Türk oyuncu. Tiyatro ve sinema kariyeriyle tanınır.'),
(2, 'Melisa Sözen', '1985-06-30', 'Türk sinemasının önde gelen kadın oyuncularından.'),
(3, 'Şahan Gökbakar', '1980-01-22', 'Komedi ve aksiyon filmleriyle tanınan oyuncu ve yönetmen.');

INSERT INTO movies (title, release_year, genre_id, director_id, summary) VALUES
('Kış Uykusu', 2014, 1, 1, 'Emekli bir aktör, Kapadokya''da otel işletirken aile ilişkileri ve inanç üzerine derin bir iç yolculuğa çıkar.'),
('Dedemin İnsanları', 2011, 1, 2, 'Yunanistan''dan Türkiye''ye göç eden bir ailenin hikayesi, nostalji ve kimlik arayışıyla anlatılır.'),
('Mustang', 2015, 1, 3, 'Kırsal Türkiye''de büyüyen beş kız kardeşin özgürlük mücadelesi uluslararası ödüller kazanır.'),
('Recep İvedik 7', 2022, 3, 2, 'Recep İvedik yeni maceralarıyla izleyiciyi güldürmeye devam eder.');

INSERT INTO casting (movie_id, actor_id, role_name) VALUES
(1, 1, 'Aydın'),
(1, 2, 'Nihal'),
(2, 1, 'Anlatıcı'),
(4, 3, 'Recep İvedik');
