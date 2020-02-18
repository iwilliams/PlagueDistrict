extends Control

export (int) var amount = 0

onready var animation_player := get_node("AnimationPlayer")
onready var sign_minus = get_node("SignMinus")
onready var sign_plus = get_node("SignPlus")
onready var value := get_node("Value")

func _ready():
  value.text = str(abs(amount))
  if amount > 0:
    sign_plus.visible = true
    value.add_color_override("font_color", Color(0.0, 1.0, 0.0))
  else:
    sign_minus.visible = true
    value.add_color_override("font_color", Color(1.0, 0.0, 0.0))
  animation_player.play("fade")
  animation_player.connect("animation_finished", self, "remove")

func remove(_animation_name):
  print("remove")
  get_parent().remove_child(self)
