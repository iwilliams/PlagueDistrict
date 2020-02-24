extends Spatial

onready var globals = get_node("/root/Globals")
onready var button : StaticBody = get_node("QodotMap/entity_0_worldspawn/entity_0_physics_body")
onready var popup : Popup = get_node("Popup")

func _ready():
  #warning-ignore:return_value_discarded
#  button.connect("button_down", popup, "popup")
  button.connect("input_event", self, "clicked")
  globals.connect("every_minute", self, "every_minute")
  globals.connect("every_hour", self, "every_hour")
  globals.connect("every_day", self, "every_day")
  globals.connect("event", self, "close_popup")

func clicked(camera: Node, event: InputEvent, click_position, click_normal, shape_idx) -> void:
  if event is InputEventMouse:
    if event is InputEventMouseButton:
        if event.is_action_pressed('mouse_lmb'):
              popup.popup()

func close_popup(_event : Event) -> void:
  popup.visible = false

func every_minute() -> void:
  pass
  
func every_hour() -> void:
  pass
  
func every_day() -> void:
  pass
