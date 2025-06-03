SELECT *
FROM amazonsalesdata;

CREATE TABLE amazon_sales
LIKE amazonsalesdata;

INSERT amazon_sales
SELECT *
FROM amazonsalesdata;

-- Removing duplicates

SELECT `Order ID`, COUNT(*) as count
FROM amazon_sales
GROUP BY `Order ID`
HAVING COUNT(*) > 1;

SELECT *, COUNT(*) AS count
FROM amazon_sales
GROUP BY 
  `Region`, `Country`, `Item Type`, `Sales Channel`, `Order Priority`,
  `Order Date`, `Order ID`, `Ship Date`, `Units Sold`, 
  `Unit Price`, `Unit Cost`, `Total Revenue`, `Total Cost`, `Total Profit`
HAVING COUNT(*) > 1;

-- It looks like we have no duplicates

-- table information
DESCRIBE amazon_sales;

SELECT *
FROM amazon_sales;

--  Statistics
SELECT
	COUNT(*) AS total_rows,
    MIN(`Units Sold`) AS min_units_sold,
    MAX(`Units Sold`) AS max_units_sold,
    AVG(`Units Sold`) AS avg_unts_sold,
    MIN(`Total Revenue`) AS min_total_revenue,
    MAX(`Total Revenue`) AS max_total_revenue,
    AVG(`Total Revenue`) AS avg_total_revenue,
    MIN(`Total Profit`) AS min_total_profit,
    MAX(`Total Profit`) AS max_total_profit,
    AVG(`Total Profit`) AS avg_total_profit
FROM amazon_sales;

-- MOST COMON REGIONS
SELECT `Region`, COUNT(*) AS count
FROM amazon_sales
GROUP BY `Region`
ORDER BY count DESC;

-- AVERAGE PROFIT PER REGION 
SELECT `Region`, AVG(`Total Profit`) AS AvgProfit
FROM amazon_sales
GROUP BY `Region`
ORDER BY AvgProfit DESC;

-- SALES CHANNEL DISTRIBUTION
SELECT `Sales Channel`, COUNT(*) AS count
FROM amazon_sales
GROUP BY `Sales Channel`
ORDER BY count DESC;

-- MOST SOLD ITEMS
SELECT `Item Type`, COUNT(*) AS count
FROM amazon_sales
GROUP BY `Item Type`
ORDER BY count DESC;

-- ORDER PRIORIY DISTRIBUTION
SELECT `Order Priority`, COUNT(*) AS count
FROM amazon_sales
GROUP BY `Order Priority`
ORDER BY count DESC;

-- REVENUE AND PROFIT BY DISTRIBUTION
UPDATE amazon_sales
SET `Total Revenue` =  ROUND(`Total Revenue`, 2);

UPDATE amazon_sales
SET `Total Profit` =  ROUND(`Total Profit`, 2);

SELECT `Region`,
	SUM(`Total Revenue`) AS total_revenue,
    SUM(`Total Profit`) AS total_profit
FROM amazon_sales
GROUP BY `Region`
ORDER BY 2 DESC;

-- REVENUE AND PROFIT BY ITEM SOLD
SELECT `Item Type`,
	SUM(`Total Revenue`) AS total_revenue,
    SUM(`Total Profit`) AS total_profit
FROM amazon_sales
GROUP BY `Item Type`
ORDER BY 3 DESC;

-- REVENUE AND PROFIT BY COUNTRY
SELECT `Country`,
	SUM(`Total Revenue`) AS total_revenue,
    SUM(`Total Profit`) AS total_profit
FROM amazon_sales
GROUP BY `Country`
ORDER BY total_revenue DESC;

-- REVENUE BY YEAR
SELECT YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS year_ordered,
	SUM(`Total Revenue`) AS revenue_year
FROM amazon_sales
GROUP BY year_ordered
ORDER BY 1 DESC;

-- ORDERS WITH HIGH PROFIT
SELECT *
FROM amazon_sales
WHERE `Total Profit` > 1000000
ORDER BY `Total Profit` DESC;




--

