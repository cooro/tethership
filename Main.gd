extends Node2D

var screen_size
var intscore = 0
var scoremult = 1

onready var asteroid = preload("res://Asteroid.tscn")
onready var objects = get_node("Objects")

func _ready():
	screen_size = get_viewport_rect().size
	Global.score = 0
	scoremult = 1

func _process(delta):
	Global.score += (delta * scoremult)
	intscore = floor(Global.score)
	get_node("Scoreboard").text = str(intscore)

func _on_Timer_timeout():
	var a = asteroid.instance()
	objects.add_child(a)
	var destination
	var side = rand_range(0, 4)
	if side < 1:  # spawn on the left
		a.position = Vector2(-32, rand_range(0, screen_size.y))
		destination = Vector2(screen_size.x, rand_range(0, screen_size.y))
		a.speed = rand_range(50, 250)
	elif side < 2:  # spawn on the right
		a.position = Vector2(screen_size.x + 32, rand_range(0, screen_size.y))
		destination = Vector2(0, rand_range(0, screen_size.y))
		a.speed = rand_range(50, 250)
	elif side < 3:  # spawn on the top
		a.position = Vector2(rand_range(0, screen_size.x), -32)
		destination = Vector2(rand_range(0, screen_size.x), screen_size.y)
		a.speed = rand_range(50, 250)
	else:  # spawn on the bottom
		a.position = Vector2(rand_range(0, screen_size.x), screen_size.y + 32)
		destination = Vector2(rand_range(0, screen_size.x), 0)
		a.speed = rand_range(50, 250)
	a.direction = (destination - a.position).normalized()

func _on_Player_near_miss():
	scoremult = 5

func _on_Player_safe():
	scoremult = 1
