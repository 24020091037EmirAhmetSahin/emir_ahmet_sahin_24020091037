<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= $pageTitle ?? 'EmiraSinema' ?> | Emira</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/emira-cine.css">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-emira mb-4">
    <div class="container">
        <a class="navbar-brand" href="index.php"><i class="bi bi-camera-reels-fill me-2"></i>EmiraSinema</a>
        <div class="navbar-nav ms-auto align-items-center gap-2">
            <a class="nav-link <?= ($activePage ?? '') === 'home' ? 'active' : '' ?>" href="index.php">Vitrin</a>
            <a class="nav-link <?= ($activePage ?? '') === 'add' ? 'active' : '' ?>" href="film_ekle.php">Film Ekle</a>
        </div>
    </div>
</nav>
<div class="container pb-4">
