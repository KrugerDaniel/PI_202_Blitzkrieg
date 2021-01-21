extends Area2D

var change_scene

func _physics_process(_delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "player":
			change_scene = get_tree().change_scene("res://scenes/Fase_2.tscn")
