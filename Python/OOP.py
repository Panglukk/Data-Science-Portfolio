# ข้อที่ 2 OOP : Data Analyts
class DataAnalyst():
  def __init__(self, name, age, skill, salary):
    self.name = name
    self.age = age
    self.skill = skill
    self.salary = salary

  def introduce(self):
    print(f"Hello, my name is {name}. I am {age} years old and have skills in {skill}, My salary is {salary} Bath")

  def exp_period(self, year):
    self.age += year
    print(f"I have been working in data analyst for {year} years.")

  def recommend_promotion(self, performance_rating):
    if performance_rating == "Exceeds expectations":
        print(f"{self.name} is recommended for promotion.")
    elif performance_rating == "Meets expectations":
        print(f"{self.name} is on track for promotion.")
    else:
        print(f"{self.name} needs to improve performance to be considered for promotion.")


emp01 = DataAnalyst("Pang", 24, "Spreadsheet SQL R Python Visualization", "30K")
