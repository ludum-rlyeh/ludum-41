extends Node2D

# number of remaining cards
var size = 0
#text printing the size on the scene
onready var label = get_node("deck_size-circle/Label")

func _ready():
	label.set_text(String(size))
	pass

#func _process(delta):
#	pass

func set_size(val):
	size = val
	label.set_text(String(val))

func get_size():
	return size