create database walmart;
use  walmart;
select *from walmart;

##------------------GENERIC QUESTIONS---------------------------------------------

/*1. How many unique cities does the data have?*/
select distinct city from walmart;
/*2. In which city is each branch? */
select distinct branch ,city  from walmart;
select branch ,count(branch) from walmart group by branch;

##--------------------------------PRODUCT-------------------------------------------------

/* 1. How many unique product lines does the data have?
*/
alter table walmart rename column `product line` to `product_line`;
select * from walmart;
select row_number() over(order by product_line) as 
count_unique_product,product_line from (
	select distinct product_line from walmart) as dpl;
select distinct product_line from walmart;

/*2. What is the most common payment method?*/
select payment,count(*) as most_common_payment_method from walmart group by payment order by payment desc  limit 1;

/*3. What is the most selling product line?*/
select product_line ,count(quantity) as most_selling_product
 from walmart group by product_line order by product_line desc limit 1;
 
 /*4. What is the total revenue by month?*/
    
    /*select order_date,sum(`gross income`)
    over(partition by  date_format(str_to_date(order_date,'%d-%m-%y'),'%m')) as months from walmart order by months desc;*/
    
    alter table walmart rename column order_datel to order_date;
    SELECT 
    DATE_FORMAT(str_to_date(order_date, '%d-%m-%Y'),'%M') AS months, 
    SUM(`gross income`) AS total_revenue 
FROM 
    walmart 
GROUP BY 
    months;
  
  /*5. What month had the largest COGS?*/
    select *from walmart;
    select date_format(str_to_date(order_date,'%Y-%m-%d'),'%M') as months,product_line, max(COGS) as largest_COGS from walmart group by 
    product_line, order_date order by largest_COGS desc limit 5;
    
    
/*6. What product line had the largest revenue?*/
select product_line ,sum(`gross income`) as largest_revenue 
from walmart 
group by product_line 
order by largest_revenue desc;

/*7. What is the city with the largest revenue?*/
select city ,sum(`gross income`) as largest_revenue_city 
from walmart 
group by city 
order by largest_revenue_city desc;

/*8. What product line had the largest VAT?*/
select product_line, sum(`Tax 5%`) as VAT 
from walmart
group by product_line
order by VAT desc limit 1;

/*9. Fetch each product line and add a column to those product line 
showing "Good", "Bad". Good if its greater than average sales*/    
select *from walmart;
select product_line , avg(Quantity) from walmart group by product_line;

select product_line, max(quantity) as max_sales, avg(quantity) as avg_sales,
case  when quantity>(select  avg(quantity) from walmart) then 'Good'
else 'bad'
end as 'Good_or_bad' from walmart group by product_line,quantity;

/*10. Which branch sold more products than average product sold?*/
#select branch,product_line,count(quantity)as sold from walmart group by branch, product_line;
select branch, SUM(quantity) as total_sold
from walmart 
group by branch order by total_sold desc limit 1;

select branch, SUM(quantity) as total_sold 
from walmart 
group by  branch 
having SUM(quantity) > (select avg(total_quantity) from (
        select SUM(quantity) as total_quantity from walmart group by branch) as subquery);

/*11.What is the most common product line by gender?*/
select*from walmart;
select gender,product_line,count(*) as count from walmart 
group by product_line,gender order by count desc limit 1;

/*12. What is the average rating of each product line?*/
select product_line , avg(rating)  as avg_rating from  walmart group by product_line;


###----------------------SALES-----------------------------------------------------------------------------

/*1. Number of sales made in each time of the day per weekday*/
	select
    date_format(str_to_date(order_date,'%d-%m-%y'),'%d') AS weekday, 
    hour(`time`) as hour_of_day, 
    COUNT(*) as sales_count from walmart group by weekday, hour_of_day order by weekday, hour_of_day;
    
/*2. Which of the customer types brings the most revenue?*/
select *from walmart;
alter table walmart rename column  cutomer_type to customer_type;
select customer_type, sum(`gross income`) as most_revenue_customer from walmart 
group by customer_type order by most_revenue_customer desc limit 1;

/*3. Which city has the largest tax percent/ VAT (**Value Added Tax**)?
*/
select city, max(`Tax 5%`) as largest_tax_percent from walmart group by city
order by largest_tax_percent desc limit 1;

/*4. Which customer type pays the most in VAT?*/
 select customer_type, sum(`tax 5%`) as most_VAT
 from walmart group by customer_type order by most_VAT desc limit 1;
 
 ###----------------------CUSTOMER-------------------------------------------
 /*1. How many unique customer types does the data have?*/
select count(distinct customer_type) as unique_customer_type from walmart;

/*2. How many unique payment methods does the data have?*/
select count(distinct payment) as unique_payment_methods from walmart;

/*3. What is the most common customer type?*/
select customer_type,count(*) as most_common_customer_type from walmart group by customer_type order by count(*) desc limit 1;
 
/*4. Which customer type buys the most?*/
select *from walmart;
select customer_type ,sum(quantity)as total_purchases from walmart group by customer_type order by total_purchases desc limit 1;

/*5.What is the gender of most of the customers?*/
select gender,count(*) as most_of_the_customers from walmart group by gender order by most_of_the_customers  desc limit 1;

/*6. What is the gender distribution per branch?*/
select branch,gender,count(*) as count from walmart group by branch,gender order by branch;

/*7. Which time of the day do customers give most ratings?*/
select *from walmart;
 select   hour(`time`) as hour_of_day, 
    COUNT(*) as rating_count from walmart group by  hour_of_day order by hour_of_day;

 /*8.Which time of the day do customers give most ratings per branch?*/
select branch, hour_of_day,rating_count from(
select branch, hour(`time`) as hour_of_day, 
COUNT(*) as rating_count ,row_number() over(partition by branch order by count(*)) as ratings
from walmart group by branch, hour_of_day order by branch, hour_of_day desc) as subquery where ratings=1;

/*9. Which day fo the week has the best avg ratings?*/
select date_format(str_to_date(order_date,'%d-%m-%y'),'%d') as day_of_week, avg(rating) as avg_rating 
from walmart group by day_of_week order by avg_rating desc limit 1;

/*10. Which day of the week has the best average ratings per branch?*/
select branch,day_of_week,avg_rating from(
select branch,date_format(str_to_date(order_date,'%d-%m-%y'),'%d') as day_of_week, avg(rating) as avg_rating,
row_number() over(partition by branch order by avg(rating) desc)as best_average_ratings_per_branch from walmart 
group by branch,day_of_week) as subquery where best_average_ratings_per_branch=1;

