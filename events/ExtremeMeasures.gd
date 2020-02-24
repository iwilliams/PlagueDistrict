extends Event

export (float) var percent_population_decrease := .3

func enabled_get():
  return Globals.moral <= Globals.MORAL_DESPAIR

func accept():
  Globals.population *= 1 - percent_population_decrease
  Globals.moral = Globals.MORAL_NORMAL
