-- Exercise 1

CREATE DATABASE assignmenets;

CREATE TABLE courses (
	course_id INT PRIMARY KEY IDENTITY,
	course_name VARCHAR(60),
	course_author VARCHAR(40),
	course_status VARCHAR(9) CHECK (course_status in ('published', 'draft', 'inactive')),
	course_published_dt DATE
);

SELECT * FROM courses;

-- Exercise 2

INSERT INTO courses
	(course_name, course_author, course_status, course_published_dt)
VALUES
	('Programming using Python', 'Bob Dillon', 'published', '2020-09-30'),
	('Data Engineering using Python', 'Bob Dillon', 'published', '2020-07-15'),
	('Data Engineering using Scala', 'Elvis Presley', 'draft', NULL),
	('Programming using Scala', 'Elvis Presley', 'published', '2020-05-12'),
	('Programming using Java', 'Mike Jack', 'inactive', '2020-08-10'),
	('Web Applications - Python Flask', 'Bob Dillon', 'inactive', '2020-07-20'),
	('Web Applications - Java Spring', 'Mike Jack', 'draft', NULL), 	
	('Pipeline Orchestration - Python', 'Bob Dillon', 'draft', NULL),
	('Streaming Pipelines - Python', 'Bob Dillon', 'published', '2020-10-05'),
	('Web Applications - Scala Play', 'Elvis Presley', 'inactive', '2020-09-30'),
	('Web Applications - Python Django', 'Bob Dillon', 'published', '2020-06-23'),
	('Server Automation - Ansible', 'Uncle Sam', 'published', '2020-07-05');


-- Exercise 3

UPDATE courses 
	SET course_status = 'published', course_published_dt = CURRENT_TIMESTAMP
	WHERE course_name LIKE '%Python%' OR course_name LIKE '%Scala%';


-- Exerise 4

DELETE FROM courses
	WHERE course_status != 'draft' AND course_status != 'published';



--____________________________________E03______________________________________
Use retail_db;

--BULK INSERT dbo.categories FROM 'C:\Users\moeme\OneDrive\Desktop\Training\Python\cloned\20240617-DE-TS-LectureMaterials\SQL\Data\retail_db\data\categories.csv' WITH (FORMAT='CSV', ROWTERMINATOR = '0x0a', FIRSTROW=2);
--BULK INSERT dbo.customers FROM 'C:\Users\moeme\OneDrive\Desktop\Training\Python\cloned\20240617-DE-TS-LectureMaterials\SQL\Data\retail_db\data\customers.csv' WITH (FORMAT='CSV', ROWTERMINATOR = '0x0a', FIRSTROW=2) ;
--BULK INSERT dbo.departments FROM 'C:\Users\moeme\OneDrive\Desktop\Training\Python\cloned\20240617-DE-TS-LectureMaterials\SQL\Data\retail_db\data\departments.csv' WITH (FORMAT='CSV', ROWTERMINATOR = '0x0a', FIRSTROW=2) ;
--BULK INSERT dbo.order_items FROM 'C:\Users\moeme\OneDrive\Desktop\Training\Python\cloned\20240617-DE-TS-LectureMaterials\SQL\Data\retail_db\data\order_items.csv' WITH (FORMAT='CSV', ROWTERMINATOR = '0x0a', FIRSTROW=2) ;
--BULK INSERT dbo.orders FROM 'C:\Users\moeme\OneDrive\Desktop\Training\Python\cloned\20240617-DE-TS-LectureMaterials\SQL\Data\retail_db\data\orders.csv' WITH (FORMAT='CSV', ROWTERMINATOR = '0x0a', FIRSTROW=2) ;
--BULK INSERT dbo.products FROM 'C:\Users\moeme\OneDrive\Desktop\Training\Python\cloned\20240617-DE-TS-LectureMaterials\SQL\Data\retail_db\data\products.csv' WITH (FORMAT='CSV', ROWTERMINATOR = '0x0a', FIRSTROW=2) ;

