create table customers (
  customer_id int primary key,
  firstname text,
  lastname text,
  region text,
  company text,
  email text
);

insert into customers values
  (1, "Claire", "Pao", "south", "Woodstock Discos", "claire@gmail.com"),
  (2, "Pete", "Kim", "central", NULL, "pete@yahoo.com"),
  (3, "Ken", "Gin", "central", "Telus", "ken@gmail.com"),
  (4, "Gene", "Lhong", "central", NULL, "gene@gmail.com"),
  (5, "Erin", "Watson", "south", "Google Inc.", "erin@gmail.com"),
  (6, "Kunst", "Thiti", "west", "Apple Inc.", "kunst@hotmail.com");

create table pizza_menu (
  pizza_id int primary key,
  menu text,
  category text,
  price int
);

insert into pizza_menu values
  (1, "Hawaiian", "pizza", 140),
  (2, "Pepperoni", "pizza", 140),
  (3, "Vegetarian", "pizza", 120),
  (4, "Margherita", "pizza", 120),
  (5, "Meat Lover", "pizza", 150),
  (6, "Coca-Cola", "drink", 40),
  (7, "Sprite", "drink", 40),
  (8, "Orange Juice", "dessert", 60),
  (9, "Mango Crunch", "dessert", 100),
  (10, "Chocolate Sin", "dessert", 120);

create table orders (
  order_id int primary key,
  customer_id int,
  pizza_id int,
  order_date text,
  amount int
);

insert into orders values
  (1, 1, 3, "2023-10-10", 2),
  (2, 2, 1, "2023-10-10", 1),
  (3, 3, 4, "2023-10-11", 1),
  (4, 4, 6, "2023-11-12", 3),
  (5, 5, 8, "2023-11-14", 1),
  (6, 6, 5, "2023-12-15", 5);
  
  
.mode box
select * from customers;
select * from pizza_menu;
select * from orders;

select * from customers
join orders on customers.customer_id = orders.customer_id;

select * from pizza_menu
join orders on pizza_menu.pizza_id = orders.pizza_id;

select
  firstname, lastname, region
  from customers
where region in ("central", "west");

select
  count(*) as total_order,
  round(sum(price),1) as sum_price,
  min(price) as min_price,
  max(price) as max_price
from pizza_menu;

select
price,
  CASE
    WHEN price >= 140 THEN "High price"
    WHEN price >= 100 THEN "Medium price"
    ELSE "Low price"
  END as price_level
from pizza_menu
group by price;

select
  CASE
    WHEN price >= 140 THEN "High price"
    WHEN price >= 100 THEN "Medium price"
    ELSE "Low price"
  END as price_level,
  count(*) as total_price_level
from pizza_menu
group by price;

select 
  firstname, company,
  COALESCE(company, "B2C") as clean_company,
    CASE 
      WHEN company is NULL THEN "B2C"
      ELSE "B2B"
    END as segment
from customers;

select
    CASE 
      WHEN company is NULL THEN "B2C"
      ELSE "B2B"
    END as segment,
    region,
  COUNT(*) as num_customers
from customers
group by segment, region;

select
  CASE 
    WHEN company is NULL THEN "B2C"
    ELSE "B2B"
  END as segment,
  region,
  count(*) as num_customers
from customers
  WHERE region in ("central", "west")
  group by 1, 2
  having num_customers > 1;

select
  menu,
  price
from pizza_menu
order by price desc
limit 5;

with central_customers as (
  select * from customers
  where region = "central"
), orderdate_2023 as (
  select * from orders
  where STRFTIME("%Y-%m", order_date) = "2023-10"
)
select firstname, email, count(*)
from central_customers
join orderdate_2023 on central_customers.customer_id = orderdate_2023.customer_id
group by firstname, email;
