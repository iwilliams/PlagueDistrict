extends Event

export (float) var percent_cost := .20

func enabled_get():
  return Globals.moral <= Globals.MORAL_SAD
  
func accept():
  Globals.moral = Globals.MORAL_NORMAL
  Globals.money *= 1 - percent_cost
