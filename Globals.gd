extends Node

signal every_minute
signal every_hour
signal every_day

var population : int = 4000000 setget population_set
func population_set(value) -> void:
  population = max(value, 0)
  
var infected_population : int setget, infected_population_get
func infected_population_get() -> int:
  return int(ceil(population * infection_percent))
  
var food : int = 200
var money : int = 200

var infection_percent : float = .02 setget infection_percent_set
func infection_percent_set(value) -> void:
  infection_percent = clamp(value, 0, 1.0)
  
var mortality_rate : float = .10
var transfer_rate : float = .25

var minutes : int = 0
var days : int setget , days_get
func days_get() -> int:
  return int(floor(minutes/1440))

onready var gcd : Timer = get_node("gcd")

func _ready() -> void:
  #warning-ignore:return_value_discarded
  gcd.connect("timeout", self, "gcd_timeout")
  
func gcd_timeout() -> void:
  minutes += 1
  every_minute()
  if minutes % 60 == 0:
    every_hour()   
  if minutes % 1440 == 0:
    every_day()
    
func every_minute() -> void:
  emit_signal("every_minute")
  pass
  
func every_hour() -> void:
  spread_infection()
  emit_signal("every_hour")
  pass
  
func every_day() -> void:
  kill_population()
  emit_signal("every_day")
  pass
  
func spread_infection() -> void:
  var total_infected = ceil(infected_population_get() + (float(infected_population_get()) * transfer_rate))
  infection_percent_set(total_infected/population)
  
func kill_population() -> int:
  var dead = ceil(float(infected_population_get()) * mortality_rate)
  var new_infected_population = infected_population_get() - dead
  infection_percent_set(new_infected_population/population)
  population -= dead
  return dead

