CREATE DATABASE IF NOT EXISTS SalesDataWalmart;-- put in notes

CREATE TABLE IF NOT EXISTS sale(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY, 
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL, -- # of digits then number of decimal places
    quantity INT NOT NULL,
    VAT FLOAT(6,4) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment_method VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12,4) NOT NULL,
    rating FLOAT(2,1)
    );
    
-- -----------------------------------------------------------------------------
-- ---------------- FEATURE ENGINEERING ----------------------------------------

-- TIME OF DAY
SELECT
time
FROM sale;

SELECT
time,
(CASE WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
      WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
      ELSE "Evening"
END) AS time_of_date
FROM sale;   

ALTER TABLE sale
ADD COLUMN time_of_day VARCHAR(20); 

UPDATE sale
SET time_of_day = (CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
		WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
		ELSE "Evening"END)
;

-- day_name
-- ------------------
SELECT 
date,
dayname(date) AS day_name
FROM sale;

ALTER TABLE sale
ADD COLUMN day_name VARCHAR(10);

UPDATE sale
SET day_name = dayname(date);


-- month_name
SELECT 
date,
monthname(date)
FROM sale;

ALTER TABLE sale
ADD COLUMN month_name VARCHAR(10);

UPDATE sale
SET month_name = monthname(date);

-- ---------------------------------------------------------
-- --------------EDA----------------------------------------

-- How many unique cities does the data have? 3
SELECT
DISTINCT(city)
FROM sale;

-- In which city is each branch?
SELECT
DISTINCT branch, city -- bit like all combinations between the two
FROM sale;


-- How many unique product lines does the data have?
SELECT 
COUNT(DISTINCT product_line)
FROM sale;

-- What is the most common payment method?
SELECT 
payment_method, COUNT(payment_method)
FROM sale
GROUP BY payment_method
ORDER BY 2 DESC;

-- What id the top selling product line by count?
SELECT 
product_line, COUNT(product_line)
FROM sale
GROUP BY product_line
ORDER BY 2 DESC;

-- What is the total revenue by month?
SELECT month_name, sum(total)
FROM sale
GROUP BY month_name
ORDER BY 2 DESC;

-- What month had the largest cogs?
SELECT month_name, sum(cogs)
FROM sale
GROUP BY month_name
ORDER BY 2 DESC;

-- Which product line had the largest revenue?
SELECT product_line, sum(total)
FROM sale
GROUP BY product_line
ORDER BY 2 DESC;

-- Which city has the largest revenue?
SELECT city, branch, sum(total)
FROM sale
GROUP BY city, branch
ORDER BY 2 DESC;

-- Which product line has the largest VAT?
SELECT product_line, avg(VAT)
FROM sale
GROUP BY product_line
ORDER BY 2 DESC;

-- Fetch each product line and add a column to those product line showing "Good","Bad". Good if its greater than average sales

-- Which brand sold more products than average product sold?
SELECT branch, sum(quantity)
FROM sale
GROUP BY branch
HAVING sum(quantity) > avg(quantity);

-- What is the most common product line by gender?
SELECT gender, product_line, COUNT(gender)
FROM sale
GROUP BY gender, product_line
ORDER BY gender, COUNT(gender) DESC; -- ORDER OF TWO GROUPS MATTERS

-- What is the average rating of each product line?
SELECT product_line, ROUND(avg(rating),2)
FROM sale	
GROUP BY product_line;

-- ----------------------------------------------------
-- ----------------------------------------------------

-- Number of sales made in each time of the day per weekday
SELECT day_name, time_of_day, count(time_of_day)
FROM sale
GROUP BY day_name, time_of_day
ORDER BY day_name, 3 DESC;

-- Which of the customer types brings in the most revenue
SELECT customer_type, sum(total)
FROM sale
GROUP BY customer_type
ORDER BY 2 DESC;

-- Which city has the largest tax percent?
SELECT city, avg(VAT)
FROM sale 
GROUP BY city
ORDER BY 2 DESC;

-- Which customer types pays the most in VAT?
SELECT customer_type, avg(VAT)
FROM sale 
GROUP BY customer_type
ORDER BY 2 DESC;

-- How many unique customer types does the data have?
SELECT DISTINCT customer_type
FROM sale;

-- How many unique payment methods does the data have?
SELECT DISTINCT payment_method
FROM sale;

-- What is the most common customer type?
SELECT customer_type,count(customer_type)
FROM sale
GROUP BY customer_type
ORDER BY 2 DESC;

-- Which Customer type buys the most?
SELECT customer_type, sum(total)
FROM sale
GROUP BY customer_type
ORDER BY 2 DESC;
 
 -- What is the gender of most of the customers?
 SELECT gender, count(gender)
FROM sale
GROUP BY gender
ORDER BY 2 DESC;

-- What is the gender distribution of each branch?
SELECT branch,gender, count(gender)
FROM sale
GROUP BY branch, gender
ORDER BY branch;

-- What times of the day do customers give most ratings?
SELECT time_of_day, avg(rating)
FROM sale
GROUP BY time_of_day
ORDER BY 2 DESC;

-- Which time of the day do customers give the most ratings per branch?
SELECT time_of_day, branch, avg(rating)
FROM sale
GROUP BY time_of_day, branch
ORDER BY 2 ASC, 3 DESC;

-- Which day of the week has the best average ratings?
SELECT day_name, avg(rating)
FROM sale
GROUP BY day_name
ORDER BY 2 DESC;

-- Whick day of the week has the best average rating per branch?
SELECT day_name,branch, avg(rating)
FROM sale
GROUP BY day_name,branch
ORDER BY 2 ASC,3 DESC;






        
