extends Node

const MINUTES_IN_DAY = 1440

signal every_minute
signal every_hour
signal every_day

signal money_change
signal population_change
signal food_change
signal event
signal can_reasing_population_change
signal population_reasign_cost_change

var population : int = 4000000 setget population_set
func population_set(value: int) -> void:
  value = int(max(value, 0))
  var diff := value - population
  if diff != 0:
    emit_signal("population_change", diff)
  population = int(max(value, 0))
  
var infected_population : int setget, infected_population_get
func infected_population_get() -> int:
  return int(ceil(population * infection_percent))

var food : int = 3600 setget food_set
func food_set(value: int) -> void:
  value = int(max(value, 0))
  var diff := value - food
  if diff != 0:
    emit_signal("food_change", diff)
  food = value
  
var money : int = 1000 setget money_set
func money_set(value: int) -> void:
  value = int(max(value, 0))
  var diff := value - money
  if diff != 0:
    emit_signal("money_change", diff)
  money = value

var infection_percent : float = .02 setget infection_percent_set
func infection_percent_set(value) -> void:
  infection_percent = clamp(value, 0, 1.0)
  
var mortality_rate : float = .10
var transfer_rate : float = .25

var max_cure_per_day : float = 0.07 setget max_cure_per_day_set
func max_cure_per_day_set(value: float):
  max_cure_per_day = max(0, value)

var cure_percent : float = 0.0 setget cure_percent_set
func cure_percent_set(value) -> void:
  cure_percent = clamp(value, 0, 1.0)

const MORAL_HAPPY := 2.0
const MORAL_NORMAL := 1.0
const MORAL_SAD := 0.5
const MORAL_DESPAIR := 0.25
var moral := MORAL_NORMAL

var minutes : int = 0
var days : int setget , days_get
func days_get() -> int:
  return int(floor(float(minutes)/MINUTES_IN_DAY))

var hour : int setget , hour_get
func hour_get() -> int:
  # warning-ignore:integer_division
  var hours = (minutes - (days_get()*MINUTES_IN_DAY))/60
  return int(hours)

var districts : Array = [
    "residential", 
    "medical", 
    "commerce",
    "agriculture",
    "government"
  ]

var can_reasign_population := true setget can_reasign_population_set
func can_reasign_population_set(value):
  can_reasign_population = value
  emit_signal("can_reasing_population_change")

var population_reasign_cost := 500 setget population_reasign_cost_set
func population_reasign_cost_set(value):
  population_reasign_cost = max(0, value)
  emit_signal("population_reasign_cost_change")

var cost_of_money_in_food = 100
var cost_of_food_in_money = 100

var residential_percent : float = .15
var medical_percent : float = .15
var commerce_percent : float = .15
var agriculture_percent : float = .15
var government_percent : float = .15

onready var gcd : Timer = get_node("gcd")
onready var possible_events = get_node("PossibleEvents")
onready var current_events = get_node("CurrentEvents")
var current_event : Event setget , current_event_get
func current_event_get() -> Event:
  if current_events.get_child_count() > 0:
    return current_events.get_child(0)
  else:
    return null
onready var expired_events = get_node("ExpiredEvents")
onready var possible_buffs = get_node("PossibleBuffs")
onready var active_buffs = get_node("ActiveBuffs")
onready var bgm : AudioStreamPlayer = get_node("BGM")
onready var event_chime : AudioStreamPlayer = get_node("EventChime")
onready var click_sound : AudioStreamPlayer = get_node("ClickSound")

func _ready() -> void:
  #warning-ignore:return_value_discarded
  gcd.connect("timeout", self, "gcd_timeout")
  
func gcd_timeout() -> void:
  minutes += 1
  every_minute()
  if minutes % 60 == 0:
    every_hour()   
  if minutes % MINUTES_IN_DAY == 0:
    every_day()
    
func every_minute() -> void:
  for node in active_buffs.get_children():
    var buff : Buff = node
    if buff:
      buff.every_minute()
  emit_signal("every_minute")
  
func every_hour() -> void:
  for node in active_buffs.get_children():
    var buff : Buff = node
    if buff:
      buff.every_hour()
  spread_infection()
  emit_signal("every_hour")
#  if hour_get() == 1:
#    get_event()

func every_day() -> void:
  for node in active_buffs.get_children():
    var buff : Buff = node
    if buff:
      buff.every_day()
  var _dead = kill_population()
  get_event()
  emit_signal("every_day")
  
func spread_infection() -> void:
  if population > 0:
    var total_infected = ceil(infected_population_get() + (float(infected_population_get()) * transfer_rate))
    infection_percent_set(total_infected/population)
  
func kill_population() -> int:
  var dead = ceil(float(infected_population_get()) * mortality_rate)
  var new_infected_population = infected_population_get() - dead
  infection_percent_set(new_infected_population/population)
  population -= dead
  return dead

func comma_sep(number: float) -> String:
  var string = str(number)
  var mod = string.length() % 3
  var res = ""
  for i in range(0, string.length()):
    if i != 0 && i % 3 == mod:
        res += ","
    res += string[i]
  return res

func get_event() -> void:
  if current_events.get_child_count() > 0 \
  || possible_events.get_child_count() == 0:
    return
  var enabled_events := []
  for possible_event in possible_events.get_children():
    var event : Event = possible_event
    if event != null && event.enabled:
      enabled_events.append(event)
  if enabled_events.size() > 0:
    randomize()
    enabled_events.shuffle()
    var event : Event = enabled_events.pop_front()
    event_chime.play()
    possible_events.remove_child(event)
    current_events.add_child(event)
    emit_signal("event", event)
    
func event_accept() -> bool:
  if current_events.get_child_count() > 0:
    var event : Event = current_events.get_child(0)
    event.accept()
    current_events.remove_child(event)
    expired_events.add_child(event)
    return true
  else:
    return false
    
func event_decline() -> bool:
  if current_events.get_child_count() > 0:
    var event : Event = current_events.get_child(0)
    if !event.can_decline:
      return false
    event.decline()
    current_events.remove_child(event)
    expired_events.add_child(event)
    return true
  else:
    return false
