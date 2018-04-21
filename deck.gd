extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var size = 0
onready var label = get_node("deck_size-circle/Label")

func _ready():
	label.set_text(String(size))
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass

func set_size(val):
	size = val
	label.set_text(String(val))

func get_size():
	return size