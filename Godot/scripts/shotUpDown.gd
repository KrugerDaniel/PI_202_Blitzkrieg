extends Area2D

const SPEED = 300
var velocity = Vector2()
var direction = -1

func _ready():
	pass

func _physics_process(delta):
	velocity.y = SPEED * delta * direction
	translate(velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_shotUpDown_body_entered(body):
	if "KinematicBody2D" in body.name:
		body.dead()
		queue_free()
