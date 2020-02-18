extends Label

onready var globals = get_node("/root/Globals")
var notification = preload("res://hud/Notification.tscn")

export var resource : String
    
func _ready():
  globals.connect(resource + "_change", self, "resource_change")

func _process(_delta: float):
  text = "%-9s" % globals.comma_sep(globals[resource])
  
func resource_change(value: int) -> void:
  var n = notification.instance()
  n.amount = value
  add_child(n)
