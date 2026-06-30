<?php
require 'db_connect.php';
$pageTitle = 'Kategori';
include 'header.php';

$turId = isset($_GET['turId']) ? (int) $_GET['turId'] : 0;

$stmt_genre = $pdo->prepare('SELECT genre_name FROM genres WHERE id = :id');
$stmt_genre->execute(['id' => $turId]);
$genreInfo = $stmt_genre->fetch(PDO::FETCH_ASSOC);

if (!$genreInfo) {
    echo '<div class="alert alert-danger">Kategori bulunamadı.</div></div></body></html>';
    exit();
}

$sql_movies = 'SELECT id, title, release_year, summary FROM movies WHERE genre_id = :genre_id ORDER BY release_year DESC';
$stmt_movies = $pdo->prepare($sql_movies);
$stmt_movies->execute(['genre_id' => $turId]);
$category_movies = $stmt_movies->fetchAll(PDO::FETCH_ASSOC);
?>

<div class="page-hero">
    <h1><?= htmlspecialchars($genreInfo['genre_name']) ?> Filmleri</h1>
    <p>Bu kategorideki tüm yapımlar</p>
</div>

<div class="row g-3">
    <?php if (empty($category_movies)): ?>
        <div class="col-12"><div class="alert-emira p-4 text-center">Bu kategoride film yok.</div></div>
    <?php else: ?>
        <?php foreach ($category_movies as $m): ?>
            <div class="col-md-6">
                <div class="panel-emira d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="fw-bold mb-1"><?= htmlspecialchars($m['title']) ?></h5>
                        <p class="text-secondary mb-0 small"><?= htmlspecialchars(emira_kisalt($m['summary'] ?? '', 80)) ?></p>
                    </div>
                    <div class="text-end ms-3">
                        <span class="badge-year px-2 py-1 d-block mb-2"><?= $m['release_year'] ?></span>
                        <a href="film_detay.php?filmId=<?= $m['id'] ?>" class="btn btn-sm btn-outline-gold">Detay</a>
                    </div>
                </div>
            </div>
        <?php endforeach; ?>
    <?php endif; ?>
</div>

<div class="mt-4">
    <a href="index.php" class="btn btn-outline-gold"><i class="bi bi-arrow-left me-1"></i> Vitrine Dön</a>
</div>

</div>
</body>
</html>
