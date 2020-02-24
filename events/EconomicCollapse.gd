extends Event

export (int) var money_threshold = 200
export (int) var cost = 1000

func enabled_get():
  return Globals.money <= money_threshold

func accept():
  Globals.money += 1000
  
func decline():
  Globals.money += 2000
  Globals.moral -= .5
