extends Event

export (float) var cost := 1000

func enabled_get():
  return Globals.money >= cost

func accept():
  Globals.money -= cost
  
func decline():
  Globals.population_reasign_cost *= 2
  apply_decline_buff()
