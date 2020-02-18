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
    globals.food -= int(floor(globals.population/people_per_food_unit_meal))
    
func every_day() -> void:
  globals.food += 800

func _on_meals_slider_value_changed(value):
  find_node("MealsLabel").text = "Meals per day: " + str(value)
  meals_per_day = value

func _on_RationRange_value_changed(value):
  people_per_food_unit_meal = value