-- Exercise 1

WITH temp_table as (
	SELECT order_customer_id, count(order_id) as customer_order_count
	FROM orders
	WHERE YEAR(order_date) = 2014 AND MONTH(order_date) = 1
	GROUP BY order_customer_id
)

--SELECT * FROM temp_table;

SELECT customer_id, customer_fname, customer_lname, customer_order_count
FROM customers JOIN temp_table ON customers.customer_id = temp_table.order_customer_id
ORDER BY customer_order_count DESC, customer_id ASC

-- Exercise 2

SELECT customer_id, customer_fname, customer_lname--, order_customer_id
FROM (SELECT customer_id, customer_fname, customer_lname FROM customers) AS T
	LEFT OUTER JOIN 
	(SELECT DISTINCT order_customer_id FROM orders) as R ON T.customer_id = R.order_customer_id
WHERE R.order_customer_id IS NULL
ORDER BY customer_id ASC

-- to check
SELECT count(DISTINCT order_customer_id) FROM orders;

SELECT count(customer_id) FROM customers;

-- Exercise 3

-- orders in jan 2014 that are complete or closed
WITH T AS (
	SELECT order_id, order_customer_id
	FROM orders
	WHERE YEAR(order_date) = 2014 AND MONTH(order_date) = 1
		AND order_status IN ('COMPLETE', 'CLOSED')
), 
-- getting order_items info (customer, items, items subtotal)
Q AS(
	SELECT order_id, order_customer_id, order_item_id, order_item_subtotal--*  14,666
	FROM T JOIN order_items O 
	ON T.order_id = O.order_item_order_id
),
-- summing the revenue per customer
W AS (
	SELECT order_customer_id [Customer_ID], SUM(order_item_subtotal) [Revenue]
	FROM Q
	GROUP BY (order_customer_id)
)
-- selcting all required info
SELECT c.customer_id, c.customer_fname, c.customer_lname, ISNULL(W.Revenue, 0)
FROM W RIGHT JOIN customers c ON W.Customer_ID = c.customer_id
ORDER BY W.Revenue DESC, c.customer_id ASC;


-- Exercise 4

-- item subtotal and product ID
WITH X AS(
	SELECT order_item_subtotal, order_item_product_id
	FROM orders JOIN order_items
		ON order_item_order_id = order_id
	WHERE YEAR(order_date) = 2014 AND MONTH(order_date) = 1
		AND order_status IN ('COMPLETE', 'CLOSED')
), 
-- get category and sum the subtotals per category
Y AS (
	SELECT product_category_id [categoryID], SUM(order_item_subtotal)[Revenue]
	FROM X JOIN products
	ON x.order_item_product_id = products.product_id
	GROUP BY (product_category_id)
)
-- get the rest of categories info 
SELECT category_id, category_department_id, category_name, ISNULL(Revenue, 0) [Category_Revenue]
FROM Y RIGHT JOIN categories
	on y.categoryID = categories.category_id
ORDER BY category_id;


-- Exercise 5

Select department_id, department_name, ISNULL(Product_count, 0) [Product_count]
FROM departments LEFT JOIN (
	SELECT c.category_department_id, COUNT(product_id)[Product_count]
	FROM categories c JOIN products p
		ON c.category_id = p.product_category_id
	GROUP BY /*c.category_id,*/ c.category_department_id) AS R
	ON department_id = R.category_department_id



--_________________________________E04_________________________________

USE retail_db;

SELECT MAX(department_id) FROM departments;
SELECT MAX(category_id) FROM categories;
SELECT MAX(product_id) FROM products;
SELECT MAX(customer_id) FROM customers;
SELECT MAX(order_id) FROM orders;
SELECT MAX(order_item_id) FROM order_items;



/*
CREATE SEQUENCE departments_Id_Seq
    START WITH 7
    INCREMENT BY 1;
*/

SELECT order_customer_id, customer_id
FROM orders LEFT JOIN customers
		ON order_customer_id = customer_id

