-- Database: sql_project_1_retailSalesAnalysis

-- DROP DATABASE IF EXISTS "sql_project_1_retailSalesAnalysis";


--create table retail_sales
CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);


-- DATA CLEANING 

SELECT *
FROM retail_sales
LIMIT 1;

SELECT COUNT(*)
FROM retail_sales;

SELECT* FROM retail_sales
WHERE transactions_id IS NULL;

SELECT* FROM retail_sales
WHERE sale_date IS NULL;

SELECT* FROM retail_sales
WHERE sale_date IS NULL;

-- check null in a single query
SELECT* FROM retail_sales
WHERE(
			transactions_id IS NULL
			OR
			sale_date IS NULL
			OR
			sale_time IS NULL
			OR
			gender IS NULL
			OR
			category IS NULL
			OR
			quantity IS NULL
			OR
			cogs IS NULL
			OR
			total_sale IS NULL
	)

DELETE FROM retail_sales 
WHERE(
			transactions_id IS NULL
			OR
			sale_date IS NULL
			OR
			sale_time IS NULL
			OR
			gender IS NULL
			OR
			category IS NULL
			OR
			quantity IS NULL
			OR
			cogs IS NULL
			OR
			total_sale IS NULL
	)

	

-- DATA EXPLORATION

-- how many number of sales do we have 
SELECT COUNT(*) FROM retail_sales AS total_sales
 
-- how many number of customers do we have 
SELECT COUNT(customer_id) FROM retail_sales AS total_customers

-- how many number of unique customers do we have 
SELECT COUNT(DISTINCT customer_id) FROM retail_sales AS total_customers

-- how many number of unique categories do we have 
SELECT COUNT(DISTINCT category) AS total_categories FROM retail_sales

-- what are the distinct categories we have 
SELECT DISTINCT category FROM retail_sales 




-- DATA ANALYSIS & BUSINESS KEY PROBLEMS AND ANSWERS 

--Q1: Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT* FROM retail_sales 
WHERE sale_date = '2022-11-05';

--Q2: Write a SQL query to retrieve all transactions where the category is 'Clothing' 
--		and the quantity sold is more than 4 in the month of Nov-2022: 
SELECT* FROM retail_sales
WHERE 
	(
	category = 'Clothing'
	AND
	quantity>=4
	AND
	sale_date BETWEEN '2022-11-01' AND '2022-11-30'
	-- TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	)

--Q3: Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT
	category,
	SUM(total_sale) AS net_sale_by_category
FROM retail_sales
GROUP BY category
-- GROUP BY 1

--Q4: Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT
    --ROUND(AVG(age), 2) as avg_age
	AVG(age) as avg_age
FROM retail_sales
WHERE category = 'Beauty'

--Q5: Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT * FROM retail_sales
WHERE total_sale > 1000

--Q6: Write a SQL query to find the total number of transactions (transaction_id) 
--		made by each gender in each category.
SELECT
	category,
	gender,
	COUNT(transactions_id) AS total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY total_transactions DESC

--Q7: Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT* FROM
	(SELECT 
		EXTRACT(YEAR FROM sale_date) AS year,
		EXTRACT(MONTH FROM sale_date) AS month,
		AVG(total_sale) AS avg_sale,
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
	FROM retail_sales
	GROUP BY 1,2
	) AS t1
WHERE rank=1

--Q8: Write a SQL query to find the top 10 customers based on the highest total sales 
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10

--Q9: Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
	category,
	COUNT(DISTINCT customer_id) AS unq_customers_per_cateory
FROM retail_sales
GROUP BY 1

--Q10: Write a SQL query to create each shift and number of orders 
--		(Example Morning <12, Afternoon Between 12 & 17, Evening >17):
SELECT
	shift,
	COUNT(shift) as total_orders_shift
FROM
(
	SELECT *,
		CASE 
			WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'morning'
			WHEN EXTRACT(HOUR FROM sale_time)>17 THEN 'evening'
			ELSE 'afternoon'
		END AS shift
	FROM retail_sales
) AS t1
GROUP BY 1
ORDER BY 2




												---END OF PROJECT---











