extends Control

func _ready():
	$AnimatedSprite.play("FullHeart")

func damage(hp):
	if hp == 2:
		$AnimatedSprite.play("MiddleHeart")
	if hp == 1:
		$AnimatedSprite.play("LastHeart")
	if hp == 0:
		$AnimatedSprite.play("NoMoreHeart")
