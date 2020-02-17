extends Label

onready var globals = get_node("/root/Globals")

export var resource : String

func _process(_delta: float):
  text = resource.capitalize() + ": " + str(globals[resource])
