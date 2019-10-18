extends Area2D

var screen_size  # Size of the game window.

export (int) var max_speed  # maximum speed of the ship
export (int) var acceleration  # how fast the ship gains speed
var speed = 0 # speed of the ship
var velocity = Vector2()

func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite.play()

func _process(delta):
	var yank = 0
	## Rotation Code
	if Input.is_action_pressed('click'):
		var touch_pos = get_global_mouse_position()
		var old_rotation
		var ship_to_touch = (touch_pos - position).normalized()
		var direction = Vector2(cos(rotation - PI/2), sin(rotation - PI/2))
		if ship_to_touch.dot(direction) > 0:
			yank = abs(rotation - ship_to_touch.angle() + PI/2)/(2*PI)
			rotation = ship_to_touch.angle() + PI/2  # keep the ship perpendicular to the mouse
			#yank = abs(old_rotation - rotation)  # yank is the difference of the old and new angles
		else:
			rotation = ship_to_touch.angle() - PI/2  # same, but for the other side
			#yank = abs(old_rotation - rotation)  # yank is the difference of the old and new angles
	
	## Acceleration Code
	speed = speed + acceleration * delta
	if speed > max_speed:
		speed = max_speed
	
	velocity = Vector2(speed * delta, 0).rotated(rotation)
	
	position += velocity
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)