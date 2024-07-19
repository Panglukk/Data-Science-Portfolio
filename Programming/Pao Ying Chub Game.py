# ข้อที่ 1 สร้างเกม เป่ายิ้งฉุบ!

import random

def game():
  player_name = input("Welcome!😎 What is your name? ")
  print(f"Hello, {player_name}! Let's play Pao Ying Chub game.")
  print("Rules:")
  print("- Hammer beats Scissors")
  print("- Scissors beat Paper")
  print("- Paper beats Hammer")
  print("- Tie if both choose the same hand")

  total_player_score = 0
  total_bot_score = 0

  while True:
    round_player_score = 0
    round_bot_score = 0

    for _ in range(3):
      while True:
        player_hand = input("\nChoose your hand (hammer, scissors, paper): ").lower()
        if player_hand in ["hammer", "scissors", "paper"]:
          break
        else:
          print("Invalid hand. Please choose hammer, scissors, or paper.")

      bot_hand = random.choice(["hammer", "scissors", "paper"])
      print(f"I choose: {bot_hand}")

      if player_hand == bot_hand:
        print("It's a tie!")
      elif (player_hand == "hammer" and bot_hand in ["scissors"]) or \
           (player_hand == "scissors" and bot_hand in ["paper"]) or \
           (player_hand == "paper" and bot_hand in ["hammer"]):
        print("You win!")
        round_player_score += 1
      else:
        print("You lose!")
        round_bot_score += 1

      print(f"Round score: You - {round_player_score}, Bot - {round_bot_score}")

    total_player_score += round_player_score
    total_bot_score += round_bot_score

    print(f"\nOverall score after this round: You - {total_player_score}, Bot - {total_bot_score}")

    play_again = input("\nPlay another round? (yes/no): ").lower()
    if play_again != "yes":
      break

  print(f"\nFinal score: You - {total_player_score}, Bot - {total_bot_score}")

  if total_player_score > total_bot_score:
    print(f"Congratulations, {player_name}, you won! 🥳")
  elif total_player_score < total_bot_score:
    print(f"Better luck next time, {player_name}. This game I win. 😈")
  else:
    print("It's a tie! Good game. 🤝")

game()
