extends Label

onready var globals = get_node("/root/Globals")

func _process(_delta : float) -> void:
  text = "Day: " + str(globals.days) \
    + " " + "%02d" % globals.hour \
    + ":" + "%02d" % (globals.minutes \
      - (globals.days*globals.MINUTES_IN_DAY) \
      - (globals.hour*60) \
    )
    
