# 1. Analysis data from “Flights” data base
# 1.1 Install package
library(nycflights13)
library(tidyverse)

# 1.2 Questions for analyzing data from “Flights”
# - Which countries of origin have air travel to ATL?
f1 <- flights %>%
  select(origin, dest) %>%
  filter(dest == "ATL")
View(f1)
unique(f1)

# - Which airline was the most used in March 2013?
flights %>%
  filter(month == 3) %>%
  count(carrier) %>%
  arrange(desc(n)) %>%
  head(5)

# - Arrange the months with the highest number of customers using the airline service.
flights %>%
  select(year, month, day) %>%
  count(month) %>%
  arrange(desc(n))

# - In March, which airlines operate departing flights from the country LGA?
flights %>%
  select(carrier, month, origin) %>%
  filter(origin == "LGA" & month == "3") %>%
  count(carrier)

# - Find the average air time, the minimum air time, the maximum air time from LGA to ATL, and which carrier has the shortest air time.
flights %>%
  select(carrier, origin, dest, air_time) %>%
  filter(origin == "LGA" & dest == "ATL") %>% 
  summarize(mean_time = mean(air_time, na.rm = TRUE), 
            min_time = min(air_time, na.rm = TRUE),
            max_time = max(air_time, na.rm = TRUE))

flights %>%
  select(carrier, origin, dest, air_time) %>%
  filter(origin == "LGA" & dest == "ATL") %>% 
  arrange(air_time) %>%
  head(1)

# - Which airline has the most delayed departures (top 5)?
flights %>%
  select(carrier, dep_delay) %>%
  arrange(dep_delay) %>%
  head(5)

---------------------------------------------------------------------------------

# 2. Create database on `Postgresql`
# Create 3-5 table data frame ⇒ write table into sever
# 2.1 Install package
library(RPostgreSQL)
library(sqldf)

# 2.2 Create connection
con <- dbConnect(
  PostgreSQL(),      
  host = "floppy.db.elephantsql.com",
  dbname = "snaofpsk",
  user = "snaofpsk",
  password = "qJmqyklPIn5OpZNrllMwthbyqP42Nh7m",
  port = 5432
)

# 2.3 Create tables
customers <- tribble(
  ~cutomer_id, ~firstname, ~lastname, ~region, ~company, ~email,
  1, "Claire", "Pao", "south", "Woodstock Discos", "claire@gmail.com",
  2, "Pete", "Kim", "central", NULL, "pete@yahoo.com",
  3, "Ken", "Gin", "central", "Telus", "ken@gmail.com",
  4, "Gene", "Lhong", "central", NULL, "gene@gmail.com",
  5, "Erin", "Watson", "south", "Google Inc.", "erin@gmail.com",
  6, "Kunst", "Thiti", "west", "Apple Inc.", "kunst@hotmail.com"
)

pizza_menu <- tribble(
  ~pizza_id, ~menu, ~category, ~price,
  1, "Hawaiian", "pizza", 140,
  2, "Pepperoni", "pizza", 140,
  3, "Vegetarian", "pizza", 120,
  4, "Margherita", "pizza", 120,
  5, "Meat Lover", "pizza", 150,
  6, "Coca-Cola", "drink", 40,
  7, "Sprite", "drink", 40,
  8, "Orange Juice", "dessert", 60,
  9, "Mango Crunch", "dessert", 100,
  10, "Chocolate Sin", "dessert", 120
)

orders <- tribble(
  ~order_id, ~customer_id, ~pizza_id, ~order_date, ~amount,
  1, 1, 3, 2023-10-10, 2,
  2, 2, 1, 2023-10-10, 1,
  3, 3, 4, 2023-10-11, 1,
  4, 4, 6, 2023-11-12, 3,
  5, 5, 8, 2023-11-14, 1,
  6, 6, 5, 2023-12-15, 5
)

price_level <- tribble(
  ~price, ~price_level,
  40, "Low price",
  60, "Low price",
  100, "Medium price",
  120, "Medium price",
  140, "High price",
  150, "High price"
)

# 2.4 Send the created table to the server.
dbWriteTable(con, "customers", customers)
dbWriteTable(con, "pizza_menu", pizza_menu)
dbWriteTable(con, "orders", orders)
dbWriteTable(con, "price_level", price_level)

# 🐥Get interested data query 
dbGetQuery(con, "select
								 menu,
								 price
						from pizza_menu
						order by price desc
						limit 5")

# 🌼Join function
pizza_menu %>%
  select(menu, category, price) %>%
  filter(category == "pizza")
  left_join(price_level, by = "price")

# Closs connection
dbDisconnect(con)
