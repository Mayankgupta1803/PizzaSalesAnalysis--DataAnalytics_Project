
Select * from dbo.pizza_sales;


Q1. Total Revenue?

select sum(total_price) as total_revenue from pizza_sales;

						total_revenue
						817860.05083847;

Q2.	Average Order Value/ Average amount spent per order??

select (SUM(total_price) / COUNT(Distinct order_id)) as Average_Order_Value from pizza_sales;

Q3. Total Pizza sold??

select sum(quantity) as Total_Pizza_Sold from pizza_sales;

						Total_Pizza_Sold
						49574	
				
Q4.	Total Orders??

select count(distinct order_id) as Total_Orders from pizza_sales;

							Total_Orders
							21350

Q5. Average pizza per order/ Average pizza sold perday??

select Cast(cast(sum(quantity) as Decimal(10,2)) / cast(count(distinct order_id) as Decimal(10,2)) as Decimal(10,2)) as Avg_pizza_order from pizza_sales

							Avg_pizza_order
							2.32


Select * from pizza_sales;

1. Daily Trend for Total Orders??
-- Daily trend-------------------------------
select  DATENAME(DW, order_date) as order_day, count(distinct order_id) as total_orders
from pizza_sales
group by DATENAME(DW, order_date);

								order_day	total_orders
								Saturday	3158
								Wednesday	3024
								Monday	    2794
								Sunday	    2624
								Friday	    3538
								Thursday    3239
								Tuesday	    2973

2. Hourly Trend for total orders??
-- ----------------------------- Hourly trend-------------------------------
select Datepart(hour, order_time) as order_hours, count(distinct order_id) as total_orders
from pizza_sales
group by Datepart(hour, order_time)
order by Datepart(hour, order_time);

							order_hours	total_orders
							9				1
							10				8
							11				1231
							12				2520
							13				2455
							14				1472
							15				1468
							16				1920
							17				2336
							18				2399
							19				2009
							20				1642
							21				1198
							22				663
							23				28

3.  Percentage of sales by pizza category??

select pizza_category, sum(total_price) as Total_sales, sum(total_price)*100 / (select sum(total_price) from pizza_sales) as PCT
from pizza_sales
group by pizza_category;

						pizza_category	   PCT
						Classic	         26.9059602306976
						Chicken	          23.9551375322885
						Veggie	          23.6825910258677
						Supreme	          25.4563112111462

-----------------------To filter the data with respect to January months---------------
select pizza_category, sum(total_price) as Total_sales, sum(total_price)*100 / (select sum(total_price) from pizza_sales where month(order_date) = 1) as PCT
from pizza_sales
where month(order_date) = 1
group by pizza_category;


4.	Percentage of sales by pizza size??

select distinct pizza_size from pizza_sales; 

						pizza_size
							L
							XXL
							M
							XL
							S

Select * from pizza_sales;

select pizza_size, cast(sum(total_price) as decimal(10,3)) as total_sales,count(quantity) as total_quantity_sold, cast(sum(total_price)*100 / (select sum(total_price) from pizza_sales) as decimal(10,2)) as Pct_Pizza_size
from pizza_sales
group By pizza_size
order by Pct_Pizza_size Desc;

						pizza_size	Pct_Pizza_size
						L			    45.89
						M				30.49
						S				21.77
						XL				1.72
						XXL		    	0.12

--To filter the data with respect to months---------------

select pizza_size, cast(sum(total_price) as decimal(10,3)) as total_sales,count(quantity) as total_quantity_sold, cast(sum(total_price)*100 / (select sum(total_price) from pizza_sales where month(order_date) = 1) as decimal(10,2)) as Pct_Pizza_size
from pizza_sales
where month(order_date) = 1
group By pizza_size
order by Pct_Pizza_size Desc;
									
									OR

select pizza_size, cast(sum(total_price) as decimal(10,3)) as total_sales,count(quantity) as total_quantity_sold, cast(sum(total_price)*100 / (select sum(total_price) from pizza_sales where Datepart(MONTH,order_date) = 1) as decimal(10,2)) as Pct_Pizza_size
from pizza_sales
where Datepart(MONTH,order_date) = 1
group By pizza_size
order by Pct_Pizza_size Desc;

--To filter the data with respect to Quarter---------------

select pizza_size, cast(sum(total_price) as decimal(10,3)) as total_sales,count(quantity) as total_quantity_sold, cast(sum(total_price)*100 / (select sum(total_price) from pizza_sales where Datepart(quarter,order_date) = 1) as decimal(10,2)) as Pct_Pizza_size
from pizza_sales
where Datepart(quarter,order_date) = 1
group By pizza_size
order by Pct_Pizza_size Desc;

5. Total pizzas sold by pizza category??

select pizza_category, sum(quantity) as Total_pizza_sold
from pizza_sales
group by pizza_category;

						pizza_category	Total_pizza_sold
						Classic			14888
						Chicken			11050
						Veggie			11649
						Supreme			11987

6. Top 5 best sellers by total pizza sold??

select * from pizza_sales;

select top 5 pizza_name, sum(quantity) as Total_pizzas_sold
from pizza_sales
group by pizza_name
order by Total_pizzas_sold Desc;

					pizza_name	              Total_pizzas_sold
					The Classic Deluxe Pizza	2453
					The Barbecue Chicken Pizza	2432
					The Hawaiian Pizza			2422
					The Pepperoni Pizza			2418
					The Thai Chicken Pizza		2371

7. Bottom 5 best sellers by total pizza sold??

select top 5 pizza_name, sum(quantity) as Total_pizzas_sold
from pizza_sales
group by pizza_name
order by Total_pizzas_sold Asc;

						pizza_name				Total_pizzas_sold
						The Brie Carre Pizza		490
						The Mediterranean Pizza		934
						The Calabrese Pizza			937
						The Spinach Supreme Pizza	950
						The Soppressata Pizza		961