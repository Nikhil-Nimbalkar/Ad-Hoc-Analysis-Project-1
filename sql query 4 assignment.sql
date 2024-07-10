#SQL Awesome chocolates Questions to answer

use `awesome chocolates`;
select * from sales;
select * from products;
select * from people;
select * from geo;

#1) Which are the top 5 Products according volume of the sale

select products.product , sum(sales.boxes) 
from sales join  products on sales.PID = products.PID
 group by products.product order by  sum(sales.boxes) desc limit 5 ;

#2) What is Category wise avg price per box
select distinct products.category,avg( products.Cost_per_box)  from products group by products.category;
select category ,avg(cost_per_box) as avg_price_per_box from products group by category order by avg_price_per_box; 

#3) Which region has lowest orders
select geo.region , sum(sales.boxes) from sales join geo on sales.geoid = geo.geoid group by geo.region order by sum(sales.boxes)  ;



#4) What is avg order value in APAC region

#avg_order_value = total_revenue / total _order 
#                   OR
#(sum(sales.amount) / count(sales.amount)) as avg_order_value

select geo.region, avg(sales.amount) from sales join geo on sales.geoid = geo.geoid where geo.region = "APAC" order by avg(sales.amount);
select geo.region, (sum(sales.amount) / count(sales.amount)) as avg_order_value 
from sales join geo on sales.geoid = geo.geoid where geo.region = "APAC" order by avg_order_value;
 
 
#5) What are top 2 favorite categories in America
select geo.region , sum(sales.boxes),products.category 
from sales join geo on sales.geoid = geo.geoid 
join products on sales.PID = products.PID 
where geo.region = "Americas"
group by products.category order by sum(sales.boxes) limit 2;

#6) Which team is best performing team
select people.team as best_performing_team ,sum(sales.boxes) as max_sales_boxes 
from sales join people on sales.SPID = people.SPID 
group by best_performing_team 
order by max_sales_boxes desc limit 1 ;

#7) Which country has highest consumption of almond choco
select geo.geo as country ,products.product ,sum(sales.boxes) as highest_consumption
from sales join geo on sales.geoid = geo.geoid join products on sales.PID  = products.PID 
where products.product = "Almond choco" group by geo.geo order by sum(sales.boxes) desc limit 5 ;
