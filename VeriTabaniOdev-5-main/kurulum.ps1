# Emira - Tum projeler icin otomatik kurulum
# Yonetici olarak calistir:  powershell -ExecutionPolicy Bypass -File kurulum.ps1

$ErrorActionPreference = 'Continue'
$Root = $PSScriptRoot
$MysqlBin = 'C:\Program Files\MySQL\MySQL Server 8.0\bin'
$MysqlExe = Join-Path $MysqlBin 'mysql.exe'
$DbPassword = 'emira123'

Write-Host "=== Emira Veritabani Kurulumu ===" -ForegroundColor Cyan

# --- MySQL sifre ayari ---
if (Test-Path $MysqlExe) {
    Write-Host "`n[1/3] MySQL yapilandiriliyor..." -ForegroundColor Yellow
    $initSql = Join-Path $env:TEMP 'emira_mysql_init.sql'
    @"
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DbPassword';
FLUSH PRIVILEGES;
"@ | Set-Content $initSql -Encoding ASCII

    $canConnect = $false
    foreach ($pass in @('', $DbPassword, 'root', '1234')) {
        & $MysqlExe -u root --password=$pass -e "SELECT 1" 2>$null | Out-Null
        if ($LASTEXITCODE -eq 0) {
            if ($pass -ne $DbPassword) {
                & $MysqlExe -u root --password=$pass -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DbPassword'; FLUSH PRIVILEGES;" 2>$null
            }
            $canConnect = $true
            Write-Host "  MySQL root sifresi: $DbPassword" -ForegroundColor Green
            break
        }
    }

    if (-not $canConnect) {
        Write-Host "  MySQL sifresi bilinmiyor. Servisi durdurup sifirlaniyor..." -ForegroundColor Yellow
        Stop-Service MySQL80 -Force -ErrorAction SilentlyContinue
        Start-Sleep 2
        $mysqld = Join-Path $MysqlBin 'mysqld.exe'
        $proc = Start-Process $mysqld -ArgumentList '--skip-grant-tables','--skip-networking','--datadir=C:\ProgramData\MySQL\MySQL Server 8.0\Data' -PassThru
        Start-Sleep 5
        & $MysqlExe -u root -e "FLUSH PRIVILEGES; ALTER USER 'root'@'localhost' IDENTIFIED BY '$DbPassword'; FLUSH PRIVILEGES;" 2>$null
        Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue
        Start-Service MySQL80 -ErrorAction SilentlyContinue
        Start-Sleep 3
    }

    & $MysqlExe -u root --password=$DbPassword -e "source $($Root)\veritabani\emira_sinema_mysql.sql" 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  emira_sinema_db hazir." -ForegroundColor Green
    } else {
        php "$Root\EmiraSinema\kurulum.php" 2>$null
    }
} else {
    Write-Host "  MySQL bulunamadi." -ForegroundColor Red
}

# --- PostgreSQL ---
Write-Host "`n[2/3] PostgreSQL kontrol ediliyor..." -ForegroundColor Yellow
$pgTest = Test-NetConnection localhost -Port 5432 -WarningAction SilentlyContinue
if (-not $pgTest.TcpTestSucceeded) {
  $pgInstalled = Get-Command psql -ErrorAction SilentlyContinue
  if (-not $pgInstalled) {
    Write-Host "  PostgreSQL kuruluyor (winget)..." -ForegroundColor Yellow
    winget install PostgreSQL.PostgreSQL.17 --accept-package-agreements --accept-source-agreements --silent 2>$null
    Start-Sleep 10
  }
}

$psql = Get-ChildItem 'C:\Program Files\PostgreSQL' -Recurse -Filter 'psql.exe' -ErrorAction SilentlyContinue | Select-Object -First 1
if ($psql) {
    $env:PGPASSWORD = $DbPassword
    & $psql.FullName -U postgres -h localhost -c "SELECT 1" 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  PostgreSQL sifresini $DbPassword olarak ayarla (pgAdmin veya installer)." -ForegroundColor Yellow
    }
    $sql = Get-Content "$Root\veritabani\emira_gezi.sql" -Raw
    $sql = $sql -replace 'CREATE DATABASE "EmiraGeziDB";', 'CREATE DATABASE "EmiraGeziDB";' 
    & $psql.FullName -U postgres -h localhost -f "$Root\veritabani\emira_gezi.sql" 2>$null
    if ($LASTEXITCODE -eq 0) { Write-Host "  EmiraGeziDB hazir." -ForegroundColor Green }
    else { Write-Host "  PostgreSQL DB kurulumu manuel gerekebilir." -ForegroundColor Yellow }
} else {
    Write-Host "  PostgreSQL henuz kurulu degil." -ForegroundColor Yellow
}

# --- SQL Server ---
Write-Host "`n[3/3] SQL Server kontrol ediliyor..." -ForegroundColor Yellow
$sqlcmd = Get-ChildItem 'C:\Program Files*\Microsoft SQL Server' -Recurse -Filter 'sqlcmd.exe' -ErrorAction SilentlyContinue | Select-Object -First 1
if (-not $sqlcmd) {
    Write-Host "  SQL Server Express kuruluyor (uzun surebilir)..." -ForegroundColor Yellow
    winget install Microsoft.SQLServer.2022.Express --accept-package-agreements --accept-source-agreements --silent 2>$null
}
$sqlcmd = Get-ChildItem 'C:\Program Files*\Microsoft SQL Server' -Recurse -Filter 'sqlcmd.exe' -ErrorAction SilentlyContinue | Select-Object -First 1
if ($sqlcmd) {
    & $sqlcmd.FullName -S localhost -E -i "$Root\veritabani\emira_klinik_mssql.sql" 2>$null
    if ($LASTEXITCODE -eq 0) { Write-Host "  EmiraKlinikDB hazir." -ForegroundColor Green }
    else { Write-Host "  SQL Server script manuel calistirilmali." -ForegroundColor Yellow }
} else {
    Write-Host "  SQL Server bulunamadi. Visual Studio + SQL Express kur." -ForegroundColor Yellow
}

Write-Host "`n=== Kurulum tamamlandi ===" -ForegroundColor Cyan
Write-Host "EmiraSinema : php -S localhost:8888 -t EmiraSinema"
Write-Host "EmiraGezi   : cd SehirRehberi; .\mvnw.cmd jetty:run"
Write-Host "EmiraKlinik : Visual Studio ile HastaneOtomasyon.sln ac"
