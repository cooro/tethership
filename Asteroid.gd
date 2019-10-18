extends Area2D

var speed
var direction
var rot_speed

func _ready():
	#rot_speed = rand_range(0, 5)
	rot_speed = 5

func _process(delta):
	rotation += rot_speed * delta
	var velocity = 3
	position += velocity 
