<?php
$configFile = __DIR__ . '/config.php';
$sqlFile = dirname(__DIR__) . '/veritabani/emira_sinema_mysql.sql';
$messages = [];
$ok = false;

function emira_mysql_baglan(array $config, $withDb = true) {
    $dsn = $withDb
        ? sprintf('mysql:host=%s;dbname=%s;charset=%s', $config['host'], $config['dbname'], $config['charset'])
        : sprintf('mysql:host=%s;charset=%s', $config['host'], $config['charset']);
    $pdo = new PDO($dsn, $config['username'], $config['password']);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    return $pdo;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $config = [
        'host' => trim($_POST['host'] ?? 'localhost'),
        'dbname' => 'emira_sinema_db',
        'username' => trim($_POST['username'] ?? 'root'),
        'password' => $_POST['password'] ?? '',
        'charset' => 'utf8mb4',
    ];

    try {
        if (!extension_loaded('pdo_mysql')) {
            throw new RuntimeException('pdo_mysql eklentisi aktif değil. php.ini içinde extension=pdo_mysql aç.');
        }

        $pdo = emira_mysql_baglan($config, false);
        $messages[] = 'MySQL bağlantısı başarılı.';

        $sql = file_get_contents($sqlFile);
        foreach (array_filter(array_map('trim', preg_split('/;\s*\n/', $sql))) as $statement) {
            if ($statement === '' || stripos($statement, '--') === 0) {
                continue;
            }
            try {
                $pdo->exec($statement);
            } catch (PDOException $e) {
                if (stripos($e->getMessage(), 'database exists') === false) {
                    $messages[] = 'Uyarı: ' . $e->getMessage();
                }
            }
        }

        $count = (int) $pdo->query('SELECT COUNT(*) FROM emira_sinema_db.movies')->fetchColumn();
        $messages[] = 'Veritabanı hazır. Film sayısı: ' . $count;

        $export = "<?php\n/**\n * MySQL bağlantı ayarları\n */\nreturn " . var_export($config, true) . ";\n";
        file_put_contents($configFile, $export);
        $messages[] = 'config.php güncellendi.';
        $ok = true;
    } catch (Throwable $e) {
        $messages[] = 'Hata: ' . $e->getMessage();
    }
}

$config = file_exists($configFile) ? require $configFile : [
    'host' => 'localhost',
    'username' => 'root',
    'password' => '',
];
?>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Kurulum | EmiraSinema (MySQL)</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/emira-cine.css">
</head>
<body>
<div class="container py-5">
    <div class="panel-emira mx-auto p-4 form-emira" style="max-width: 520px;">
        <h1 class="brand-title text-warning mb-3">EmiraSinema — MySQL Kurulum</h1>
        <p class="text-secondary">PHP & MySQL ödevi için veritabanını buradan kur.</p>

        <?php if ($messages): ?>
            <?php foreach ($messages as $msg): ?>
                <p class="<?= $ok ? 'text-success' : 'text-danger' ?>"><?= htmlspecialchars($msg) ?></p>
            <?php endforeach; ?>
            <?php if ($ok): ?>
                <a href="index.php" class="btn btn-gold mt-2">Filmleri Görüntüle</a>
            <?php endif; ?>
        <?php endif; ?>

        <form method="POST" class="mt-4">
            <div class="mb-3">
                <label class="form-label">Sunucu</label>
                <input type="text" name="host" class="form-control" value="<?= htmlspecialchars($config['host'] ?? 'localhost') ?>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Kullanıcı</label>
                <input type="text" name="username" class="form-control" value="<?= htmlspecialchars($config['username'] ?? 'root') ?>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Şifre</label>
                <input type="password" name="password" class="form-control">
            </div>
            <button type="submit" class="btn btn-gold w-100">Veritabanını Kur</button>
        </form>
    </div>
</div>
</body>
</html>
