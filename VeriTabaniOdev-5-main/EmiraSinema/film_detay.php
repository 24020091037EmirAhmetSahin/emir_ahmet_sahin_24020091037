<?php
require 'db_connect.php';
$pageTitle = 'Film Detayı';
include 'header.php';

$filmId = isset($_GET['filmId']) ? (int) $_GET['filmId'] : 0;

$sql_movie = 'SELECT m.*, g.genre_name, d.full_name AS director_name 
              FROM movies m
              LEFT JOIN genres g ON m.genre_id = g.id
              LEFT JOIN directors d ON m.director_id = d.id
              WHERE m.id = :film_id';
$stmt_movie = $pdo->prepare($sql_movie);
$stmt_movie->execute(['film_id' => $filmId]);
$movie = $stmt_movie->fetch(PDO::FETCH_ASSOC);

if (!$movie) {
    echo '<div class="alert alert-danger">Film bulunamadı.</div></div></body></html>';
    exit();
}

$sql_cast = 'SELECT a.id, a.full_name, c.role_name
             FROM casting c
             JOIN actors a ON c.actor_id = a.id
             WHERE c.movie_id = :film_id';
$stmt_cast = $pdo->prepare($sql_cast);
$stmt_cast->execute(['film_id' => $filmId]);
$cast = $stmt_cast->fetchAll(PDO::FETCH_ASSOC);
?>

<div class="row justify-content-center">
    <div class="col-lg-10">
        <div class="card-emira overflow-hidden mt-2">
            <div class="row g-0">
                <div class="col-md-4 bg-dark d-flex align-items-center justify-content-center p-0">
                    <?php if (!empty($movie['poster_image'])): ?>
                        <div style="aspect-ratio: 2/3; width: 100%; overflow: hidden;">
                            <img src="data:image/jpeg;base64,<?= base64_encode($movie['poster_image']) ?>" class="w-100 h-100" style="object-fit: cover;" alt="Poster">
                        </div>
                    <?php else: ?>
                        <i class="bi bi-camera-reels text-warning py-5" style="font-size: 5rem; opacity: 0.4;"></i>
                    <?php endif; ?>
                </div>

                <div class="col-md-8 p-4 p-md-5">
                    <h1 class="brand-title mb-2"><?= htmlspecialchars($movie['title']) ?></h1>
                    <p class="text-secondary mb-4">Yapım Yılı: <?= $movie['release_year'] ?></p>

                    <div class="mb-4 d-flex flex-wrap gap-2">
                        <?php if ($movie['genre_name']): ?>
                            <a href="kategori.php?turId=<?= $movie['genre_id'] ?>" class="badge-genre px-3 py-2 text-decoration-none">
                                <i class="bi bi-tags-fill me-1"></i><?= htmlspecialchars($movie['genre_name']) ?>
                            </a>
                        <?php endif; ?>
                        <span class="badge-genre px-3 py-2">
                            <i class="bi bi-person-video me-1"></i><?= htmlspecialchars($movie['director_name'] ?? 'Bilinmiyor') ?>
                        </span>
                    </div>

                    <h5 class="fw-bold mb-3">Özet</h5>
                    <p class="text-secondary" style="line-height: 1.8;"><?= nl2br(htmlspecialchars($movie['summary'])) ?></p>

                    <?php if (!empty($cast)): ?>
                        <h5 class="fw-bold mt-4 mb-3">Oyuncu Kadrosu</h5>
                        <div class="d-flex flex-wrap gap-2">
                            <?php foreach ($cast as $actor): ?>
                                <a href="oyuncu_profil.php?oyuncuId=<?= $actor['id'] ?>" class="badge-genre px-3 py-2 text-decoration-none">
                                    <?= htmlspecialchars($actor['full_name']) ?> — <?= htmlspecialchars($actor['role_name']) ?>
                                </a>
                            <?php endforeach; ?>
                        </div>
                    <?php endif; ?>

                    <div class="mt-4 pt-3 border-top" style="border-color: var(--border) !important;">
                        <a href="index.php" class="btn btn-outline-gold px-4 me-2"><i class="bi bi-arrow-left me-1"></i> Vitrine Dön</a>
                        <a href="film_duzenle.php?filmId=<?= $filmId ?>" class="btn btn-gold px-4"><i class="bi bi-pencil me-1"></i> Düzenle / Sil</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</div>
</body>
</html>