SELECT COUNT(1) from orders

SELECT order_items.order_item_order_id, orders.order_id
FROM order_items LEFT JOIN orders
		ON order_item_order_id = order_id

SELECT COUNT(1) from order_items

SELECT order_items.order_item_product_id, products.product_id
FROM order_items LEFT JOIN products
		ON order_item_product_id = product_id

SELECT COUNT(1) from order_items

-- this has NULL values
SELECT products.product_category_id, categories.category_id
FROM products LEFT JOIN categories
		ON products.product_category_id = categories.category_id

SELECT * FROM products

/*BEGIN TRANSACTION foreign_key_violation;

	UPDATE products
	SET products.product_category_id = categories.category_id
	FROM products LEFT JOIN categories
			ON products.product_category_id = categories.category_id
	WHERE categories.category_id IS NULL
	
*/




-- this also has NULL values
SELECT categories.category_department_id, departments.department_id
FROM categories LEFT JOIN departments
		ON categories.category_department_id = departments.department_id



--__________________________________E06___________________________________________

-- Ex 1

SELECT YEAR(created_ts) [created_year], COUNT(user_id) [user_count]
FROM users
GROUP BY YEAR(created_ts)
ORDER BY created_year ASC;


-- Ex 2
SELECT user_id, user_dob, user_email_id, DATENAME(dw, user_dob) user_day_of_birth 
FROM users
WHERE Month(user_dob) = 5
ORDER BY DAY(user_dob)


-- EX 3
SELECT user_id, CONCAT(user_first_name, ' ', user_last_name) [user_name], user_email_id, created_ts, YEAR(created_ts) created_year
FROM users
WHERE YEAR(created_ts) = 2019
ORDER BY [user_name]


-- EX 4
SELECT CASE
        WHEN user_gender = 'F' THEN 'Female'
        WHEN user_gender = 'M' THEN 'Male'
        WHEN user_gender = 'N' THEN 'Non-Binary'
        WHEN user_gender IS NULL THEN 'NOT Specified'
    END AS user_gender,
    COUNT(*) AS user_count
FROM users
GROUP BY 
    CASE
        WHEN user_gender = 'F' THEN 'Female'
        WHEN user_gender = 'M' THEN 'Male'
        WHEN user_gender = 'N' THEN 'Non-Binary'
        WHEN user_gender IS NULL THEN 'NOT Specified'
    END
ORDER BY 
    user_count DESC;


-- EX 5 

SELECT user_id, user_unique_id, IIF(LEN(REPLACE(user_unique_id, '-', '')) >= 9, 
									RIGHT(REPLACE(user_unique_id, '-', ''), 4),
									IIF(user_unique_id IS NULL, 'Not Specified', 'Invalid Unique Id')) [user_unique_id_last4]
FROM users
ORDER BY user_id


-- EX 6 
WITH T AS(
	SELECT user_id, CASE 
				WHEN CHARINDEX('+', user_phone_no) = 1 
					THEN CAST(SUBSTRING(user_phone_no, 2, CHARINDEX(' ', user_phone_no) - 1) AS INTEGER)
			END AS country_code
	FROM users
)
SELECT country_code, COUNT(user_id) user_count
FROM T
WHERE country_code IS NOT NULL
GROUP BY (country_code)
ORDER BY country_code;


-- Ex 7
USE retail_db;

SELECT COUNT(1) [count]
FROM order_items
WHERE ROUND(order_item_subtotal, 2) != ROUND(order_item_quantity * order_item_product_price, 2);


