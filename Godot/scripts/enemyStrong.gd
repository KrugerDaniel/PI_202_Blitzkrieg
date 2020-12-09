extends KinematicBody2D

onready var Player = get_parent().get_node("player")

const GRAVITY = 800
const SPEED = 45
const FLOOR = Vector2(0, -1)
const SHOT = preload("res://scenes/ShotEnemy.tscn")

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
	$AnimatedSprite2.visible = false
	$Particles2D.emitting = true
	$CollisionShape2D.set_deferred("disabled", true)
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	$TimerShot.stop()
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
				if dir == 1:
					print("Oi")
				else:
					print("Olá")
				dir *= -1
				$RayCast2D.position.x *= -1
				$Position2D.position.x *= -1
				
			if not $RayCast2D.is_colliding():
				dir *= -1
				$RayCast2D.position.x *= -1
				$Position2D.position.x *= -1
			
			if dir != sign($RayCast2D.position.x):
				$RayCast2D.position.x *= -1
				$Position2D.position.x *= -1
			
		if dir == -1:
			print(1)
			if sign($Position2D.position.x) == 1:
				$RayCast2D.position.x *= -1
				$Position2D.position.x *= -1
			$AnimatedSprite2.play("Run")
			$AnimatedSprite.visible = false
			$AnimatedSprite2.visible = true
		else:
			print(2)
			if sign($Position2D.position.x) == -1:
				$RayCast2D.position.x *= -1
				$Position2D.position.x *= -1
			$AnimatedSprite.play("Run")
			$AnimatedSprite2.visible = false
			$AnimatedSprite.visible = true
		
		velocity = move_and_slide(velocity, FLOOR)
					
func received_damage():
	hp -= 1
	if hp <= 0:
		dead()
		
func _on_Timer_timeout():
	queue_free()

func _on_Detectar_player_body_entered(_body):
	pass
	#player_close = true

func _on_Detectar_player_body_exited(_body):
	player_close = false

func fire():
	var shot = SHOT.instance()
	if dir == -1:
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
		shot.set_shot_direction(-1)
	else:
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
		shot.set_shot_direction(1)
	shot.shot_enemy()
	shot.position = $Position2D.global_position
	get_parent().add_child(shot)
	$TimerShot.set_wait_time(0.5)

func _on_TimerShot_timeout():
	if player_close:
		fire()
