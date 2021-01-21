extends Area2D

var speed
var velocity = Vector2()
var direction = 1

func _ready():
	pass
	
func set_shot_direction(dir):
	direction = dir
	
func shot_enemy():
	speed = 100

func shot_boss():
	speed = 200

func _physics_process(delta):
	velocity.x = speed * delta * direction
	translate(velocity)
	
func _on_VisibilityNotifier2D2_screen_exited():
	queue_free()

func _on_ShotEnemy_body_entered(body):
	if "player" in body.name:
		body.received_damage()
	queue_free()
