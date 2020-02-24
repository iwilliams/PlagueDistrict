extends Buff

export (float) var percent_population_decrease = .05
export (float) var percent_moral_increase = .2

func every_day():
  if Globals.moral >= Globals.MORAL_NORMAL:
    get_parent().remove_child(self)
    return
  Globals.population *= 1.0 - percent_population_decrease
  Globals.moral *= 1 + percent_moral_increase
