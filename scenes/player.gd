extends KinematicBody2D

const GRAVITY = 380
const UP = Vector2(0, -1)
const SPEED = 100
const JUMP = 180

var motion = Vector2()
var dir = 1

func _ready():
	pass 

func _physics_process(delta):
	if !is_on_floor():
		motion.y += GRAVITY * delta
		
	if Input.is_action_pressed("ui_right"):
		dir = 1
		motion.x = SPEED * dir
	elif Input.is_action_pressed("ui_left"):
		dir = -1
		motion.x = SPEED * dir
	else:
		dir = 0
		motion.x = SPEED * dir
		
	if Input.is_action_just_pressed("ui_accept"):
		motion.y = -JUMP
		
	move_and_slide(motion, UP)
