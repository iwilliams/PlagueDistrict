extends Buff
export (float) var money_threshold := 1000

func every_minute():
  if Globals.money > money_threshold && Globals.moral > Globals.MORAL_SAD:
    Globals.can_reasign_population = true
    get_parent().remove_child(self)
    return
