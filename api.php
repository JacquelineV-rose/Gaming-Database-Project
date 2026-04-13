<?php
require_once "dbconnect.php";

// header("Content-Type: application/json; charset=utf-8");

$query = "SELECT title, year, platform, age_rec FROM videogames";

try {
    $stmt = $conn->query($query);
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    // // print_r($rows);
    // echo $row

    echo json_encode([
        "ok" => true,
        "games" => $rows
    ]);
} catch (PDOException $e) {
    echo json_encode([
        "ok" => false,
        "error" => $e->getMessage()
    ]);
}

$conn = null;
?>
