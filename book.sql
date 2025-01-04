
CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    subject VARCHAR(255) NOT NULL
);


INSERT INTO books (title, author, subject) VALUES
('To Kill a Mockingbird', 'Harper Lee', 'Fiction'),
('1984', 'George Orwell', 'Science Fiction'),
('Pride and Prejudice', 'Jane Austen', 'Romance'),
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction'),
('The Catcher in the Rye', 'J.D. Salinger', 'Coming-of-age Fiction');
ALTER TABLE books ADD imageUrl VARCHAR(255);

UPDATE books
SET imageUrl = 'https://covers.openlibrary.org/b/id/8226091-L.jpg'
WHERE title = 'To Kill a Mockingbird';

UPDATE books
SET imageUrl = 'https://covers.openlibrary.org/b/id/7222246-L.jpg'
WHERE title = '1984';

UPDATE books
SET imageUrl = 'https://covers.openlibrary.org/b/id/8235071-L.jpg'
WHERE title = 'Pride and Prejudice';

UPDATE books
SET imageUrl = 'https://covers.openlibrary.org/b/id/7222256-L.jpg'
WHERE title = 'The Great Gatsby';

UPDATE books
SET imageUrl = 'https://covers.openlibrary.org/b/id/7222262-L.jpg'
WHERE title = 'The Catcher in the Rye';
