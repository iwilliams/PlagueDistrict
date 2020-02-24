extends Event

export (float) var money_threshold := 1000

func enabled_get():
  return Globals.money < money_threshold && Globals.moral <= Globals.MORAL_SAD

func accept():
  Globals.can_reasign_population = false
  apply_accept_buff()