-- EX 8
WITH T AS(
	SELECT DATENAME(dw, order_date) week_day, CASE
        WHEN DATENAME(dw, order_date) = 'Monday' THEN 'Week days'
        WHEN DATENAME(dw, order_date) = 'Tuesday' THEN 'Week days'
        WHEN DATENAME(dw, order_date) = 'Wednesday' THEN 'Week days'
		WHEN DATENAME(dw, order_date) = 'Thursday' THEN 'Week days'
        WHEN DATENAME(dw, order_date) = 'Friday' THEN 'Week days'
        WHEN DATENAME(dw, order_date) = 'Saturday' THEN 'Weekend days'
		WHEN DATENAME(dw, order_date) = 'Sunday' THEN 'Weekend days'
    END AS day_type
	FROM orders
	WHERE YEAR(order_date) = 2014 AND MONTH(order_date) = 1
)

SELECT day_type, Count(day_type)
FROM T
GROUP BY day_type









--__________________________________E08________________________________________

USE hr_db;

-- Exercise 1
With T AS (
	SELECT
		employee_id,
		department_id,
		salary,
		CAST(AVG(salary) OVER (PARTITION BY department_id) as DECIMAL(18,2)) AS avg_dept_salary
	FROM employees
)

SELECT T.department_id, employee_id, department_name, salary, ROUND(avg_dept_salary, 2) avg_salary_expense
FROM T JOIN departments ON T.department_id = departments.department_id
WHERE salary > avg_dept_salary
ORDER BY T.department_id ASC, salary DESC;


-- Execrcise 2
SELECT
	employee_id,
	department_name,
	salary,
	CAST(SUM(salary) OVER (
		PARTITION BY employees.department_id
			ORDER BY department_name ASC, salary ASC
			ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) AS DECIMAL(18,2)) AS cum_salary_expense
FROM employees JOIN departments 
	ON employees.department_id = departments.department_id
WHERE department_name IN ('FINANCE', 'IT')
ORDER BY department_name ASC, salary ASC


-- Exercise 3
WITH T AS(
SELECT employee_id, e.department_id, department_name, salary,
	DENSE_RANK() OVER(
		PARTITION BY e.department_id
		ORDER BY salary DESC
	)[employee_rank]
FROM employees e JOIN departments d
	ON e.department_id = d.department_id
)

SELECT * FROM T WHERE employee_rank < 4
ORDER BY department_id ASC, salary DESC;

-- Exercise 4

USE retail_db;

WITH T as (
	SELECT order_id, order_item_product_id, order_item_subtotal,
		CAST(SUM(order_item_subtotal) OVER(PARTITION BY order_item_product_id) AS DECIMAL(18,2)) as Revenue
	FROM orders o JOIN order_items on order_id = order_item_order_id
	WHERE order_status IN ('COMPLETE', 'CLOSED')
		AND YEAR(order_date) = 2014 AND MONTH(order_date) = 1
),

R AS(
SELECT DISTINCT order_item_product_id as product_id, product_name, Revenue,
	DENSE_RANK() OVER (/*PARTITION BY order_item_product_id*/ -- NO NEED TO PARTITION
					ORDER BY Revenue DESC) [RANK]
FROM T JOIN products ON order_item_product_id = product_id
)

SELECT * FROM R
WHERE RANK<4;


-- Exercise 5
WITH T as (
	SELECT order_id, order_item_product_id, order_item_subtotal,
		CAST(SUM(order_item_subtotal) OVER(PARTITION BY order_item_product_id) AS DECIMAL(18,2)) as Revenue
	FROM orders o JOIN order_items on order_id = order_item_order_id
	WHERE order_status IN ('COMPLETE', 'CLOSED')
		AND YEAR(order_date) = 2014 AND MONTH(order_date) = 1
),

R AS(
SELECT DISTINCT product_category_id,order_item_product_id as product_id, product_name, Revenue,
	DENSE_RANK() OVER (PARTITION BY product_category_id 
					ORDER BY Revenue DESC) [RANK]
FROM T JOIN products ON order_item_product_id = product_id
)

SELECT product_category_id, category_name ,product_id as product_id, product_name, Revenue, RANK
FROM R JOIN categories ON product_category_id = category_id
WHERE category_name IN ('Cardio Equipment', 'Strength Training')
	AND RANK<4
ORDER BY category_id ASC, Revenue DESC; 