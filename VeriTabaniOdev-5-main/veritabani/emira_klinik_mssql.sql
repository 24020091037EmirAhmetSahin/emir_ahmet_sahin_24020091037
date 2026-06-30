-- EmiraKlinik MS SQL Server kurulum scripti
-- sqlcmd -S localhost -E -i veritabani\emira_klinik_mssql.sql

IF DB_ID('EmiraKlinikDB') IS NOT NULL
BEGIN
    ALTER DATABASE EmiraKlinikDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE EmiraKlinikDB;
END
GO

CREATE DATABASE EmiraKlinikDB;
GO

USE EmiraKlinikDB;
GO

CREATE TABLE Clinics (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    KlinikAdi NVARCHAR(100) NOT NULL,
    KatNo INT,
    Uzmanlik NVARCHAR(100)
);

CREATE TABLE Doctors (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    KlinikID INT NOT NULL FOREIGN KEY REFERENCES Clinics(ID),
    AdSoyad NVARCHAR(150) NOT NULL,
    Unvan NVARCHAR(100)
);

CREATE TABLE Patients (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    TCKimlik CHAR(11) NOT NULL UNIQUE,
    AdSoyad NVARCHAR(150) NOT NULL,
    Telefon NVARCHAR(20),
    KanGrubu NVARCHAR(10)
);

CREATE TABLE Appointments (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    HastaID INT NOT NULL FOREIGN KEY REFERENCES Patients(ID),
    DoktorID INT NOT NULL FOREIGN KEY REFERENCES Doctors(ID),
    RandevuTarihi DATETIME NOT NULL,
    Sikayet NVARCHAR(500)
);

CREATE TABLE Prescriptions (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    RandevuID INT NOT NULL FOREIGN KEY REFERENCES Appointments(ID),
    IlacListesi NVARCHAR(500)
);

INSERT INTO Clinics (KlinikAdi, KatNo, Uzmanlik) VALUES
(N'Kardiyoloji', 3, N'Kalp ve Damar'),
(N'Dahiliye', 2, N'Genel Dahiliye'),
(N'Ortopedi', 4, N'Kemik ve Eklem'),
(N'Nöroloji', 5, N'Sinir Sistemi');

INSERT INTO Doctors (KlinikID, AdSoyad, Unvan) VALUES
(1, N'Dr. Ayşe Yılmaz', N'Uzman Doktor'),
(1, N'Dr. Mehmet Kara', N'Prof. Dr.'),
(2, N'Dr. Zeynep Ak', N'Uzman Doktor'),
(3, N'Dr. Can Öztürk', N'Op. Dr.'),
(4, N'Dr. Elif Demir', N'Uzman Doktor');

INSERT INTO Patients (TCKimlik, AdSoyad, Telefon, KanGrubu) VALUES
('12345678901', N'Ali Veli', '05321112233', 'A+'),
('98765432109', N'Fatma Nur', '05443334455', '0+');

INSERT INTO Appointments (HastaID, DoktorID, RandevuTarihi, Sikayet) VALUES
(1, 1, DATEADD(HOUR, 9, CAST(CAST(GETDATE() AS DATE) AS DATETIME)), N'Göğüs ağrısı'),
(2, 3, DATEADD(HOUR, 11, CAST(CAST(GETDATE() AS DATE) AS DATETIME)), N'Diz ağrısı'),
(1, 2, DATEADD(DAY, -7, GETDATE()), N'Genel kontrol');

INSERT INTO Prescriptions (RandevuID, IlacListesi) VALUES
(3, N'Parol 500mg - günde 2, Aspirin 100mg - günde 1');
GO
