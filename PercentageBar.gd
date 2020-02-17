extends ProgressBar

onready var globals = get_node("/root/Globals")

func _process(_delta : float):
  value = globals.infection_percent*100
