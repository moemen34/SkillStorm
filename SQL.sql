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

SELECT DISTINCT order_customer_id FROM orders

SELECT customer_id, customer_fname, customer_lname--, order_customer_id
FROM (SELECT customer_id, customer_fname, customer_lname FROM customers) AS T
	LEFT OUTER JOIN 
	(SELECT DISTINCT order_customer_id FROM orders) as R ON T.customer_id = R.order_customer_id
WHERE R.order_customer_id IS NULL
ORDER BY customer_id ASC


SELECT count(DISTINCT order_customer_id) FROM orders

SELECT count(customer_id) FROM customers
