<?php
require 'db_connect.php';

if (isset($_POST['add_movie'])) {
    $poster_image = null;
    if (isset($_FILES['poster']) && $_FILES['poster']['error'] === 0) {
        $poster_image = file_get_contents($_FILES['poster']['tmp_name']);
    }

    $sql = 'INSERT INTO movies (title, release_year, genre_id, director_id, summary, poster_image)
            VALUES (:title, :release_year, :genre_id, :director_id, :summary, :poster_image)';
    $stmt = $pdo->prepare($sql);
    $stmt->execute([
        'title' => $_POST['title'],
        'release_year' => $_POST['release_year'],
        'genre_id' => $_POST['genre_id'] ?: null,
        'director_id' => $_POST['director_id'] ?: null,
        'summary' => $_POST['summary'],
        'poster_image' => $poster_image,
    ]);
    header('Location: index.php');
    exit();
}

if (isset($_POST['update_movie'])) {
    $filmId = (int) $_POST['film_id'];
    $params = [
        'title' => $_POST['title'],
        'release_year' => $_POST['release_year'],
        'genre_id' => $_POST['genre_id'] ?: null,
        'director_id' => $_POST['director_id'] ?: null,
        'summary' => $_POST['summary'],
        'film_id' => $filmId,
    ];

    if (isset($_FILES['poster']) && $_FILES['poster']['error'] === 0) {
        $sql = 'UPDATE movies SET title=:title, release_year=:release_year, genre_id=:genre_id,
                director_id=:director_id, summary=:summary, poster_image=:poster_image WHERE id=:film_id';
        $params['poster_image'] = file_get_contents($_FILES['poster']['tmp_name']);
    } else {
        $sql = 'UPDATE movies SET title=:title, release_year=:release_year, genre_id=:genre_id,
                director_id=:director_id, summary=:summary WHERE id=:film_id';
    }

    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    header('Location: film_detay.php?filmId=' . $filmId);
    exit();
}

if (isset($_GET['sil']) && isset($_GET['filmId'])) {
    $filmId = (int) $_GET['filmId'];
    $stmt = $pdo->prepare('DELETE FROM movies WHERE id = :id');
    $stmt->execute(['id' => $filmId]);
    header('Location: index.php');
    exit();
}

header('Location: index.php');
exit();
