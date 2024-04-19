greeting <- function() {
    username <- readline("Hi! What's your name:")
    text = paste("Welcome khun", username, "to my magic game🔮✨")
    print(text)
    text2 = paste("Description for khun", username, "in play เป่ายิ้งฉุบบ! game")
    print(text2)

    df <- data.frame (
        "num_choice" = 1:3,
        "symbol" = c("🔨", "✌️", "📃")
    )
    print(df)

    text3 = ("1 round = 5 times, Ok! let's start the game" )
    print(text3)

    your_point <- 0
    bot_point <-0
    count <-0
    choice <- c("🔨", "✌️", "📃")

    while (count < 5 ) {
   flush.console()
   bot_choice  <- sample(choice, 1)
   your_choice <- readline("What's your num_choice:")
   print(paste(username, "move is:", your_choice, "vs.", "bot_choice is:", bot_choice))

    if (your_choice == bot_choice) {
  print("Equal!")
  } else if ((your_choice == "1" & bot_choice == "3") |
            (your_choice == "3" & bot_choice == "2") |
            (your_choice == "2" & bot_choice == "1")) {
            print("Bot got 1 point")
            bot_point = bot_point + 1

  } else { your_choice = your_choice + 1
    print("You got 1 point") }
   count <- count +1
}

print(paste("Your score:", your_point ,"VS.", "Bot score", bot_point))

if (your_point >= 2) {
  print("You are win!!")
} else if (bot_point >= 2){
  print("Sorry, you are lose!!")
} else {your_point == bot_point
  print("Equal")}

}

greeting()
