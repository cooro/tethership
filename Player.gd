extends Area2D

signal collision

var screen_size  # Size of the game window.

export (int) var max_speed  # maximum speed of the ship
export (int) var acceleration  # how fast the ship gains speed
var speed = 0 # speed of the ship
var velocity = Vector2()

func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite.play()

func _process(delta):
	var yank = Vector2(0, 0)
	## Rotation Code
	if Input.is_action_pressed('click'):
		var touch_pos = get_global_mouse_position()
		var ship_to_touch = (touch_pos - position).normalized()  # direction from the ship to the touchpoint
		var direction = Vector2(cos(rotation), sin(rotation))  # front-back distiction
		var side_direction = Vector2(cos(rotation - PI/2), sin(rotation - PI/2))  # left-right distinction
		if ship_to_touch.dot(direction) <= 0:  # only pull if the ship is past the touchpoint
			if ship_to_touch.dot(side_direction) > 0:
				rotation = ship_to_touch.angle() + PI/2  # keep the ship perpendicular to the mouse
			else:
				rotation = ship_to_touch.angle() - PI/2  # same, but for the other side
			var new_direction = Vector2(cos(rotation), sin(rotation))
			yank = direction - new_direction  # this value slows the ship when the change is big
			if yank.length() < 0.1:
				yank = Vector2(0, 0)  # if yank is small, make it zero
		
		## Rope Code
		get_parent().get_node("Rope").set_point_position(0, position)
		get_parent().get_node("Rope").set_point_position(1, touch_pos)
	else:
		get_parent().get_node("Rope").set_point_position(0, Vector2(-10, -10))
		get_parent().get_node("Rope").set_point_position(1, Vector2(-10, -10))
	
	## Acceleration Code
	speed = speed - (speed * yank.length()/2)
	speed = speed + acceleration * delta
	if speed > max_speed:
		speed = max_speed
	
	velocity = Vector2(speed * delta, 0).rotated(rotation)
	
	position += velocity
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func lose():
	get_tree().change_scene("Title.tscn")

func _on_Player_area_entered(area):
	if area.z_index == 2:
		emit_signal("collision")
		lose()