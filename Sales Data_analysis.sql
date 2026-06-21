CREATE DATABASE flipkart_analysis;
USE flipkart_analysis;

CREATE TABLE sales (
    product_id INT,
    product_name VARCHAR(255),
    category VARCHAR(100),
    actual_price DECIMAL(10,2),
    discounted_price DECIMAL(10,2),
    discount_percentage INT,
    rating DECIMAL(3,1),
    rating_count INT
);
USE flipkart_analysis;

INSERT INTO sales VALUES
(1,'Samsung Galaxy M32 5G','Electronics',18999,14999,21,4.3,12500),
(2,'Apple iPhone 13','Electronics',79900,72999,9,4.7,8900),
(3,'OnePlus Nord CE 3','Electronics',24999,19999,20,4.4,6700),
(4,'Redmi Note 12 Pro','Electronics',22999,17999,22,4.2,15600),
(5,'boAt Rockerz 450','Electronics',2999,1499,50,4.1,45000),
(6,'Sony WH-1000XM4','Electronics',29990,22990,23,4.6,3200),
(7,'Titan Analog Watch','Watches',3500,2799,20,4.3,8900),
(8,'Fastrack Casual Watch','Watches',2500,1799,28,4.0,12000),
(9,'Casio Digital Watch','Watches',1500,1199,20,4.2,25000),
(10,'Nike Running Shoes','Footwear',5999,3999,33,4.4,7800),
(11,'Adidas Ultraboost','Footwear',12999,9999,23,4.5,4500),
(12,'Puma Sports Shoes','Footwear',4999,2999,40,4.1,9800),
(13,'Levi Mens Jeans','Clothing',2999,1799,40,4.3,23000),
(14,'Allen Solly Shirt','Clothing',1999,1299,35,4.2,18000),
(15,'Van Heusen Formal Shirt','Clothing',2499,1599,36,4.4,14000),
(16,'HP Laptop 15s','Computers',55000,45999,16,4.2,5600),
(17,'Dell Inspiron 15','Computers',62000,52999,15,4.3,4200),
(18,'LG 32 inch Smart TV','Home Appliances',35000,27999,20,4.3,6700),
(19,'Samsung 1.5 Ton AC','Home Appliances',45000,34999,22,4.4,4500),
(20,'Philips Air Fryer','Home Appliances',8999,5999,33,4.5,12000),
(21,'Milton Water Bottle','Kitchen',599,399,33,4.4,45000),
(22,'Prestige Pressure Cooker','Kitchen',2499,1799,28,4.3,28000),
(23,'Lakme Face Serum','Beauty',899,599,33,4.2,28000),
(24,'Mamaearth Vitamin C Cream','Beauty',499,349,30,4.4,42000),
(25,'Wildcraft Backpack','Bags',2999,1999,33,4.3,14000);

USE flipkart_analysis;
SELECT category,
       COUNT(*) AS total_products,
       AVG(actual_price) AS avg_price,
       SUM(actual_price) AS total_revenue
FROM sales
GROUP BY category
ORDER BY total_revenue DESC;

USE flipkart_analysis;
SELECT product_name, category, rating, rating_count
FROM sales
ORDER BY rating DESC, rating_count DESC
LIMIT 10;

USE flipkart_analysis;
SELECT product_name, category,
       actual_price, discounted_price,
       discount_percentage
FROM sales
ORDER BY discount_percentage DESC
LIMIT 10;

USE flipkart_analysis;
SELECT product_name, category,
       rating_count AS total_reviews,
       rating
FROM sales
ORDER BY rating_count DESC
LIMIT 10;

USE flipkart_analysis;
SELECT category,
       AVG(rating) AS avg_rating,
       COUNT(*) AS total_products,
       SUM(rating_count) AS total_reviews
FROM sales
GROUP BY category
ORDER BY avg_rating DESC;

USE flipkart_analysis;
SELECT category,
       AVG(actual_price - discounted_price) AS avg_discount_amount,
       AVG(discounted_price) AS avg_final_price
FROM sales
GROUP BY category
ORDER BY avg_discount_amount DESC;

