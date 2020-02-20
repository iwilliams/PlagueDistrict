extends ProgressBar

export var type = "infection"

onready var globals = get_node("/root/Globals")

func _process(_delta : float):
  value = globals[type + "_percent"]*100
