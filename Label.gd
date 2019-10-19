extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var screen_size
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	rect_position = Vector2(screen_size.x/2, 64)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
