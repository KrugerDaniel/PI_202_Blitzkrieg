extends Control

var type = 1
var notcount = true
var changescene = 0

func _ready():
	var screen_size = OS.get_screen_size(0)
	var window_size = OS.get_window_size()

	OS.set_window_position(screen_size*0.5 - window_size*0.5)
	
	$AnimatedSprite.play("Jogar")
	
func _physics_process(_delta):
	if notcount:
		if Input.is_action_just_pressed("ui_down"):
			type += 1
			$SelectOption.play()
		if Input.is_action_just_pressed("ui_up"):
			type -= 1
			$SelectOption.play()
			
		if type == 0:
			type = 4
		elif type == 5:
			type = 1
		elif type == 1:
			$AnimatedSprite.play("Jogar")
		elif type == 2:
			$AnimatedSprite.play("Controles")
		elif type == 3:
			$AnimatedSprite.play("Creditos")
		else:
			$AnimatedSprite.play("Sair")
			
		if Input.is_action_just_pressed("ui_accept"):
			if type == 1:
				changescene = get_tree().change_scene("res://scenes/Main.tscn")
			elif type == 2:
				$AnimatedSprite.play("Cont")
				notcount = false
			elif type == 3:
				$AnimatedSprite.play("New_Creditos")
				notcount = false
			elif type == 4:
				get_tree().quit()
	else:
		if Input.is_action_just_pressed("ui_accept"):
			type = 1
			notcount = true
