extends "res://districts/District.gd"

func every_day() -> void:
  var increase := Globals.max_cure_per_day*Globals.medical_percent
  if Globals.moral >= Globals.MORAL_HAPPY:
    increase *= 1.5
  elif Globals.moral >= Globals.MORAL_NORMAL:
    increase *= 1
  elif Globals.moral >= Globals.MORAL_SAD:
    increase *= .75
  elif Globals.moral >= Globals.MORAL_DESPAIR:
    increase *= .5
  Globals.cure_percent += increase
