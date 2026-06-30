<?php
require 'db_connect.php';
include 'header.php';
$activePage = 'home';
$pageTitle = 'Film Vitrini';

$sql = "SELECT m.id, m.title, m.release_year, m.summary, m.poster_image, g.genre_name 
        FROM movies m 
        LEFT JOIN genres g ON m.genre_id = g.id 
        ORDER BY m.release_year DESC";
$movies = $pdo->query($sql)->fetchAll(PDO::FETCH_ASSOC);
?>

<div class="page-hero d-flex justify-content-between align-items-end flex-wrap gap-3">
    <div>
        <h1>Film Vitrini</h1>
        <p>EmiraSinema — Türk ve dünya sinemasından seçkiler</p>
    </div>
</div>

<div class="row g-4">
    <?php if (empty($movies)): ?>
        <div class="col-12">
            <div class="alert-emira text-center p-5">
                <i class="bi bi-inbox fs-1 d-block mb-3 text-warning"></i>
                <h4>Henüz film yok</h4>
                <p class="mb-3">İlk filmi ekleyerek başlayabilirsin.</p>
                <a href="film_ekle.php" class="btn btn-gold">Film Ekle</a>
            </div>
        </div>
    <?php else: ?>
        <?php foreach ($movies as $movie): ?>
            <div class="col-lg-3 col-md-4 col-sm-6">
                <div class="card-emira h-100">
                    <?php if (!empty($movie['poster_image'])): ?>
                        <div style="aspect-ratio: 2/3; overflow: hidden; background: #000;">
                            <img src="data:image/jpeg;base64,<?= base64_encode($movie['poster_image']) ?>" class="w-100 h-100" style="object-fit: cover;" alt="Poster">
                        </div>
                    <?php else: ?>
                        <div class="d-flex justify-content-center align-items-center" style="aspect-ratio: 2/3; background: var(--bg-elevated);">
                            <i class="bi bi-film text-warning" style="font-size: 3.5rem; opacity: 0.5;"></i>
                        </div>
                    <?php endif; ?>

                    <div class="p-3 d-flex flex-column flex-grow-1">
                        <div class="d-flex justify-content-between align-items-start mb-2 gap-2">
                            <h5 class="fw-bold m-0" style="font-size: 1rem;"><?= htmlspecialchars($movie['title']) ?></h5>
                            <span class="badge-year px-2 py-1"><?= $movie['release_year'] ?></span>
                        </div>
                        <span class="badge-genre px-2 py-1 mb-2 align-self-start"><?= htmlspecialchars($movie['genre_name'] ?? 'Belirtilmemiş') ?></span>
                        <p class="text-secondary flex-grow-1 mb-3" style="font-size: 0.85rem; line-height: 1.5;">
                            <?= htmlspecialchars(emira_kisalt($movie['summary'] ?? '', 90)) ?>
                        </p>
                        <a href="film_detay.php?filmId=<?= $movie['id'] ?>" class="btn btn-outline-gold w-100">Detay</a>
                    </div>
                </div>
            </div>
        <?php endforeach; ?>
    <?php endif; ?>
</div>

<footer class="footer-emira text-center">
    <span>EmiraSinema &mdash; Emira | Veritabanı Ödevi</span>
</footer>

</div>
</body>
</html>
