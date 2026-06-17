CREATE DATABASE hr_analytics;
USE hr_analytics;

CREATE TABLE employees (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(50),
  age INT,
  gender VARCHAR(10),
  department VARCHAR(50),
  job_role VARCHAR(50),
  years_at_company INT
);

CREATE TABLE salary (
  emp_id INT,
  basic_salary INT,
  bonus INT,
  total_salary INT,
  FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

CREATE TABLE performance (
  emp_id INT,
  rating INT,
  projects_completed INT,
  training_hours INT,
  FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

CREATE TABLE attrition (
  emp_id INT,
  left_company VARCHAR(5),
  reason VARCHAR(100),
  FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

USE hr_analytics;

INSERT INTO employees VALUES
(1, 'Rahul Sharma', 28, 'Male', 'Development', 'Software Engineer', 2),
(2, 'Priya Nair', 32, 'Female', 'Development', 'Senior Engineer', 5),
(3, 'Amit Verma', 35, 'Male', 'Management', 'Team Lead', 8),
(4, 'Sneha Rao', 26, 'Female', 'Testing', 'QA Tester', 1),
(5, 'Karan Mehta', 30, 'Male', 'Development', 'Software Engineer', 3),
(6, 'Divya Pillai', 29, 'Female', 'HR', 'HR Executive', 4),
(7, 'Rohit Das', 33, 'Male', 'Testing', 'QA Tester', 6),
(8, 'Anjali Singh', 27, 'Female', 'Development', 'Software Engineer', 2),
(9, 'Vikram Joshi', 40, 'Male', 'Management', 'Manager', 12),
(10, 'Pooja Iyer', 31, 'Female', 'Sales', 'Sales Executive', 4),
(11, 'Arjun Nair', 25, 'Male', 'Development', 'Software Engineer', 1),
(12, 'Meena Gupta', 34, 'Female', 'HR', 'HR Executive', 7),
(13, 'Suresh Kumar', 38, 'Male', 'Management', 'Team Lead', 10),
(14, 'Kavitha Reddy', 29, 'Female', 'Testing', 'QA Tester', 3),
(15, 'Nikhil Bose', 27, 'Male', 'Development', 'Software Engineer', 2),
(16, 'Ritu Sharma', 36, 'Female', 'Sales', 'Sales Executive', 6),
(17, 'Deepak Menon', 31, 'Male', 'Development', 'Senior Engineer', 5),
(18, 'Swathi Patel', 28, 'Female', 'Testing', 'QA Tester', 2),
(19, 'Manoj Tiwari', 45, 'Male', 'Management', 'Manager', 15),
(20, 'Lakshmi Nair', 30, 'Female', 'Development', 'Software Engineer', 3);


USE hr_analytics;

INSERT INTO salary VALUES
(1, 45000, 5000, 50000),
(2, 65000, 8000, 73000),
(3, 80000, 12000, 92000),
(4, 35000, 3000, 38000),
(5, 48000, 5000, 53000),
(6, 42000, 4000, 46000),
(7, 38000, 3500, 41500),
(8, 46000, 5000, 51000),
(9, 95000, 20000, 115000),
(10, 40000, 4000, 44000),
(11, 43000, 4500, 47500),
(12, 44000, 4000, 48000),
(13, 82000, 13000, 95000),
(14, 36000, 3000, 39000),
(15, 45000, 5000, 50000),
(16, 41000, 4000, 45000),
(17, 67000, 9000, 76000),
(18, 37000, 3000, 40000),
(19, 98000, 22000, 120000),
(20, 46000, 5000, 51000);

INSERT INTO performance VALUES
(1, 4, 6, 20),
(2, 5, 10, 35),
(3, 4, 12, 40),
(4, 3, 4, 15),
(5, 4, 7, 22),
(6, 3, 5, 18),
(7, 3, 5, 16),
(8, 5, 8, 28),
(9, 5, 15, 50),
(10, 3, 4, 12),
(11, 2, 3, 10),
(12, 4, 6, 20),
(13, 5, 14, 45),
(14, 3, 4, 14),
(15, 4, 6, 19),
(16, 3, 5, 15),
(17, 4, 9, 30),
(18, 2, 3, 10),
(19, 5, 18, 55),
(20, 4, 7, 24);

INSERT INTO attrition VALUES
(1, 'No', 'Still Working'),
(2, 'No', 'Still Working'),
(3, 'No', 'Still Working'),
(4, 'Yes', 'Better Opportunity'),
(5, 'No', 'Still Working'),
(6, 'Yes', 'Personal Reasons'),
(7, 'Yes', 'Better Opportunity'),
(8, 'No', 'Still Working'),
(9, 'No', 'Still Working'),
(10, 'Yes', 'Low Salary'),
(11, 'No', 'Still Working'),
(12, 'No', 'Still Working'),
(13, 'No', 'Still Working'),
(14, 'Yes', 'Better Opportunity'),
(15, 'No', 'Still Working'),
(16, 'Yes', 'Low Salary'),
(17, 'No', 'Still Working'),
(18, 'Yes', 'Personal Reasons'),
(19, 'No', 'Still Working'),
(20, 'No', 'Still Working');

USE hr_analytics;

-- Query 1: Total employees in each department
SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY department;

-- Query 2: Average salary by department
SELECT e.department, AVG(s.total_salary) AS avg_salary
FROM employees e
JOIN salary s ON e.emp_id = s.emp_id
GROUP BY e.department;

-- Query 3: Who left the company?
SELECT e.emp_name, e.department, a.reason
FROM employees e
JOIN attrition a ON e.emp_id = a.emp_id
WHERE a.left_company = 'Yes';
-- Query 4: Top performers (rating 5)
SELECT e.emp_name, e.department, p.rating, p.projects_completed
FROM employees e
JOIN performance p ON e.emp_id = p.emp_id
WHERE p.rating = 5
ORDER BY p.projects_completed DESC;

-- Query 5: Department with highest attrition
SELECT e.department, COUNT(*) AS employees_left
FROM employees e
JOIN attrition a ON e.emp_id = a.emp_id
WHERE a.left_company = 'Yes'
GROUP BY e.department
ORDER BY employees_left DESC;

-- Query 6: Average age by department
SELECT department, AVG(age) AS avg_age
FROM employees
GROUP BY department;

-- Query 7: Highest paid employees
SELECT e.emp_name, e.job_role, s.total_salary
FROM employees e
JOIN salary s ON e.emp_id = s.emp_id
ORDER BY s.total_salary DESC
LIMIT 5;

-- Query 8: Gender distribution
SELECT gender, COUNT(*) AS total
FROM employees
GROUP BY gender;