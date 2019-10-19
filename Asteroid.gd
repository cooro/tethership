extends Area2D

var speed
var direction = Vector2()
var rot_speed
var scale_range

func _ready():
	rot_speed = rand_range(-5, 5)
	scale_range = rand_range(1, 4)
	scale = Vector2(scale_range, scale_range)

func _process(delta):
	rotation += rot_speed * delta
	var velocity = Vector2(direction.x * speed * delta, direction.y * speed * delta)
	position += velocity


func _on_Asteroid_area_entered(area):
	if area.z_index == 1:
		queue_free()
