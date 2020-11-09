extends KinematicBody2D

const GRAVITY = 800
const SPEED = 45
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var direction = 1
var is_dead = false

var areaDetectavel = false
var objectPlayer 

func _ready():
	pass
	
func dead():
	is_dead = true
	velocity = Vector2(0, 0)
	$AnimatedSprite.visible = false
	$Particles2D.emitting = true
	$Timer.start()

func _physics_process(delta):
	if is_dead == false:
		velocity.x = SPEED * direction
		
		if !is_on_floor():
			velocity.y += GRAVITY * delta
		
		velocity = move_and_slide(velocity, FLOOR)
	
		if is_on_wall():
			direction *= -1
			$RayCast2D.position.x *= -1
			$AnimatedSprite.play("run")
			if direction == -1:
				$AnimatedSprite.flip_h = true
			else:
				$AnimatedSprite.flip_h = false
			
		if not $RayCast2D.is_colliding():
			direction *= -1
			$RayCast2D.position.x *= -1
			$AnimatedSprite.play("run")
			if direction == -1:
				$AnimatedSprite.flip_h = true
			else:
				$AnimatedSprite.flip_h = false
				
		"""if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "'player'" in get_slide_collision(i).collider.name:
					get_slide_collision(i).collider.received_damage()"""

func _on_Timer_timeout():
	queue_free()