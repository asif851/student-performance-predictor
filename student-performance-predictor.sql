CREATE DATABASE IF NOT EXISTS student_performance;
USE student_performance;

CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    hours_studied FLOAT,
    attendance INT,
    passed TINYINT
);

INSERT INTO students (hours_studied, attendance, passed) VALUES
(1,45,0),(1.5,60,0),(2,55,0),(2.5,50,0),(3,65,0),(3,80,0),(3.5,70,0),
(4,60,0),(4,75,1),(5,70,1),(5.5,80,1),(6,85,1),(6.5,75,1),(7,90,1),
(7.5,88,1),(8,92,1),(8.5,95,1),(9,85,1),(9.5,98,1),(2,40,0);


SELECT * FROM students;

TRUNCATE TABLE students;

-- prediction
SELECT s.*, p.predicted_pass
FROM students s
JOIN student_predictions p ON s.id = p.id;

-- Find all wrong predictions with SQL

SELECT s.*, p.predicted_pass
FROM students s
JOIN student_predictions p ON s.id = p.id
WHERE s.passed <> p.predicted_pass;