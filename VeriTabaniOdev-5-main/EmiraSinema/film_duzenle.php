<?php
require 'db_connect.php';
$pageTitle = 'Film Düzenle';
include 'header.php';

$filmId = isset($_GET['filmId']) ? (int) $_GET['filmId'] : 0;
$stmt = $pdo->prepare('SELECT * FROM movies WHERE id = :id');
$stmt->execute(['id' => $filmId]);
$movie = $stmt->fetch();

if (!$movie) {
    echo '<div class="alert alert-danger">Film bulunamadı.</div></div></body></html>';
    exit();
}

$genres = $pdo->query('SELECT * FROM genres')->fetchAll();
$directors = $pdo->query('SELECT * FROM directors')->fetchAll();
?>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="panel-emira form-emira">
            <h2 class="brand-title mb-4"><i class="bi bi-pencil-square text-warning me-2"></i>Film Düzenle</h2>

            <form action="film_yonet.php" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="film_id" value="<?= $movie['id'] ?>">

                <div class="row mb-4">
                    <div class="col-md-8">
                        <label class="form-label">Film Adı</label>
                        <input type="text" name="title" class="form-control" required value="<?= htmlspecialchars($movie['title']) ?>">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Yeni Poster (opsiyonel)</label>
                        <input type="file" name="poster" class="form-control" accept="image/*">
                    </div>
                </div>

                <div class="row mb-4">
                    <div class="col-md-4">
                        <label class="form-label">Yayın Yılı</label>
                        <input type="number" name="release_year" class="form-control" required value="<?= (int) $movie['release_year'] ?>">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Tür</label>
                        <select name="genre_id" class="form-select" required>
                            <?php foreach ($genres as $g): ?>
                                <option value="<?= $g['id'] ?>" <?= $g['id'] == $movie['genre_id'] ? 'selected' : '' ?>>
                                    <?= htmlspecialchars($g['genre_name']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Yönetmen</label>
                        <select name="director_id" class="form-select" required>
                            <?php foreach ($directors as $d): ?>
                                <option value="<?= $d['id'] ?>" <?= $d['id'] == $movie['director_id'] ? 'selected' : '' ?>>
                                    <?= htmlspecialchars($d['full_name']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">Film Özeti</label>
                    <textarea name="summary" class="form-control" rows="5" required><?= htmlspecialchars($movie['summary']) ?></textarea>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" name="update_movie" class="btn btn-gold flex-grow-1">Güncelle</button>
                    <a href="film_yonet.php?sil=1&filmId=<?= $movie['id'] ?>" class="btn btn-outline-danger"
                       onclick="return confirm('Bu filmi silmek istediğine emin misin?')">Sil</a>
                </div>
            </form>
        </div>
    </div>
</div>

</div>
</body>
</html>
