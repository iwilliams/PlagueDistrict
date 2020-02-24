extends Event

export (float) var percent_cost := .20

func enabled_get():
  return Globals.moral <= Globals.MORAL_DESPAIR

func accept():
  apply_accept_buff()
