extends Spatial

func _ready():
  Globals.connect("pause_change", self, "toggle_animation")
  pass
  
func toggle_animation(paused : bool) -> void:
  if paused:
    $AnimationPlayer.stop(false)
  else:
    $AnimationPlayer.play("spin")
