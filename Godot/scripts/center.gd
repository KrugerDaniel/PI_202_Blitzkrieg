extends Node2D

var connected

func _ready():
	connected = $player.connect("damage", $CanvasLayer/GUI, "damage")
	
	var screen_size = OS.get_screen_size(0)
	var window_size = OS.get_window_size()

	OS.set_window_position(screen_size*0.5 - window_size*0.5)