extends PanelContainer

onready var title : Label = self.find_node("Title")
onready var description : Label = self.find_node("Description")
onready var picture : TextureRect = self.find_node("Picture")
onready var accept_button : Button = self.find_node("Accept")
onready var decline_button : Button = self.find_node("Decline")

func _ready():
  Globals.connect("event", self, "event")
  accept_button.connect("button_down", self, "accept")
  decline_button.connect("button_down", self, "decline")
  visible = false
  if Globals.current_event:
    event(Globals.current_event)

func event(event : Event) -> void:
  title.text = event.title
  description.text = event.description
  picture.texture = event.picture
  accept_button.visible = event.can_accept
  decline_button.visible = event.can_decline
  Globals.pause()
  visible = true
  anchor_top = .5
  anchor_right = .5
  anchor_bottom = .5
  anchor_left = .5
  
func accept():
  Globals.click_sound.play()
  var didAccept = Globals.event_accept()
  if didAccept:
    visible = false
    Globals.resume()
  
func decline():
  Globals.click_sound.play()
  var didDecline = Globals.event_decline()
  if didDecline:
    visible = false
    Globals.resume()
