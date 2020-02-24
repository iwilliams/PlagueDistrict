extends "res://districts/District.gd"

func every_day() -> void:
  Globals.cure_percent += Globals.max_cure_per_day*Globals.medical_percent
