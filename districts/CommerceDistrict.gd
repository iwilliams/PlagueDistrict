extends "res://districts/District.gd"

var max_money_per_hour := 2500

func every_hour() -> void:
  if Globals.hour % 2 == 0:
    var increase := max_money_per_hour*Globals.commerce_percent
    if Globals.moral >= Globals.MORAL_HAPPY:
      increase *= 1.5
    elif Globals.moral >= Globals.MORAL_NORMAL:
      increase *= 1
    elif Globals.moral >= Globals.MORAL_SAD:
      increase *= .75
    elif Globals.moral >= Globals.MORAL_DESPAIR:
      increase *= .5
    globals.money += int(floor(increase))
