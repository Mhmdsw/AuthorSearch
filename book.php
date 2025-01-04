<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

ini_set('display_errors', 1);
error_reporting(E_ALL);


$servername = "sql202.infinityfree.com";
$username = "if0_37748325";
$password = "muCteyeDpl"; 
$dbname = "if0_37748325_book";


$conn = new mysqli($servername, $username, $password, $dbname);


if ($conn->connect_error) {
    die(json_encode(['error' => 'Connection failed: ' . $conn->connect_error]));
}


if (isset($_GET['query']) && !empty($_GET['query'])) {
    $query = $_GET['query'];

    $sql = "SELECT title, author, subject, imageUrl FROM books WHERE author LIKE ? OR subject LIKE ?";
    $stmt = $conn->prepare($sql);
    $searchTerm = "%$query%";
    $stmt->bind_param("ss", $searchTerm, $searchTerm);
    $stmt->execute();
    $result = $stmt->get_result();

    $books = [];
    while ($row = $result->fetch_assoc()) {
        $books[] = [
            'title' => $row['title'],
            'author' => $row['author'],
            'subject' => $row['subject'],
            'imageUrl' => $row['imageUrl'], 
        ];
    }

    echo json_encode($books);
} else {
    
    $sql = "SELECT title, author, subject, imageUrl FROM books LIMIT 10";
    $result = $conn->query($sql);

    $books = [];
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $books[] = [
                'title' => $row['title'],
                'author' => $row['author'],
                'subject' => $row['subject'],
                'imageUrl' => $row['imageUrl'], 
            ];
        }
        echo json_encode($books);
    } else {
        echo json_encode(['message' => 'No books found in the database.']);
    }
}

$conn->close();


