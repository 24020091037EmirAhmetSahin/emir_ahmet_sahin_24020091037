<?php
require 'db_connect.php';
$pageTitle = 'Oyuncu Profili';
include 'header.php';

$oyuncuId = isset($_GET['oyuncuId']) ? (int) $_GET['oyuncuId'] : 0;

$stmt_actor = $pdo->prepare('SELECT * FROM actors WHERE id = :id');
$stmt_actor->execute(['id' => $oyuncuId]);
$actor = $stmt_actor->fetch(PDO::FETCH_ASSOC);

if (!$actor) {
    echo '<div class="alert alert-danger">Oyuncu bulunamadı.</div></div></body></html>';
    exit();
}

$sql_filmography = 'SELECT m.id, m.title, m.release_year, c.role_name 
                    FROM casting c
                    JOIN movies m ON c.movie_id = m.id
                    WHERE c.actor_id = :actor_id
                    ORDER BY m.release_year DESC';
$stmt_filmo = $pdo->prepare($sql_filmography);
$stmt_filmo->execute(['actor_id' => $oyuncuId]);
$films = $stmt_filmo->fetchAll(PDO::FETCH_ASSOC);
?>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="panel-emira">
            <div class="d-flex align-items-center gap-4 mb-4">
                <div class="rounded-circle d-flex align-items-center justify-content-center" style="width: 80px; height: 80px; background: var(--bg-elevated); border: 2px solid var(--gold);">
                    <i class="bi bi-person-fill fs-1 text-warning"></i>
                </div>
                <div>
                    <h1 class="brand-title mb-1"><?= htmlspecialchars($actor['full_name']) ?></h1>
                    <p class="text-secondary mb-0"><i class="bi bi-calendar3 me-1"></i><?= htmlspecialchars($actor['birth_date'] ?? '—') ?></p>
                </div>
            </div>

            <h5 class="fw-bold mb-2">Biyografi</h5>
            <p class="text-secondary mb-4" style="line-height: 1.8;"><?= nl2br(htmlspecialchars($actor['biography'] ?? 'Biyografi bulunmuyor.')) ?></p>

            <h5 class="fw-bold mb-3">Filmografisi</h5>
            <?php if (empty($films)): ?>
                <p class="text-secondary">Kayıtlı film bulunamadı.</p>
            <?php else: ?>
                <div class="list-group list-group-flush">
                    <?php foreach ($films as $film): ?>
                        <a href="film_detay.php?filmId=<?= $film['id'] ?>" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" style="background: var(--bg-elevated); border-color: var(--border); color: var(--text);">
                            <span><strong><?= htmlspecialchars($film['title']) ?></strong> — <?= htmlspecialchars($film['role_name']) ?></span>
                            <span class="badge-year px-2 py-1"><?= $film['release_year'] ?></span>
                        </a>
                    <?php endforeach; ?>
                </div>
            <?php endif; ?>

            <div class="mt-4">
                <a href="index.php" class="btn btn-outline-gold"><i class="bi bi-arrow-left me-1"></i> Geri</a>
            </div>
        </div>
    </div>
</div>

</div>
</body>
</html>
