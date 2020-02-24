extends Event

export (int) var cost = 1000

func enabled_get():
  return Globals.food <= 1000

func accept():
  Globals.food += 1000
  Globals.agriculture_percent = max(0, Globals.agriculture_percent - .1)
  Globals.residential_percent = max(0, Globals.residential_percent - .1)
  Globals.medical_percent = max(0, Globals.medical_percent - .1)
  Globals.government_percent = max(0, Globals.government_percent - .1)
  Globals.commerce_percent = max(0, Globals.commerce_percent - .1)
