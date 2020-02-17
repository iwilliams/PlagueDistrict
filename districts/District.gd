extends Node2D

onready var globals = get_node("/root/Globals")
onready var button : Button = get_node("Button")
onready var popup : Popup = get_node("Popup")

func _ready():
  #warning-ignore:return_value_discarded
  button.connect("button_down", popup, "popup")
  globals.connect("every_minute", self, "every_minute")
  globals.connect("every_hour", self, "every_hour")
  globals.connect("every_day", self, "every_day")
  
func every_minute() -> void:
  pass
  
func every_hour() -> void:
  pass
  
func every_day() -> void:
  pass
