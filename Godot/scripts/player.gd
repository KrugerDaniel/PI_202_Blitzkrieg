extends KinematicBody2D

const GRAVITY = 800
const UP = Vector2(0, -1)
const VELOCITY = 140
const JUMP_VELOCITY = -350
const SHOT = preload("res://scenes/shot.tscn")
const SHOTUPDOWN = preload("res://scenes/shotUpDown.tscn")

var movimento = Vector2()
var is_dead = false

func _ready():
	pass 

func _physics_process(delta):
	
	if is_dead == false:
	
		if !is_on_floor():
			movimento.y += GRAVITY * delta
			
		if Input.is_action_pressed("ui_right"):
			movimento.x = VELOCITY
			if Input.is_action_pressed("mirar_up"):
				$AnimatedSprite.play("run_up")
				$AnimatedSprite.flip_h = false
				if sign($PositionLado.position.x) == -1:
					$PositionLado.position.x *= -1
			else:
				$AnimatedSprite.play("run")
				$AnimatedSprite.flip_h = false
				if sign($PositionLado.position.x) == -1:
					$PositionLado.position.x *= -1
		elif Input.is_action_pressed("ui_left"):
			movimento.x = -VELOCITY
			if Input.is_action_pressed("mirar_up"):
				$AnimatedSprite.play("run_up")
				$AnimatedSprite.flip_h = true
				if sign($PositionLado.position.x) == 1:
					$PositionLado.position.x *= -1
			else:
				$AnimatedSprite.play("run")
				$AnimatedSprite.flip_h = true
				if sign($PositionLado.position.x) == 1:
					$PositionLado.position.x *= -1
		else:
			if Input.is_action_pressed("mirar_up"):
				$AnimatedSprite.play("stoped_up")
			else:
				$AnimatedSprite.play("stoped")
			movimento.x = 0
			
		if Input.is_action_just_pressed("atirar") and Input.is_action_pressed("mirar_up"):
			var shotUpDown = SHOTUPDOWN.instance()
			get_parent().add_child(shotUpDown)
			shotUpDown.position = $PositionUP.global_position
			
		elif Input.is_action_just_pressed("atirar"):
			var shot = SHOT.instance()
			if sign($PositionLado.position.x) == 1:
				shot.set_shot_direction(1)
			else:
				shot.set_shot_direction(-1)
			get_parent().add_child(shot)
			shot.position = $PositionLado.global_position
		
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			movimento.y = JUMP_VELOCITY
			
		movimento = move_and_slide(movimento, UP)
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "KinematicBody2D" in get_slide_collision(i).collider.name:
					dead()

func dead():
	is_dead = true
	movimento = Vector2(0, 0)
	"""
	$AnimatedSprite.play(""dead"")
	"""
	$CollisionShape2D.set_deferred("disabled", true)


func _on_Timer_timeout():
	# get_tree().change_scene("TitleScreen.tscn")
	pass
