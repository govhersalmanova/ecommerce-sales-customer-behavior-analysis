-- E-commerce Sales & Customer Behavior Analysis
-- Table name assumed: ecommerce_sales

-- 1. Total revenue, profit, and average order value
SELECT
    ROUND(SUM(Net_Revenue_AZN), 2) AS total_revenue,
    ROUND(SUM(Profit_AZN), 2) AS total_profit,
    ROUND(AVG(Net_Revenue_AZN), 2) AS avg_order_value
FROM ecommerce_sales;

-- 2. Monthly revenue trend
SELECT
    STRFTIME('%Y-%m', Order_Date) AS month,
    ROUND(SUM(Net_Revenue_AZN), 2) AS monthly_revenue
FROM ecommerce_sales
GROUP BY month
ORDER BY month;

-- 3. Revenue by product category
SELECT
    Category,
    ROUND(SUM(Net_Revenue_AZN), 2) AS category_revenue,
    ROUND(SUM(Profit_AZN), 2) AS category_profit
FROM ecommerce_sales
GROUP BY Category
ORDER BY category_revenue DESC;

-- 4. Return rate by category
SELECT
    Category,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN Returned = 'Yes' THEN 1 ELSE 0 END) AS returned_orders,
    ROUND(
        100.0 * SUM(CASE WHEN Returned = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS return_rate_pct
FROM ecommerce_sales
GROUP BY Category
ORDER BY return_rate_pct DESC;

-- 5. Top cities by revenue
SELECT
    City,
    ROUND(SUM(Net_Revenue_AZN), 2) AS city_revenue
FROM ecommerce_sales
GROUP BY City
ORDER BY city_revenue DESC;

-- 6. Delivery performance and rating
SELECT
    Delivery_Days,
    ROUND(AVG(Rating), 2) AS avg_rating,
    COUNT(*) AS order_count
FROM ecommerce_sales
GROUP BY Delivery_Days
ORDER BY Delivery_Days;

-- 7. Most valuable customers
SELECT
    Customer_ID,
    COUNT(*) AS order_count,
    ROUND(SUM(Net_Revenue_AZN), 2) AS customer_revenue
FROM ecommerce_sales
GROUP BY Customer_ID
ORDER BY customer_revenue DESC
LIMIT 10;