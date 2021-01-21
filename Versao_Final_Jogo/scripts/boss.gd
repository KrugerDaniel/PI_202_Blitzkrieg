extends KinematicBody2D

onready var Player = get_parent().get_node("player")

const GRAVITY = 800
const SPEED = 25
const FLOOR = Vector2(0, -1)
const SHOT = preload("res://scenes/ShotEnemy.tscn")

var velocity = Vector2()
var is_dead = false
var hp = 20

var react_time = 400
var dir = 1
var next_dir = 0
var next_dir_time = 0
var last_dir
var player_close = true

var timeout
var time_out = 3

var target_player_dist = 1

func _ready():
	$AnimatedSprite2.visible = false

func set_dir(target_dir):
	if next_dir != target_dir:
		next_dir = target_dir
		next_dir_time = OS.get_ticks_msec()

func _physics_process(delta):
	if !is_dead:

		if !is_on_floor():
			velocity.y += GRAVITY * delta

		if Player.position.x < position.x:
			set_dir(-1)
		if Player.position.x > position.x:
			set_dir(1)

		if OS.get_ticks_msec() > next_dir_time:
			last_dir = dir
			dir = next_dir

		velocity.x = dir * (SPEED + 30)

		if dir == -1:
			$AnimatedSprite2.play("Run")
			$AnimatedSprite.visible = false
			$AnimatedSprite2.visible = true
			if sign($Particles2D.position.x) == 1:
				$Position2D.position.x *= -1
		elif dir == 1:
			$AnimatedSprite.play("Run")
			$AnimatedSprite2.visible = false
			$AnimatedSprite.visible = true
			if sign($Particles2D.position.x) == -1:
				$Position2D.position.x *= -1

		else:
			if last_dir == -1:
				$AnimatedSprite2.play("Stopped")
			else:
				$AnimatedSprite.play("Stopped")

		velocity = move_and_slide(velocity, FLOOR)
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

func received_damage():
	hp -= 1
	if hp <= 0:
		dead()

func fire():
	if player_close:
		var shot = SHOT.instance()
		if dir == -1:
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *= -1
			shot.set_shot_direction(-1)
		else:
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
			shot.set_shot_direction(1)
		shot.shot_boss()
		shot.position = $Position2D.global_position
		get_parent().add_child(shot)
		time_out -= 1
		if time_out < 1:
			player_close = false
			$Timer2.start()

func _on_TimerShot_timeout():
	fire()

func _on_Timer_timeout():
	timeout = get_tree().change_scene("res://scenes/TitleScreen.tscn")
	queue_free()

func _on_Timer2_timeout():
	time_out = 3
	player_close = true

func _on_VisibilityNotifier2D_screen_entered():
	$TimerShot.start()
