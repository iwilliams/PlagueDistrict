extends Event

export (float) var moral_damage = .25

func accept():
  Globals.moral -= moral_damage
  pass
