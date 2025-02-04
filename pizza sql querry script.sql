use pizzadb;

select * from pizza_sales;

create view Total_Revenue as
select sum(total_price)  from Pizza_sales;
select * from Total_Revenue;

create view  Avg_Order_Value as
select sum(total_price) / count(distinct order_id) from pizza_sales;
select * from Avg_Order_Value;

create view Total_pizza_sold as 
select sum(quantity) from pizza_sales;
select * from Total_pizza_sold;

create view total_orders as
select count(distinct order_id)  from pizza_sales;
select * from total_orders;

create view Avg_pizza_per_Order as
Select format(sum(quantity) / count(distinct order_id), 2) from pizza_sales;
select * from Avg_Pizza_per_Order;

select * from pizza_sales;
select Date_format(DW, order_date) as order_day, 
count(distinct order_id) as total_orders from pizza_sales
group by Date_format(DW, order_date);
    
SELECT 
    DAYNAME(order_date) AS day_of_week, 
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    pizza_sales
GROUP BY 
    DAYNAME(order_date)
ORDER BY 
    FIELD(DAYNAME(order_date), 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
SELECT 
    DAYNAME(order_date) AS day_of_week, 
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    pizza_sales
GROUP BY 
    day_of_week
ORDER BY 
    FIELD(day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');


# Daily Trend
SELECT 
    DAYNAME(STR_TO_DATE(order_date, '%d/%m/%Y')) AS day_of_week, 
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    pizza_sales
GROUP BY 
    day_of_week
ORDER BY 
    FIELD(day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

# Hourly Trend
SELECT 
    HOUR(STR_TO_DATE(order_time, '%H:%i:%s')) AS order_hour, 
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    pizza_sales
GROUP BY 
    order_hour
ORDER BY 
    order_hour;
    
select * from pizza_sales;


#percentage of sales by pizza category
SELECT 
    pizza_category, 
    SUM(total_price) AS Total_Sales, 
    SUM(total_price) * 100.0 / (
        SELECT SUM(total_price) 
        FROM pizza_sales 
        WHERE MONTH(STR_TO_DATE(order_date, '%d/%m/%Y')) = 1
    ) AS pct 
FROM 
    pizza_sales
WHERE 
    MONTH(STR_TO_DATE(order_date, '%d/%m/%Y')) = 1
GROUP BY 
    pizza_category;
    
    
# percentage of sales by pizza size 

SELECT 
    pizza_size, 
    SUM(total_price)  AS Total_Sales, 
    cast(SUM(total_price) * 100.0 / (
        SELECT SUM(total_price) 
        FROM pizza_sales) as decimal(10, 2))
 AS pct 
FROM pizza_sales
GROUP BY pizza_size
order by  pct desc;

SELECT 
    pizza_size, 
    CAST(SUM(total_price) AS DECIMAL(10, 2)) AS Total_Sales, 
    CAST(SUM(total_price) * 100.0 / (
        SELECT SUM(total_price) 
        FROM pizza_sales WHERE quarter(STR_TO_DATE(order_date, '%d/%m/%Y')) = 1
    ) AS DECIMAL(10, 2)) AS pct 
FROM 
    pizza_sales
WHERE quarter(STR_TO_DATE(order_date, '%d/%m/%Y')) = 1
GROUP BY 
    pizza_size
ORDER BY 
    pct DESC;
    
# total  pizzas sold by pizza category
select pizza_category, sum(quantity) as Total_pizza_Sold
from pizza_sales
group by pizza_category;

# top 5 best sellers by Total pizzas sold
select  pizza_name, sum(quantity) as total_pizza_sold from pizza_sales
WHERE MONTH(STR_TO_DATE(order_date, '%d/%m/%Y')) = 8
group by pizza_name
order by sum(quantity) desc limit 5;














  















