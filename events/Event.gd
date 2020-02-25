extends Node

class_name Event

export (String) var title : String
export (String, MULTILINE) var description : String
export (bool) var can_accept : bool = true
export (bool) var can_decline : bool = true
export (Texture) var picture : Texture
export (NodePath) var accept_buff
export (NodePath) var decline_buff

var enabled : bool setget , enabled_get
func enabled_get():
  return true

func accept():
  return true
  
func decline():
  return true
  
func apply_accept_buff():
  if accept_buff:
    var buff : Buff = get_node(accept_buff)
    Globals.possible_buffs.remove_child(buff)
    Globals.active_buffs.add_child(buff)
    accept_buff = null
    
func apply_decline_buff():
  if decline_buff:
    var buff : Buff = get_node(decline_buff)
    Globals.possible_buffs.remove_child(buff)
    Globals.active_buffs.add_child(buff)
    decline_buff = null
