extends CenterContainer

onready var happy : Label = get_node("Happy")
onready var normal : Label = get_node("Normal")
onready var sad : Label = get_node("Sad")
onready var despair : Label = get_node("Despair")

func _ready():
  Globals.connect("moral_change", self, "set_icon")
  set_icon()

func set_icon() -> void:
  happy.visible = false
  normal.visible = false
  sad.visible = false
  despair.visible = false
  
  if Globals.moral >= Globals.MORAL_HAPPY:
    happy.visible = true
    hint_tooltip = "The population's moral is positive."
  elif Globals.moral >= Globals.MORAL_NORMAL:
    normal.visible = true
    hint_tooltip = "The population's moral is neutral."
  elif Globals.moral >= Globals.MORAL_SAD:
    sad.visible = true
    hint_tooltip = "The population's moral is low."
  else:
    despair.visible = true
    hint_tooltip = "The population's moral is abysmal."
  hint_tooltip += '\nMorality effects district efficiency.'
