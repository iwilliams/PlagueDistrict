extends Event

export (float) var success_percent := .5
export (float) var increase_percent := 3.0
export (int) var increase_cost := 100

func accept():
  randomize()
  var success := success_percent >= randf()
  if success:
    Globals.food *= 1 + increase_percent
  else:
    Globals.infection_percent += .15
