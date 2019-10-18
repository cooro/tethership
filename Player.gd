extends Area2D

export var speed = 200  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.

func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite.play()

func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	velocity.y -= 1
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)