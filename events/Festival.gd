extends Event

export (int) var food_cost = 5000

func enabled_get():
  return Globals.food >= food_cost \
    && Globals.moral < Globals.MORAL_HAPPY

func accept():
  Globals.food -= food_cost
  Globals.moral += 1.0
