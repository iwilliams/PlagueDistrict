extends "res://districts/District.gd"

const HOUR_BREAKFAST := 8
const HOUR_LUNCH := 12
const HOUR_DINNER := 18

export (int) var meals_per_day := 3
export (int) var people_per_food_unit_meal := 10000

var max_food_per_day := 2000

onready var meals_slider : HSlider = find_node("MealsSlider")
onready var meals_label : Label = find_node("MealsLabel")
onready var ration_range : SpinBox = find_node("RationRange")

func _ready() -> void:
  meals_slider.connect("value_changed", self, "_on_meals_slider_value_changed")
  ration_range.connect("value_changed", self, "_on_RationRange_value_changed")
  
func every_hour() -> void:
  if (meals_per_day == 3 && Globals.hour == HOUR_BREAKFAST) \
    || (meals_per_day > 0 && Globals.hour == HOUR_LUNCH) \
    || (meals_per_day > 1 && Globals.hour == HOUR_DINNER):
    Globals.food -= int(floor(Globals.population/people_per_food_unit_meal))
    if people_per_food_unit_meal > 10000:
      Globals.moral -= .01
    if people_per_food_unit_meal > 15000:
      Globals.moral -= .05
    if people_per_food_unit_meal > 20000:
      Globals.moral -= .1
      
  if meals_per_day < 3 && Globals.hour == HOUR_BREAKFAST:
    Globals.moral -= .01
  if meals_per_day < 2 && Globals.hour == HOUR_DINNER:
    Globals.moral -= .01
  if meals_per_day < 1 && Globals.hour == HOUR_LUNCH:
    Globals.moral -= .01
    
func every_day() -> void:
  var increase := max_food_per_day*Globals.agriculture_percent
  if Globals.moral >= Globals.MORAL_HAPPY:
    increase *= 1.5
  elif Globals.moral >= Globals.MORAL_NORMAL:
    increase *= 1
  elif Globals.moral >= Globals.MORAL_SAD:
    increase *= .75
  elif Globals.moral >= Globals.MORAL_DESPAIR:
    increase *= .5
  globals.food += int(floor(increase))

func _on_meals_slider_value_changed(value):
  meals_label.text = "Meals per day: " + str(value)
  meals_per_day = value

func _on_RationRange_value_changed(value):
  people_per_food_unit_meal = value
