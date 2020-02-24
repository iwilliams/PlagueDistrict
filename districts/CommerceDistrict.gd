extends "res://districts/District.gd"

var max_money_per_hour = 2500

func every_hour() -> void:
  if Globals.hour % 2 == 0:
    globals.money += int(floor(max_money_per_hour*globals.commerce_percent))
