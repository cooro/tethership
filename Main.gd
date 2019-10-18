extends Node2D

var screen_size

onready var asteroid = preload("res://Asteroid.tscn")
onready var objects = get_node("Objects")

func _ready():
	screen_size = get_viewport_rect().size

func _on_Timer_timeout():
	var a = asteroid.instance()
	objects.add_child(a)
	var side = rand_range(0, 4)
	if side < 1:
		a.position = Vector2(-32, rand_range(0, screen_size.y))
		
	elif side < 2:
		a.position = Vector2(screen_size.x + 32, rand_range(0, screen_size.y))
	elif side < 3:
		a.position = Vector2(rand_range(0, screen_size.x), -32)
	else:
		a.position = Vector2(rand_range(0, screen_size.x), screen_size.y + 32)
