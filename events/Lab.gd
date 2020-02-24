extends Event

export (float) var research_damage := .05

func enabled_get():
  return Globals.moral <= Globals.MORAL_SAD
  
func accept():
  Globals.cure_percent *= 1.0 - research_damage
