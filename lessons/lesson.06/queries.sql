SELECT *
FROM movies;

SELECT *
FROM genres;

SELECT *
FROM movies
WHERE genre_id = 5;


SELECT *
FROM movies m
JOIN genres g on m.genre_id = g.genre_id;

SELECT m.movie_title, m.director, m.year, g.genre_title
FROM movies m
JOIN genres g USING (genre_id);

SELECT m.movie_title, m.director, m.year, g.genre_title
FROM movies m
INNER JOIN genres g USING (genre_id);


SELECT m.movie_title, m.director, m.year, g.genre_title
FROM movies m
INNER JOIN genres g USING (genre_id)
WHERE g.genre_title = 'Drama' OR g.genre_title = 'Sci-Fi';

--

SELECT p.productCode AS code
     , p.productName AS name
     , p.MSRP
     , pl.productLine AS "Product Line"
     , pl.textDescription AS description
FROM products p
    JOIN productlines pl USING (productLine);

--

SELECT *
FROM orderdetails
WHERE orderNumber = '10100';

SELECT o.orderNumber
     , o.orderDate
     , c.customerName
     , od.orderLineNumber
     , p.productName
     , od.quantityOrdered
     , od.priceEach
     , od.quantityOrdered * od.priceEach AS total_sum_line
FROM orders o
    INNER JOIN orderdetails od USING (orderNumber)
    -- JOIN products p on p.productCode = od.productCode
    INNER JOIN products p USING (productCode)
    INNER JOIN customers c USING (customerNumber)
ORDER BY o.orderNumber, od.orderLineNumber;


SELECT od.orderNumber
     , od.productCode
     , p.productName
     , p.MSRP
     , od.priceEach
FROM products p
    INNER JOIN orderdetails od
        ON p.productCode = od.productCode
            AND p.MSRP > od.priceEach
WHERE p.productCode = 'S10_1678';



--

SELECT o.orderNumber
     , o.status
     , SUM(od.quantityOrdered * od.priceEach) AS order_total
     , o.comments
FROM orders o
    JOIN orderdetails od on o.orderNumber = od.orderNumber
GROUP BY o.orderNumber;


--

SELECT m.name, d.name
FROM meals m
    CROSS JOIN drinks d;



SELECT m.name
     , m.weight
     , d.name
     , d.volume
     , (m.weight + d.volume) AS total_weight

FROM meals m
    CROSS JOIN drinks d

ORDER BY total_weight;
-- ORDER BY total_weight ASC;
-- ORDER BY total_weight DESC;


SELECT m.name
     , m.weight
     , d.name
     , d.volume
     , (m.weight + d.volume) AS total_weight

FROM meals m
    CROSS JOIN drinks d
WHERE m.weight > 300
    AND d.volume > 200
ORDER BY m.name DESC, d.name DESC;


--

SELECT *
FROM movies m
LEFT JOIN genres g on m.genre_id = g.genre_id;


SELECT *
FROM customers;

SELECT c.customerNumber
     , c.customerName
     , o.orderNumber
     , o.status
FROM customers c
-- LEFT JOIN orders o USING (customerNumber);
LEFT JOIN orders o on c.customerNumber = o.customerNumber;
--                             LEFT TABLE         RIGHT TABLE

-- LEFT JOIN orders o on o.customerNumber = c.customerNumber;
--                        RIGHT TABLE        LEFT TABLE

SELECT c.customerNumber
     , c.customerName
--     , o.orderNumber
--     , o.status
FROM customers c
LEFT JOIN orders o USING (customerNumber)
WHERE o.orderNumber IS NULL;


SELECT c.customerNumber
     , c.customerName
     , o.orderNumber
     , o.status
FROM customers c
LEFT JOIN orders o USING (customerNumber)
WHERE orderNumber IS NOT NULL;


SELECT e.employeeNumber, c.customerName
FROM customers c
    RIGHT JOIN employees e
        on c.salesRepEmployeeNumber = e.employeeNumber
ORDER BY e.employeeNumber;


SELECT e.employeeNumber
     , e.firstName
     , c.customerName
     , c.salesRepEmployeeNumber
FROM customers c
    LEFT JOIN employees e
        on c.salesRepEmployeeNumber = e.employeeNumber
ORDER BY e.employeeNumber;


SELECT e.employeeNumber, c.customerName
FROM customers c
    RIGHT JOIN employees e
        on c.salesRepEmployeeNumber = e.employeeNumber
WHERE c.customerNumber IS NULL
ORDER BY e.employeeNumber;


SELECT m.movie_title AS title, g.genre_title as genre
FROM movies m
RIGHT OUTER JOIN genres g on m.genre_id = g.genre_id;

--

SELECT firstName, lastName
FROM employees;

SELECT contactFirstName, contactLastName
FROM customers;


SELECT firstName as name, lastName as surname, 'employee' as category
FROM employees
UNION
SELECT contactFirstName, contactLastName, 'customer'
FROM customers;


SELECT firstName as name, lastName as surname, 'employee' as category
FROM employees
UNION
SELECT contactFirstName, contactLastName, 'customer'
FROM customers
ORDER BY name;

--

SELECT firstName, lastName, c.customerNumber, c.customerName, e.officeCode
FROM employees e
JOIN customers c
    on e.firstName = c.contactFirstName
           AND e.lastName = c.contactLastName;


--
SELECT o.orderNumber
     , o.status
     , SUM(od.quantityOrdered * od.priceEach) AS order_total
     , o.comments
FROM orders o
    JOIN orderdetails od on o.orderNumber = od.orderNumber
GROUP BY o.orderNumber
HAVING order_total < 10000;


SELECT o.orderNumber
     , o.status
     , SUM(od.quantityOrdered * od.priceEach) AS order_total
     , o.comments
FROM orders o
    JOIN orderdetails od on o.orderNumber = od.orderNumber
WHERE o.status = 'Shipped'
GROUP BY o.orderNumber
HAVING order_total < 10000;

--

EXPLAIN
SELECT *
FROM movies
WHERE movie_id > 10;


EXPLAIN
SELECT *
FROM movies
HAVING movie_id > 10;
