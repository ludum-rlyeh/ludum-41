extends Node2D

# number of remaining cards
var size = 0
#text printing the size on the scene
#onready var label = get_node("deck_size-circle/Label")
var label

func _ready():
	self.label = get_node("deck_size-circle/Label")
	label.set_text(String(size))

#func _process(delta):
#	pass

func set_size(val):
	size = val
	label.set_text(String(val))

func get_size():
	return size