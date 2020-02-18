extends Label

onready var globals = get_node("/root/Globals")
var notification = preload("res://hud/Notification.tscn")

export var resource : String

func comma_sep(number: float) -> String:
    var string = str(number)
    var mod = string.length() % 3
    var res = ""
    for i in range(0, string.length()):
        if i != 0 && i % 3 == mod:
            res += ","
        res += string[i]
    return res
    
func _ready():
  globals.connect(resource + "_change", self, "resource_change")

func _process(_delta: float):
  text = comma_sep(globals[resource])
  
func resource_change(value: int) -> void:
  var n = notification.instance()
  n.amount = value
  add_child(n)
