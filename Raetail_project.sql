-- Retail project 
-- 1. I want to find the product category in high demand accross Gender based on the total amount of product sales
-- I used JOIN function to join two tables including retail_transactions and retail_customers.
SELECT c.Gender, t.prod_category, SUM(total_amt) 'SUM of total amount'
FROM project_retail.retail_customers c
INNER JOIN project_retail.retail_transactions t
ON c.customer_ID = t.cust_id
GROUP BY 2
ORDER BY 3 desc;

-- 2 I want to find the store types with the highest profit based on product sub category code
-- I used the SUM function to find the total amount of sales and added GROUP BY and ORDER BY 
SELECT store_type, prod_subcategory, SUM(prod_subcat_code) 'Total amount of sales by prod subcat code' 
FROM project_retail.retail_transactions
GROUP BY 1
ORDER BY 2 desc;

-- 3 I want to find out the date of the maximum sales, how many sales occured on that date and the total amount of sales made.
-- I used the sub query below using the COUNT function to count the number of sales and MAX to find the maximum sales made on the date 
SELECT tran_date, COUNT(transaction_id), SUM(total_amt) 'Total Amount of sales'
FROM project_retail.retail_transactions 
WHERE tran_date IN (
SELECT tran_date FROM project_retail.retail_transactions 
WHERE total_amt = (
SELECT MAX(total_amt) FROM project_retail.retail_transactions
));

-- 4 I want to find the Average amount spent by each customer per year
SELECT transaction_id, cust_id, total_amt, AVG(total_amt)
FROM project_retail.retail_transactions
GROUP BY cust_id
ORDER BY 4 desc ;

-- 5 Count the number of customers per year to determine the business profit or loss.
-- the function COUNT allowed me to count the number of customers per year
SELECT year(tran_date), cust_id, count( cust_id)'Customers Numbers', SUM(total_amt) 'Total amount'
FROM christelle.retail
GROUP BY YEAR(tran_date)
ORDER BY 3 desc;

-- 6 Find the total amount of sales of Teleshop and e-shop using WHERE and IN
SELECT store_type, SUM(total_amt) 
FROM project_retail.retail_transactions 
WHERE store_type IN ('Teleshop', 'e-shop')
GROUP BY 1 
ORDER BY 2 desc;

-- 7. I want to find which product category that has been sold or returned by looking at the quantity and the total amount of sales
-- using CASE WHEN 
SELECT prod_category, prod_subcategory, qty, tran_date, SUM(total_amt) 'Total amount',
CASE 
WHEN qty IN (1,2,3) THEN 'Product sold'
WHEN qty IN (4,5) THEN 'Product sold'
ELSE 'Product returned'
END AS 'Returned/Sold'
FROM project_retail.retail_transactions
GROUP BY 3
ORDER BY 5 desc;
