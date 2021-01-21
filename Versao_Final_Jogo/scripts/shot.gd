extends Area2D

var speed = 300
var velocity = Vector2()
var direction = 1

func _ready():
	pass
	
func set_shot_direction(dir):
	direction = dir
	
func _physics_process(delta):
	velocity.x = speed * delta * direction
	translate(velocity)
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Area2D_body_entered(body):
	if "enemyStrong" in body.name:
		body.received_damage()
	elif "enemy" in body.name:
		body.dead()
	elif "boss" in body.name:
		body.received_damage()
	queue_free()
