CREATE DATABASE IF NOT EXISTS docker_database;

USE docker_database;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL
);
INSERT INTO users (username) VALUES ('John');
