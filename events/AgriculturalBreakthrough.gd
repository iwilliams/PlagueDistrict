extends Event

export (float) var food_increase = 5000
export (int) var cost = 2000

func enabled_get():
  return Globals.money >= cost

func accept():
  Globals.food += food_increase
  Globals.money -= cost
