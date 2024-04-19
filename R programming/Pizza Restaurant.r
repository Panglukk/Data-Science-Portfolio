print("Hello🍕😊")
username <- readline("What is your name:")

text = paste("Hi khun", username, "Please allow us to display the food menu of our restaurant.")
print(text)

df <- data.frame (
    num_order1 = 1:3,
    normal_menu = c("cheese lover pizza", "hawaiian style pizza", "chispy chicken pizza"),
    price1 = as.character(c("$25", "$26", "$27")),
    num_order2 = 4:6,
    special_menu_today = c("meat lover pizza", "tuna delight pizza", "pepperoni pizza"),
    price2 = as.character(c("$28", "$28", "$28"))
)
df[1:3, ]

text2 = paste("Khun", username, "can order the menu from the staff.")
print(text2)

order_menu <- readline("What menu will you order? (Please write a num_order)")

text3 = paste("Please allow me to confirm Khun", username, "order. There is a menu of", order_menu)
print(text3)

confirm_order <- readline("Is that correct? (yes or no)")

confirm_pay <- readline("Do you anything more? (yes or no)")

    if (confirm_pay == "no") {
        print("Please allow me to summarize the total.")
    } else {
        print("anyting_else?")
    }

    total_price <- function(menu) {
    total_price <- 0

    # Loop through each menu choice
  for (menu in menu) {
    # Declare a variable to store the price for the current menu choice
    price <- 0

    if (menu == 1) {
            price <- 25
        } else if (menu == 2) {
            price <- 26
        } else if (menu == 3) {
            price <- 27
        } else if (menu == 4) {
            price <- 28
        } else if (menu == 5) {
            price <- 28
        } else if (menu == 6) {
            price <- 28
        } else {
            cat("Invalid menu choice:", menu, "\n")
            next
    }

   # Add the price to the total price
    total_price <- total_price + price
  }
    # Display the total price for all orders
  cat("The total price for the orders is $", total_price, "\n")
}
# Split the user input into a vector of menu choices
    menu <- strsplit(order_menu, ",")[[1]]

total_price(menu)
