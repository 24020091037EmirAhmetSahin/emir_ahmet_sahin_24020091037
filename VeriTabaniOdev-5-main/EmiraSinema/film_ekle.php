<?php
require 'db_connect.php';
$activePage = 'add';
$pageTitle = 'Film Ekle';
include 'header.php';

$genres = $pdo->query('SELECT * FROM genres')->fetchAll(PDO::FETCH_ASSOC);
$directors = $pdo->query('SELECT * FROM directors')->fetchAll(PDO::FETCH_ASSOC);
?>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="panel-emira form-emira">
            <h2 class="brand-title mb-4"><i class="bi bi-plus-circle text-warning me-2"></i>Yeni Film Ekle</h2>

            <form action="film_yonet.php" method="POST" enctype="multipart/form-data">
                <div class="row mb-4">
                    <div class="col-md-8">
                        <label class="form-label">Film Adı</label>
                        <input type="text" name="title" class="form-control" required placeholder="Filmin adını girin">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Poster</label>
                        <input type="file" name="poster" class="form-control" accept="image/*">
                    </div>
                </div>

                <div class="row mb-4">
                    <div class="col-md-4">
                        <label class="form-label">Yayın Yılı</label>
                        <input type="number" name="release_year" class="form-control" required placeholder="2024">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Tür</label>
                        <select name="genre_id" class="form-select" required>
                            <option value="">Seçiniz...</option>
                            <?php foreach ($genres as $g): ?>
                                <option value="<?= $g['id'] ?>"><?= htmlspecialchars($g['genre_name']) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Yönetmen</label>
                        <select name="director_id" class="form-select" required>
                            <option value="">Seçiniz...</option>
                            <?php foreach ($directors as $d): ?>
                                <option value="<?= $d['id'] ?>"><?= htmlspecialchars($d['full_name']) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">Film Özeti</label>
                    <textarea name="summary" class="form-control" rows="5" required placeholder="Filmin konusunu yazın..."></textarea>
                </div>

                <button type="submit" name="add_movie" class="btn btn-gold w-100 py-2">
                    <i class="bi bi-check2-circle me-1"></i> Kaydet
                </button>
            </form>
        </div>
    </div>
</div>

</div>
</body>
</html>
