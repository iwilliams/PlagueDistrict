extends Label

onready var globals = get_node("/root/Globals")

export var resource : String

func _process(delta: float):
    text = resource + ": " + str(globals[resource])

