-- Exploratory data analysis
-- quesions


-- 1. What is the count of distinct cities in the dataset?

select count(distinct(city)) as count_of_cities from amazon;


-- 2. For each branch, what is the corresponding city?

select branch, city from amazon
group by branch, city;


-- 3. What is the count of distinct product lines in the dataset?

select count(distinct(product_line)) as count_of_products from amazon;


-- 4. Which payment method occurs most frequently?

select payment_method, count(*) as most_frequently_occured_payment
from amazon 
group by payment_method
order by most_frequently_occured_payment desc
limit 1;


-- 5. Which product line has the highest sales?

select product_line, sum(total) as total_sales
from amazon
group by product_line
order by total_sales desc
limit 1;


-- 6. How much revenue is generated each month?

select month_name, sum(total) as revenue
from amazon
group by month_name
order by month_name desc ;


-- 7. In which month did the cost of goods sold reach its peak?
select month_name, max(cogs) as total_cogs from amazon
group by month_name
order by total_cogs desc
limit 1;


-- 8. Which product line generated the highest revenue?

select product_line, sum(total) as total_revenue
from amazon
group by product_line
order by total_revenue desc
limit 1;


-- 9. In which city was the highest revenue recorded?

select city, sum(total) as total_revenue
from amazon
group by city
order by total_revenue desc
limit 1;


-- 10. Which product line incurred the highest Value Added Tax?

select product_line, sum(VAT) as higest_VAT
from amazon
group by product_line
order by higest_VAT
limit 1;


-- 11. For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."

select a.*, case
				when a.total > avg_sales.avg_total then "Good"
                else "Bad"
			end as sales_performance
from amazon a
inner join (select product_line, avg(total) as avg_total
from amazon
group by product_line) avg_sales on a.product_line = avg_sales.product_line;


-- 12. Identify the branch that exceeded the average number of products sold.

with branch_sales as (select branch, sum(quantity) as total_quantity
from amazon
group by branch
),
avg_sales as (select avg(total_quantity) as avg_quantity
from branch_sales
)
select bs.branch, bs.total_quantity
from branch_sales bs, avg_sales ags

where bs.total_quantity > ags.avg_quantity;


-- 13. which product line is most frequently associated with each gender?

select gender, product_line, count(*) as frequency from amazon
group by gender, product_line
order by gender, frequency desc
limit 10;

-- 14. Calculate the average rating for each product line.

select product_line, avg(rating) as avg_rating from amazon
group by product_line;


-- 15. Count the sales occurrences for each time of day on every weekday.

select day_name, time_of_day, count(*) as sales_occurance from amazon
group by day_name, time_of_day
order by day_name, time_of_day;


-- 16. Identify the customer type contributing the highest revenue.

select customer_type, sum(total) as highest_revenue from amazon
group by customer_type
order by highest_revenue desc
limit 1;


-- 17. Determine the city with the highest VAT percentage.

select city, sum(VAT) as highest_vat from amazon
group by city
order by highest_vat desc
limit 1;


-- 18. Identify the customer type with the highest VAT payments

select customer_type, sum(VAT) as highest_vat from amazon
group by customer_type
order by highest_vat desc
limit 1;


-- 19. What is the count of distinct customer types in the dataset?

select count(distinct(customer_type)) as count_customer_type from amazon;


-- 20. What is the count of distinct payment methods in the dataset?

select count(distinct(payment_method)) as count_payment_method from amazon;



-- 21. Which customer type occurs most frequently?

select customer_type, count(*) as frequency from amazon
group by customer_type
order by frequency desc
limit 1;


-- 22. Identify the customer type with the highest purchase frequency.

select customer_type, count(*) as purchase_frequency from amazon
group by customer_type
order by purchase_frequency desc
limit 1;


-- 23. Determine the predominant gender among customers.

select gender, count(*) as frequency from amazon
group by gender
order by frequency desc
limit 1;



-- 24. Examine the distribution of genders within each branch.

select branch, gender, count(*) as frequency from amazon
group by branch, gender
order by branch, frequency desc;


-- 25. Identify the time of day when customers provide the most ratings.

select time_of_day, count(rating) as most_ratings from amazon
group by time_of_day
order by most_ratings desc
limit 1;


-- 26. Determine the time of day with the highest customer ratings for each branch.

select branch, time_of_day, count(rating) as highest_rating from amazon
group by branch, time_of_day
order by highest_rating desc;


-- 27. Identify the day of the week with the highest average ratings.

select day_name, avg(rating) as avg_rating from amazon
group by day_name
order by avg_rating desc
limit 1;


-- 28. Determine the day of the week with the highest average ratings for each branch.

select branch, day_name, avg(rating) as avg_rating from amazon
group by branch, day_name
order by branch, avg_rating desc

