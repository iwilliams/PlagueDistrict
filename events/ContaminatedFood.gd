extends Event

export (int) var cost = 1000

func enabled_get():
  return Globals.money >= cost

func accept():
  Globals.cost_of_money_in_food *= .5
  Globals.money -= cost
  
func decline():
  Globals.cost_of_money_in_food *= .25
  Globals.cost_of_food_in_money *= 4
