CREATE TABLE authors
(
    id       INT                NOT NULL AUTO_INCREMENT,
    username VARCHAR(20) UNIQUE,
    email    VARCHAR(80) UNIQUE NOT NULL,
    PRIMARY KEY (id)
);

SELECT *
FROM authors;

SELECT id, email
FROM authors;

SELECT id, email, `username`, "double quoted", 'single quoted'
FROM authors;

SELECT 1;
SELECT 'hello';

SELECT 1, 'hello';

SELECT 'OTUS';

SELECT *
FROM authors
WHERE username = 'sam';

SELECT *
FROM authors
WHERE username = 'nick';


SELECT *
FROM authors
WHERE username IS NOT NULL;

SELECT *
FROM authors
WHERE username IS NULL;


SELECT *
FROM authors
WHERE email like '%@example.com';

SELECT *
FROM authors
WHERE authors.email like '%@yahoo.com';

SELECT *
FROM authors
WHERE authors.email like '%@yandex.com';


SELECT *, authors.email
FROM authors;

SELECT *
FROM authors
LIMIT 3;

SELECT *
FROM authors
LIMIT 3 OFFSET 2;

SELECT *
FROM authors
LIMIT 3 OFFSET 4;

SELECT *
FROM authors
ORDER BY id;

SELECT *
FROM authors
ORDER BY id ASC;

SELECT *
FROM authors
ORDER BY id DESC;

SELECT *
FROM authors
ORDER BY username;

SELECT *
FROM authors
ORDER BY username DESC;

SELECT *
FROM authors
ORDER BY username DESC
LIMIT 3;

SELECT *
FROM authors
WHERE username IS NOT NULL
ORDER BY username DESC
LIMIT 3 OFFSET 2;


SELECT *
FROM authors;


INSERT INTO authors (username, email)
VALUES ('ann', 'ann@yandex.ru');

INSERT INTO authors (email)
VALUES ('bob@yandex.ru');


-- RELATIONS

-- body MEDIUMTEXT

CREATE TABLE articles
(
    id        INT          NOT NULL AUTO_INCREMENT,
    title     VARCHAR(200) NOT NULL,
    body      TEXT         NOT NULL DEFAULT '',
    author_id INT          NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (author_id) REFERENCES blog_app.authors (id)
        -- ON DELETE CASCADE
);

INSERT INTO articles (title, author_id)
VALUES ('SQL Lesson', 2);

INSERT INTO articles (title, author_id)
VALUES ('SQL JOINs Lesson', 5),
       ('SQL CTEs Lesson', 5);


SELECT *
FROM articles;

SELECT articles.id, title, author_id
FROM articles;

SELECT ar.id AS "Article ID", title, a.username, a.email, a.id AS "Author ID"
FROM articles ar
         JOIN blog_app.authors a on a.id = ar.author_id;

SELECT ar.id AS "Article ID",
       title,
       a.username,
       a.email,
       a.id  AS "Author ID"
FROM articles ar
         JOIN blog_app.authors a on a.id = ar.author_id;


SELECT ar.id AS "Article ID"
     , title
     , a.username
     , a.email
FROM articles ar
         JOIN blog_app.authors a on a.id = ar.author_id;


SELECT a.id AS "Author ID"
     , a.username
     , a.email
     , ar.title
     , ar.id AS "Article ID"
FROM authors a
JOIN articles ar on a.id = ar.author_id;


SELECT *
FROM authors;

UPDATE authors
SET username = 'nick'
WHERE email = 'nick@example.com';

UPDATE authors
SET username = 'bob'
WHERE id = 7;


DELETE FROM authors
WHERE username = 'jack';

DELETE FROM authors
WHERE username IS NULL;


DELETE FROM authors
WHERE username = 'james';
