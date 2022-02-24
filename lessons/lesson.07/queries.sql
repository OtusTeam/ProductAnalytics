-- CTE: common table expression

SELECT *
FROM meals;

SELECT id, name
FROM meals;

WITH cte_meals AS (
    SELECT id, name
    FROM meals
)
SELECT *
FROM cte_meals;

WITH cte_meals AS (
    SELECT id, name AS meal
    FROM meals
)
SELECT id, meal
FROM cte_meals;


SELECT o.orderNumber
     , o.status
     , p.productName
     , od.quantityOrdered
     , od.priceEach
     , od.quantityOrdered * od.priceEach as item_total
     , o.comments
FROM orders o
    -- JOIN orderdetails od on o.orderNumber = od.orderNumber
    JOIN orderdetails od USING(orderNumber)
    JOIN products p USING(productCode)
;


SELECT o.orderNumber
     , o.status
     , SUM(od.quantityOrdered * od.priceEach) as order_total
     , o.comments
FROM orders o
    -- JOIN orderdetails od on o.orderNumber = od.orderNumber
    JOIN orderdetails od USING(orderNumber)
GROUP BY o.orderNumber;


WITH cte_orders_with_total AS (
    SELECT o.orderNumber
         , o.status
         , SUM(od.quantityOrdered * od.priceEach) as order_total
         , o.comments
    FROM orders o
        -- JOIN orderdetails od on o.orderNumber = od.orderNumber
        JOIN orderdetails od USING(orderNumber)
    GROUP BY o.orderNumber
    -- ORDER BY order_total DESC
    -- HAVING order_total > 10000
)
SELECT orderNumber, order_total
FROM cte_orders_with_total
WHERE order_total > 10000
ORDER BY order_total;


-- SELECT *
-- FROM cte_orders_with_total;

WITH cte_shipped_orders AS (
    SELECT o.orderNumber
         , o.status
         , SUM(od.quantityOrdered * od.priceEach) as order_total
         , o.comments AS comment
    FROM orders o
        JOIN orderdetails od USING(orderNumber)
    WHERE status = 'Shipped'
    GROUP BY o.orderNumber
),
    cte_details AS (
        SELECT d.orderNumber, d.quantityOrdered, d.priceEach, p.productName, p.MSRP
        FROM orderdetails d
        JOIN products p on p.productCode = d.productCode
        WHERE quantityOrdered > 30
    )
SELECT o.orderNumber, o.order_total, o.comment, d.quantityOrdered, d.productName, d.MSRP
FROM cte_shipped_orders o
    JOIN cte_details d ON o.orderNumber = d.orderNumber
    ORDER BY orderNumber
;


WITH cte_orders AS (
    SELECT o.orderNumber
         , o.status
         , SUM(od.quantityOrdered * od.priceEach) as order_total
         , o.comments AS comment
    FROM orders o
        JOIN orderdetails od USING(orderNumber)
    GROUP BY o.orderNumber
),
  cte_shipped_orders AS (
      SELECT *
      FROM cte_orders
      WHERE status = 'Shipped'
  )
SELECT o.orderNumber, o.order_total, o.status, o.comment
FROM cte_shipped_orders o
ORDER BY o.order_total;



-- INDEXES

EXPLAIN
SELECT *
FROM customers
WHERE customerNumber = 169;

EXPLAIN
SELECT *
FROM customers
WHERE contactLastName = 'Lee';


CREATE TABLE tbl (
    c1 INT PRIMARY KEY,
    c2 INT NOT NULL,
    c3 INT NOT NULL,
    c4 VARCHAR(10),
    INDEX (c2, c3)
);

CREATE INDEX idx_c4 ON tbl(c4);

--

EXPLAIN
SELECT orderNumber, orderDate, status
FROM orders
WHERE status <> 'Shipped'
ORDER BY orderDate;


EXPLAIN
SELECT orderNumber, orderDate, status
FROM orders
WHERE status NOT IN ('Shipped', 'Resolved');


CREATE INDEX ix_status ON orders(status);

DROP INDEX ix_status ON orders;

-- CREATE INDEX ix_tbl ON tbl(c1)
-- CREATE INDEX ix_tbl ON tbl(c1, c2)
-- CREATE INDEX ix_tbl ON tbl(c1, c2, c3)
CREATE INDEX ix_tbl ON tbl(c1, c2, c3, c4)



EXPLAIN
SELECT *
FROM customers
WHERE contactLastName = 'Lee';

EXPLAIN
SELECT customerNumber, contactFirstName, contactLastName
FROM customers;

EXPLAIN
SELECT customerNumber, contactFirstName, contactLastName
FROM customers
WHERE contactFirstName = 'Jean';

EXPLAIN
SELECT customerNumber, contactFirstName, contactLastName
FROM customers
WHERE contactFirstName = 'Jean' AND contactLastName = 'King';
-- WHERE contactLastName = 'King' AND contactFirstName = 'Jean';

EXPLAIN
SELECT customerNumber, contactFirstName, contactLastName
FROM customers
WHERE contactLastName = 'King';

EXPLAIN
SELECT customerNumber, contactFirstName, contactLastName
FROM customers
WHERE contactFirstName = 'Jean' OR contactLastName = 'King';


CREATE INDEX ix_fname_lname ON customers (contactFirstName, contactLastName);
CREATE INDEX ix_lname_fname ON customers (contactLastName, contactFirstName);
DROP INDEX ix_lname_fname ON customers;
