extends "res://districts/District.gd"

const HOUR_BREAKFAST = 8
const HOUR_LUNCH = 12
const HOUR_DINNER = 18

export (int) var meals_per_day = 3
export (int) var people_per_food_unit_meal = 10000

func every_hour() -> void:
  if (meals_per_day == 3 && globals.hour == HOUR_BREAKFAST) \
    || (meals_per_day > 0 && globals.hour == 12) \
    || (meals_per_day > 1 && globals.hour == 18):
    globals.food -= int(floor(globals.population/10000))
    
func every_day() -> void:
  globals.food += 800
