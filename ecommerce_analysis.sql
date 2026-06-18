USE amazone_store;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS delivery;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name   VARCHAR(100),
    email       VARCHAR(100),
    city        VARCHAR(50),
    country     VARCHAR(50),
    joined_date DATE
);

CREATE TABLE products (
    product_id   INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category     VARCHAR(50),
    brand        VARCHAR(50),
    price        DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id    INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id  INT,
    quantity    INT,
    order_date  DATE,
    status      VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id)  REFERENCES products(product_id)
);

CREATE TABLE delivery (
    delivery_id     INT PRIMARY KEY AUTO_INCREMENT,
    order_id        INT,
    expected_date   DATE,
    actual_date     DATE,
    delivery_status VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


-- Insert Customers
INSERT INTO customers VALUES
(1,'John Smith','john@gmail.com','New York','USA','2023-01-15'),
(2,'Emma Wilson','emma@gmail.com','London','UK','2023-02-20'),
(3,'Liam Brown','liam@gmail.com','Toronto','Canada','2023-03-10'),
(4,'Sofia Miller','sofia@gmail.com','Berlin','Germany','2023-04-05'),
(5,'Noah Davis','noah@gmail.com','Sydney','Australia','2023-05-18'),
(6,'Olivia Taylor','olivia@gmail.com','Chicago','USA','2023-06-22'),
(7,'James Anderson','james@gmail.com','Manchester','UK','2023-07-30'),
(8,'Ava Thomas','ava@gmail.com','Vancouver','Canada','2023-08-14'),
(9,'Lucas Martin','lucas@gmail.com','Munich','Germany','2023-09-09'),
(10,'Mia White','mia@gmail.com','Melbourne','Australia','2023-10-25');

-- Insert Products
INSERT INTO products VALUES
(1,'iPhone 15','Electronics','Apple',999.99),
(2,'Samsung Galaxy S24','Electronics','Samsung',849.99),
(3,'MacBook Pro','Electronics','Apple',1999.99),
(4,'Dell XPS Laptop','Electronics','Dell',1499.99),
(5,'Sony WH-1000XM5','Electronics','Sony',349.99),
(6,'iPad Air','Electronics','Apple',749.99),
(7,'Apple Watch Series 9','Electronics','Apple',499.99),
(8,'Logitech MX Master 3','Electronics','Logitech',99.99),
(9,'Samsung 4K Monitor','Electronics','Samsung',599.99),
(10,'Anker PowerBank','Electronics','Anker',59.99);

-- Insert Orders
INSERT INTO orders VALUES
(1,1,1,1,'2024-01-05','Delivered'),
(2,2,3,1,'2024-01-10','Delivered'),
(3,3,5,2,'2024-01-15','Delivered'),
(4,4,2,1,'2024-01-20','Cancelled'),
(5,5,7,1,'2024-02-01','Delivered'),
(6,6,4,1,'2024-02-05','Delivered'),
(7,7,6,1,'2024-02-14','Pending'),
(8,8,8,3,'2024-02-20','Delivered'),
(9,9,9,1,'2024-03-01','Delivered'),
(10,10,10,2,'2024-03-05','Cancelled'),
(11,1,2,1,'2024-03-10','Delivered'),
(12,2,7,1,'2024-03-15','Delivered'),
(13,3,4,1,'2024-03-20','Delivered'),
(14,4,1,2,'2024-04-01','Delivered'),
(15,5,3,1,'2024-04-10','Cancelled'),
(16,6,5,1,'2024-04-15','Delivered'),
(17,7,9,2,'2024-04-20','Delivered'),
(18,8,6,1,'2024-05-01','Delivered'),
(19,9,2,1,'2024-05-10','Pending'),
(20,10,8,2,'2024-05-15','Delivered'),
(21,1,9,1,'2024-05-20','Delivered'),
(22,2,10,3,'2024-06-01','Delivered'),
(23,3,1,1,'2024-06-10','Delivered'),
(24,4,6,1,'2024-06-15','Cancelled'),
(25,5,4,1,'2024-06-20','Delivered');

-- Insert Delivery
INSERT INTO delivery VALUES
(1,1,'2024-01-08','2024-01-07','On Time'),
(2,2,'2024-01-14','2024-01-13','On Time'),
(3,3,'2024-01-19','2024-01-20','Delayed'),
(4,4,NULL,NULL,'Cancelled'),
(5,5,'2024-02-05','2024-02-04','On Time'),
(6,6,'2024-02-09','2024-02-10','Delayed'),
(7,7,NULL,NULL,'Pending'),
(8,8,'2024-02-24','2024-02-23','On Time'),
(9,9,'2024-03-05','2024-03-04','On Time'),
(10,10,NULL,NULL,'Cancelled'),
(11,11,'2024-03-14','2024-03-13','On Time'),
(12,12,'2024-03-19','2024-03-18','On Time'),
(13,13,'2024-03-24','2024-03-25','Delayed'),
(14,14,'2024-04-05','2024-04-04','On Time'),
(15,15,NULL,NULL,'Cancelled'),
(16,16,'2024-04-19','2024-04-18','On Time'),
(17,17,'2024-04-24','2024-04-23','On Time'),
(18,18,'2024-05-05','2024-05-04','On Time'),
(19,19,NULL,NULL,'Pending'),
(20,20,'2024-05-19','2024-05-18','On Time'),
(21,21,'2024-05-24','2024-05-23','On Time'),
(22,22,'2024-06-05','2024-06-04','On Time'),
(23,23,'2024-06-14','2024-06-13','On Time'),
(24,24,NULL,NULL,'Cancelled'),
(25,25,'2024-06-24','2024-06-23','On Time');

USE amazone_store;

-- KPI 1: Total Revenue
SELECT 
    SUM(p.price * o.quantity) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'Delivered';

-- KPI 2: Top Selling Products
SELECT 
    p.product_name,
    SUM(o.quantity) AS units_sold,
    SUM(p.price * o.quantity) AS revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY p.product_name
ORDER BY revenue DESC;

-- KPI 3: Cancellation Rate
SELECT 
    COUNT(*) AS total_orders,
    SUM(CASE WHEN status='Cancelled' THEN 1 ELSE 0 END) AS cancelled,
    ROUND(SUM(CASE WHEN status='Cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
    AS cancellation_rate_percent
FROM orders;

-- KPI 4: Average Order Value
SELECT 
    ROUND(SUM(p.price * o.quantity) / COUNT(o.order_id), 2) AS avg_order_value
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'Delivered';

-- KPI 5: Best Customer
SELECT 
    c.full_name,
    c.country,
    COUNT(o.order_id) AS total_orders,
    SUM(p.price * o.quantity) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY c.full_name, c.country
ORDER BY total_spent DESC
LIMIT 5;

-- KPI 6: Delivery Performance
SELECT 
    delivery_status,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM delivery), 2) AS percentage
FROM delivery
GROUP BY delivery_status;

-- KPI 7: Monthly Sales Trend
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(order_id) AS total_orders,
    SUM(p.price * o.quantity) AS monthly_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY month
ORDER BY month;
