<?php

function createDatabase($dbname, $loginData)
{
// 创建连接
    $conn = new mysqli($loginData['servername'], $loginData['username'], $loginData['password']);
// 检测连接
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
// 创建数据库
    $sql = "CREATE DATABASE $dbname";
    if ($conn->query($sql) === TRUE) {
        echo "DB created!";
    } else {
        echo "Error creating database: " . $conn->error;
    }
    $conn->close();
}

$loginData = [
    'servername' => '127.0.0.1',
    'username' => 'root',
    'password' => 'root',
];

createDatabase("`default-typo3`", $loginData);

/*
//Insert into DB
$stmt_ins = $conn->prepare("
                INSERT INTO tx_etsocnewsst_domain_model_news
                (pid, platform, title, description, post_time, feed_url, media_type, media_path, media_thumb_path, like_count, comment_count, tstamp, crdate)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                ");
var_dump($stmt_ins);die('xxx');
$stmt_ins->bind_param("s", $dbname);
$stmt_ins->execute();

$stmt_ins = $conn->prepare("
                INSERT INTO tx_etsocnewsst_domain_model_news
                (pid, platform, title, description, post_time, feed_url, media_type, media_path, media_thumb_path, like_count, comment_count, tstamp, crdate)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                ");
$stmt_ins->bind_param("issssssssiiss", $pid, $platform, $title, $description, $post_time, $feed_url, $media_type, $media_path, $media_thumb_path, $like_count, $comment_count, $tstamp, $crdate);

// set parameters and execute
$pid = 0;
$platform = $news->platform;
$title = $news->title;
$description = $news->description;
$post_time = $news->post_time;
$feed_url = $news->feedurl;
$media_type = $news->mediatype;
$media_path = $news->mediapath;
$media_thumb_path = $news->mediathumbpath;
$like_count = $news->like_count;
$comment_count = $news->comment_count;
$tstamp = $now_time;
$crdate = $now_time;

$stmt_ins->execute();

//close
$stmt_ins->close();
$conn->close();
*/
