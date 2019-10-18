extends Area2D

var screen_size  # Size of the game window.

export (int) var max_speed  # maximum speed of the ship
var speed  # speed of the ship
var rotation_speed  # speed of ship's rotation
var velocity = Vector2()

func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite.play()

func _process(delta):
	var touch_pos
	if Input.is_action_pressed('click'):
		touch_pos = get_global_mouse_position()
		var angle_to_touch = position.angle_to(touch_pos)
		var adjusted_angle = angle_to_touch - rotation
		
	
	rotation += rotation_speed * delta
	
	velocity = Vector2()
	velocity = Vector2(speed * delta, 0).rotated(rotation)
	
	position += velocity
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)