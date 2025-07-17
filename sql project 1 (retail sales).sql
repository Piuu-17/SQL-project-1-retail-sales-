-- retail sale analysis --

create database p1;
use p1;
drop table if exists details;
create table details (
    transactions_id int primary key,
    sale_date date,
    sale_time time,
	customer_id int,
	gender varchar(20),
    age int,
    category varchar(20),
    quantity int,
    price_per_unit float,
    cogs float,
    total_sale float
	);
    

    
    -- data cleaning--
    
    
    select * from details
    where sale_date is null;
    
    select * from details
    where sale_time is null;
    
    select * from details
    where customer_id is null;
    
    select * from details
    where gender is null;
    
    select * from details
    where age is null;
    
    select * from details
    where category is null;
    
    select * from details
    where quantity is null;
    
    select * from details
    where price_per_unit is null;
    
    select * from details
    where cogs is null;
    
    select * from details
    where total_sale is null;
    
    delete from details 
    where 
	transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or
    gender is null
    or
    age is null
    or
    category is null
    or
    quantity is null
    or
    price_per_unit is null
    or
    cogs is null
    or
    total_sale is null;
    
    
    -- data exploration--
    
    
    -- how many sales we have? --
    select count(*) as total_sales from details;
   -- how many unique customers we have? --
     select count( distinct customer_id) from details;
   -- how many distinct categories we have? --
     select distinct category from details;
     
	
   -- data analysis and business answers --
    
   -- Q1. Write a sql query to retrieve all columns for sales made on '2022-11-05'? --
   
		select * 
        from details
        where sale_date = '2022-11-05';
        
	-- Q2. write a sql query to retrive all transactions where the category is 'clothing' and quantity sold is more than 4 in the month nov-2022?
           select *
           from details 
           where category = 'Clothing'
           and 
		   sale_date='2022-11'
           and
           quantity >= 4;
	
	 -- Q3. write a sql query to calculate total sales of each category?
            select category , sum(total_sale) as net_sale
            from details 
            group by category;
            
	-- Q4. write a sql query to find average age of customers who purchased items from 'beauty' category?
           select avg(age)
           from details 
           where category='beauty';
           
	-- Q5. write a sql query to find all transactions where total_sale is greater than 1000?
           select transactions_id
           from details 
           where total_sale > 1000;
           
	-- Q6. write a sql query to find the total no of transactions (transaction_id) made by each gender in each category?
           select category , gender , count(transactions_id)
           from details
           group by category, gender;
           
    -- Q7. write a sql query to calculate average sale in each month . Find out the best selling month in each year.
          SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS avg_sale,
    RANK() OVER (
        PARTITION BY EXTRACT(YEAR FROM sale_date) 
        ORDER BY AVG(total_sale) DESC
    ) 
FROM details
GROUP BY 
    EXTRACT(YEAR FROM sale_date), 
    EXTRACT(MONTH FROM sale_date);
    
-- Q8. write a sql query to find top 5 customers based on the highest total sales.
       select  customer_id , 
       sum(total_sale) as total_sale
       from details
       group by 1
       order by 2 desc
       limit 5;
       
-- Q9. write a sql query to find number of unique customers who purchased items for each category.
	select 
    category,
    count(customer_id)
    from details
    group by 1;
    
-- Q10. write a sql query to create each shift and number of orders .
       WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM details
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift
        
            
    

    
    
    
    
    
    
    
    
    
    
    
    

