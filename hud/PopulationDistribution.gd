extends VBoxContainer

onready var globals = get_node("/root/Globals")

onready var residential_slider := get_node("Residential/HSlider")
onready var residential_percent_label := get_node("Residential/HBoxContainer/Percent")
onready var residential_tmp : float = globals.residential_percent

onready var medical_slider = get_node("Medical/HSlider")
onready var medical_percent_label = get_node("Medical/HBoxContainer/Percent")
onready var medical_tmp : float = globals.medical_percent

onready var commerce_slider = get_node("Commerce/HSlider")
onready var commerce_percent_label = get_node("Commerce/HBoxContainer/Percent")
onready var commerce_tmp : float = globals.commerce_percent

onready var agriculture_slider = get_node("Agriculture/HSlider")
onready var agriculture_percent_label = get_node("Agriculture/HBoxContainer/Percent")
onready var agriculture_tmp : float = globals.agriculture_percent

onready var government_slider = get_node("Government/HSlider")
onready var government_percent_label = get_node("Government/HBoxContainer/Percent")
onready var government_tmp : float = globals.government_percent

onready var total_label = get_node("HBoxContainer/Total")

onready var reset_button = get_node("HBoxContainer/Reset")
onready var apply_button = get_node("HBoxContainer/Apply")

func _ready():
  reset()
  reset_button.connect("button_down", self, "reset")
  apply_button.connect("button_down", self, "apply")
  for district in globals.districts:
    self[district + "_slider"].connect("value_changed", self, "set_district_tmp", [district])

func set_buttons_and_total():
  var apply_disabled = true
  var total_percent = 0
  for district in globals.districts:
    apply_disabled = apply_disabled \
      && self[district + "_tmp"] == globals[district + "_percent"]
    total_percent += self[district + "_tmp"]
  apply_button.disabled = apply_disabled || total_percent > 1
  total_label.text = "Total: " + str(total_percent*100) + "%"
  if total_percent > 1:
    total_label.add_color_override("font_color", Color(1, 0, 0))
  else:
    total_label.add_color_override("font_color", Color(1, 1, 1))

func reset() -> void:
  for district in globals.districts:
    self[district + "_slider"].value = globals[district + "_percent"] * 100
    self[district + "_percent_label"].text = str(globals[district + "_percent"] * 100) + "%"
  set_buttons_and_total()
  
func apply() -> void:
  for district in globals.districts:
    globals[district + "_percent"] = self[district + "_tmp"]
  set_buttons_and_total()
  
func set_district_tmp(value : float, district : String) -> void:
  self[district + "_tmp"] = value/100
  self[district + "_percent_label"].text = str(value) + "%"
  set_buttons_and_total()
