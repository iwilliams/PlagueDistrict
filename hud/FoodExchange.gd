extends VBoxContainer

onready var buy_price = find_node("BuyPrice")
onready var buy_button : Button = find_node("Buy")
onready var sell_price = find_node("SellPrice")
onready var sell_button : Button = find_node("Sell")

func _ready():
  buy_button.connect("button_down", self, "buy")
  sell_button.connect("button_down", self, "sell")
  Globals.connect("food_change", self, "value_change")
  Globals.connect("money_change", self, "value_change")
  Globals.connect("cost_of_food_in_money_change", self, "set_prices_and_buttons")
  Globals.connect("cost_of_money_in_food_change", self, "set_prices_and_buttons")
  set_prices_and_buttons()

func value_change(value) -> void:
  set_prices_and_buttons()
  
func buy() -> void:
  Globals.money -= Globals.cost_of_food_in_money
  Globals.food += 100
  pass
  
func sell() -> void:
  Globals.money += Globals.cost_of_money_in_food
  Globals.food -= 100
  pass
  
func set_prices_and_buttons() -> void:
  buy_price.text = "$" + str(Globals.cost_of_food_in_money)
  sell_price.text = "$" + str(Globals.cost_of_money_in_food)
  buy_button.disabled = Globals.money < Globals.cost_of_food_in_money
  sell_button.disabled = Globals.food < 100
  
