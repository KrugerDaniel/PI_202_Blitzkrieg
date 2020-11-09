extends Area2D

const SPEED = 300
var velocity = Vector2()
var direction = 1

func _ready():
	pass
	
func set_shot_direction(dir):
	direction = dir

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Area2D_body_entered(body):
	if "KinematicBody2D" in body.name:
		body.dead()
	if "player" in body.name:
		body.received_damage()
	queue_free()