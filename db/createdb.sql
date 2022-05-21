CREATE DATABASE books;

USE books;

CREATE TABLE books(
    id serial PRIMARY KEY, 
    title VARCHAR(100) UNIQUE NOT NULL,
    author VARCHAR(100) UNIQUE NOT NULL,
    read BOOLEAN NOT NULL
    );

INSERT INTO books(title, author, read) VALUES('On the Road', 'Jack Kerouac', TRUE);
INSERT INTO books(title, author, read) VALUES('Harry Potter and the Philosopher''s Stone', 'J. K. Rowling', FALSE);
INSERT INTO books(title, author, read) VALUES('Green Eggs and Hamm', 'Dr. Seuss', TRUE);