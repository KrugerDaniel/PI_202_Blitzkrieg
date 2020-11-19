extends KinematicBody2D

onready var Player = get_parent().get_node("player")

const GRAVITY = 800
const SPEED = 45
const FLOOR = Vector2(0, -1)
const SHOT = preload("res://scenes/shot.tscn")

var velocity = Vector2()
var is_dead = false
var hp = 2
var player_close = false

var react_time = 400
var dir = 1
var next_dir = 0
var next_dir_time = 0

var target_player_dist = 1

func _ready():
	$AnimatedSprite2.visible = false
	
func dead():
	is_dead = true
	velocity = Vector2(0, 0)
	$AnimatedSprite.visible = false
	$Particles2D.emitting = true
	$CollisionShape2D.set_deferred("disabled", true)
	$Timer.start()
	
func set_dir(target_dir):
	if next_dir != target_dir:
		next_dir = target_dir
		next_dir_time = OS.get_ticks_msec()

func _physics_process(delta):
	if !is_dead:
		
		if !is_on_floor():
			velocity.y += GRAVITY * delta
		
		if player_close:
			
			if Player.position.x < position.x:
				set_dir(-1)
			if Player.position.x > position.x:
				set_dir(1)
				
			if OS.get_ticks_msec() > next_dir_time:
				dir = next_dir
				
			velocity.x = dir * (SPEED + 30)
			
		else:
			velocity.x = SPEED * dir
		
			if is_on_wall():
				dir *= -1
				
			if not $RayCast2D.is_colliding():
				dir *= -1
				$RayCast2D.position.x *= -1
				$Position2D.position.x *= -1
				
			if dir != sign($RayCast2D.position.x):
				$RayCast2D.position.x *= -1
				$Position2D.position.x *= -1
				
		if dir == -1:
			$AnimatedSprite2.play("Run")
			$AnimatedSprite.visible = false
			$AnimatedSprite2.visible = true
			if sign($Particles2D.position.x) == 1:
				$RayCast2D.position.x *= -1
				$Position2D.position.x *= -1
		else:
			$AnimatedSprite.play("Run")
			$AnimatedSprite2.visible = false
			$AnimatedSprite.visible = true
			if sign($Particles2D.position.x) == -1:
				$RayCast2D.position.x *= -1
				$Position2D.position.x *= -1
		
		velocity = move_and_slide(velocity, FLOOR)
					
func received_damage():
	hp -= 1
	if hp <= 0:
		dead()
		
func _on_Timer_timeout():
	queue_free()

func _on_Detectar_player_body_entered(_body):
	player_close = true

func _on_Detectar_player_body_exited(_body):
	player_close = false

func fire():
	var shot = SHOT.instance()
	if sign($Position2D.position.x) == 1:
		shot.set_shot_direction(1)
	else:
		shot.set_shot_direction(-1)
	shot.shot_enemy()
	shot.position = $Position2D.global_position
	get_parent().add_child(shot)
	$TimerShot.set_wait_time(0.5)

func _on_TimerShot_timeout():
	if player_close:
		fire()
