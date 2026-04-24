<?php
    require_once "dbconnect.php";

    // header("Content-Type: application/json; charset=utf-8");

    //$query = "SELECT title, year, platform, age_rec FROM videogames";

    /* ============= INSERT, DELETE, UPDATE ============= */
    // * Note: do not allow users to manually input the condition as a raw string. Probably best to use dropdowns to build condition.

    // helper for insert/update -- get column names for a table, return as an array
    function get_columns($conn, string $table): array {
        $stmt = $conn->prepare("DESCRIBE $table");
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_COLUMN);
    }

    // insert record to a table given an array of values
    // example usage: insert_record($conn, "users", ["new_user", 20, "Horror"]);
    function insert_record($conn, string $table, array $values) {
        // do we prompt user to input values for different table columns?

        $columns = get_columns($conn, $table); // array of column names for the table

        // convert list to comma-separated string --> "column1, column2, ..."
        $column_str = implode(", ", $columns);
        // builds a string like this --> "?, ?, ..." (? will be replaced by values in arg)
        $values_str = implode(", ", array_fill(0, count($columns), "?"));

        $query = "INSERT INTO $table ($column_str) VALUES ($values_str)";
        try {
            $stmt = $conn->prepare($query);
            $stmt->execute($values); // make sure values line up with the appropriate columns!!
            echo "Record inserted in " . $table;
        } catch (PDOException $e) {
            echo "Error: " . $e->getMessage();
        }
    }

    // delete record in a table given conditions
    // example usage: delete_record($conn, "videogames", "platform = 'Nintendo Switch' AND NOT company = 'Nintendo'");
    function delete_record($conn, string $table, string $condition = "") {
        if (empty(trim($condition))) { # if empty condition, exclude WHERE clause from query
            $query = "DELETE FROM $table";
        } else {
            $query = "DELETE FROM $table WHERE $condition";
        }

        try {
            $conn->exec($query);
            echo "Entry deleted from " . $table;
        } catch (PDOException $e) {
            echo "Error: " . $e->getMessage();
        }
    }
    
    // update attributes of a table
    // example usage: update_record($conn, "videogames", ["Minecraft", 2009, "PC", 13, Mojang Studios], "title = 'Minecraft'");
    function update_record($conn, string $table, array $values, string $condition = "") {
        $columns = get_columns($conn, $table); // array of column names for the table

        // replace each element in array with "column = ?" --> ["column1 = ?", "column2 = ?", ...]
        $set_array = array_map(fn($c) => "$c = ?", $columns);
        // convert array to string --> "column1 = ?, column2 = ?, ..."
        $set_str = implode(", ", $set_array);

        if (empty(trim($condition))) {
            $query = "UPDATE $table SET $set_str";
        } else {
            $query = "UPDATE $table SET $set_str WHERE $condition";
        }

        try {
            $stmt = $conn->prepare($query);
            $stmt->execute($values); // fill '?' with values from arg array
            echo "Record updated in " . $table;
        } catch (PDOException $e) {
            echo "Error: " . $e->getMessage();
        }
    }

    /* ============= JOINING MULTIPLE TABLES ============= */
    
    // fetch all games produced by a given company
    function all_company_games($conn, string $companyname) {
        $query = "SELECT * FROM videogames JOIN company ON videogames.company = company.name WHERE company.name = ?"; // fetch entire tuple
        $rows = [];

        try {
            $stmt = $conn->prepare($query);
            $stmt->execute([$companyname]);
            $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo "Fetched games developed by " . $companyname;
        } catch (PDOException $e) {
            echo "Error: " . $e->getMessage();
        }

        return $rows;
    }

    // fetch all reviews under a given game
    function all_game_reviews($conn, string $gametitle) {
        $query = "SELECT * FROM review JOIN videogames ON review.gametitle = videogames.title WHERE videogames.title = ?";
        $rows = [];

        try {
            $stmt = $conn->prepare($query);
            $stmt->execute([$gametitle]);
            $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo "Fetched reviews for " . $gametitle;
        } catch (PDOException $e) {
            echo "Error: " . $e->getMessage();
        }

        return $rows;
    }

    // fetch all reviews left by a given user
    function all_user_reviews($conn, string $username) {
        $query = "SELECT * FROM review JOIN users ON review.username = users.username WHERE users.username = ?";
        $rows = [];

        try {
            $stmt = $conn->prepare($query);
            $stmt->execute([$username]);
            $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo "Fetched reviews by " . $username;
        } catch (PDOException $e) {
            echo "Error: " . $e->getMessage();
        }

        return $rows;
    }

    /* ============= AGGREGATE QUERIES ============= */

    // total number of game ratings for a given game
    function num_game_ratings($conn, string $gameName) {
        //$query = "SELECT COUNT(*) FROM review WHERE gamename = $gameName";
        $query = "SELECT COUNT(*) FROM review WHERE gamename = ?";
        $rows = [];

        try {
            $stmt = $conn->prepare($query);
            $stmt->execute([$gameName]);
            $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Error: " . $e->getMessage();
        }
        return $rows; // return empty rows array if error occurs
    }

    // average rating for a given game
    function average_rating($conn, string $gameName) {
        $query = "SELECT AVG(rating) FROM review WHERE gamename = ?";
        $rows = [];
        
        try{
            $stmt = $conn->prepare($query);
            $stmt->execute([$gameName]);
            $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Error: " . $e->getMessage();
        }

        return $rows;
    }

    // total number of games owned by a given user
    function num_games_owned($conn, string $username) {
        $query = "SELECT COUNT(*) FROM plays WHERE username = ?";
        $rows = [];
        
        try {
            $stmt = $conn->prepare($query);
            $stmt->execute([$username]);
            $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Error: " . $e->getMessage();
        }

        return $rows;
    }

    /* ============= ADVANCED FUNCTION (MINI QUIZ) ============= */
    function assign_game_quiz() {
        // ask questions about user's interest, genre, age, personality
        // build arbitrary query conditions based on their answers
    }

    // stuff from original example
    try {
        // $stmt = $conn->query($query);
        // $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        // print_r($rows);
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
