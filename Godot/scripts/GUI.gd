extends Control

var hp = 3

func _ready():
	$AnimatedSprite.play("FullHeart")

func damage(_damage):
	hp -= 1
	if hp == 2:
		$AnimatedSprite.play("MiddleHeart")
	if hp == 1:
		$AnimatedSprite.play("LastHeart")
	if hp == 0:
		$AnimatedSprite.play("NoMoreHeart")
