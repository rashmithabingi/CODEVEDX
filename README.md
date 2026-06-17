\# CODEVEDX Internship - Data Analysis With SQL



\## Project 1 - Sales Data Analysis Using SQL

\- Tool: MySQL Workbench 8.0

\- Dataset: Flipkart Products Dataset

\- Categories: Electronics, Clothing, Footwear, Computers, etc.

\- Queries: Revenue Analysis, Top Products, Discount Analysis



\## Intern: Rashmitha

\## Organization: CodeVedX









USE flipkart\_analysis;



\-- Query 1: Revenue by Category

SELECT category,

&#x20;      COUNT(\*) AS total\_products,

&#x20;      AVG(actual\_price) AS avg\_price,

&#x20;      SUM(actual\_price) AS total\_revenue

FROM sales

GROUP BY category

ORDER BY total\_revenue DESC;







USE flipkart\_analysis;



SELECT product\_name, category, rating, rating\_count

FROM sales

ORDER BY rating DESC, rating\_count DESC

LIMIT 10;









USE flipkart\_analysis;



SELECT product\_name, category,

&#x20;      actual\_price, discounted\_price,

&#x20;      discount\_percentage

FROM sales

ORDER BY discount\_percentage DESC

LIMIT 10;





USE flipkart\_analysis;



SELECT product\_name, category,

&#x20;      rating\_count AS total\_reviews,

&#x20;      rating

FROM sales

ORDER BY rating\_count DESC

LIMIT 10;





USE flipkart\_analysis;



SELECT category,

&#x20;      AVG(rating) AS avg\_rating,

&#x20;      COUNT(\*) AS total\_products,

&#x20;      SUM(rating\_count) AS total\_reviews

FROM sales

GROUP BY category

ORDER BY avg\_rating DESC;





USE flipkart\_analysis;



SELECT category,

&#x20;      AVG(actual\_price - discounted\_price) AS avg\_discount\_amount,

&#x20;      AVG(discounted\_price) AS avg\_final\_price

FROM sales

GROUP BY category

ORDER BY avg\_discount\_amount DESC;





