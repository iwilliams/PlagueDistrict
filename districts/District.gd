extends Node2D

onready var button : Button = get_node("Button")
onready var popup : Popup = get_node("Popup")

func _ready():
    button.connect("button_down", popup, "popup")
