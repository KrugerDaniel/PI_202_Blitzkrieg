extends KinematicBody2D

const GRAVITY = 800
const UP = Vector2(0, -1)
const VELOCITY = 120
const JUMP_VELOCITY = -350
const SHOT = preload("res://scenes/shot.tscn")
const SHOTUPDOWN = preload("res://scenes/shotUpDown.tscn")

var movimento = Vector2()
var is_dead = false
var hp = 3
var colisorDano = false
var timeout

signal damage

func _ready():
	$AnimatedSprite.play("stoped")

func _physics_process(delta):
	
	if is_dead == false:
	
		if !is_on_floor():
			movimento.y += GRAVITY * delta
			
		if Input.is_action_pressed("ui_right"):
			movimento.x = VELOCITY
			if sign($PositionLado.position.x) == -1:
				$PositionLado.position.x *= -1
			if sign($PositionUP.position.x) == 1:
				$PositionUP.position.x *= -1
			if Input.is_action_pressed("mirar_up"):
				$AnimatedSprite.play("run_up")
				$AnimatedSprite.flip_h = false
			else:
				$AnimatedSprite.play("run")
				$AnimatedSprite.flip_h = false
		elif Input.is_action_pressed("ui_left"):
			movimento.x = -VELOCITY
			if sign($PositionLado.position.x) == 1:
				$PositionLado.position.x *= -1
			if sign($PositionUP.position.x) == -1:
				$PositionUP.position.x *= -1
			if Input.is_action_pressed("mirar_up"):
				$AnimatedSprite.play("run_up")
				$AnimatedSprite.flip_h = true
			else:
				$AnimatedSprite.play("run")
				$AnimatedSprite.flip_h = true
		else:
			if Input.is_action_pressed("mirar_up"):
				$AnimatedSprite.play("stoped_up")
			else:
				$AnimatedSprite.play("stoped")
			movimento.x = 0
			
		if Input.is_action_just_pressed("atirar") and Input.is_action_pressed("mirar_up"):
			var shotUpDown = SHOTUPDOWN.instance()
			shotUpDown.position = $PositionUP.global_position
			get_parent().add_child(shotUpDown)
			
		elif Input.is_action_just_pressed("atirar"):
			var shot = SHOT.instance()
			if sign($PositionLado.position.x) == 1:
				shot.set_shot_direction(1)
			else:
				shot.set_shot_direction(-1)
			shot.position = $PositionLado.global_position
			get_parent().add_child(shot)
		
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			movimento.y = JUMP_VELOCITY
			
		movimento = move_and_slide(movimento, UP)
		
		if hp <= 0:
			dead()
			
func received_damage():
	if $TimerInvencible.time_left == 0:
		$TimerInvencible.start()
		hp -= 1
		emit_signal("damage", hp)
			
func dead():
	is_dead = true
	movimento = Vector2(0, 0)
	$AnimatedSprite.visible = false
	$Particles2D.emitting = true
	$CollisionShape2D.set_deferred("disabled", true)
	$Timer.start()

func _on_Timer_timeout():
	timeout = get_tree().reload_current_scene()


func _on_Area2D_area_entered(_area):
	received_damage()
