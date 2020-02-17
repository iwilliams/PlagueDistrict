extends Label

onready var globals = get_node("/root/Globals")

func _process(_delta : float) -> void:
  text = "Day: " + str(globals.days)
