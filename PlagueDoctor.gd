extends Event

export (float) var success_percent := .5
export (float) var increase_percent := 3.0
export (int) var increase_cost := 100
export (float) var decrease_percent := 0.60
export (int) var decrease_cost := 50

func accept():
  randomize()
  var success := success_percent >= randf()
  if success:
    Globals.max_cure_per_day *= increase_percent
    Globals.money -= increase_cost
  else:
    Globals.max_cure_per_day *= decrease_percent
    Globals.money -= decrease_cost
