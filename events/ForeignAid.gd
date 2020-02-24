extends Event

export (float) var increase_percent = 10
export (int) var cost = 2000

func enabled_get():
  return Globals.money >= cost

func accept():
  Globals.max_cure_per_day *= increase_percent
  Globals.money -= cost
