extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var cursor = get_node("cursor-bar")
onready var gauge = get_node("gauge")

var interest = 0
var local_scale

func _ready():
	local_scale = gauge.get_texture().get_size().y
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	var cursor_center = cursor.get_texture().get_size().y / 2
	cursor.set_position(Vector2(0, local_scale - local_scale *  interest /100 ))
	pass

func increase_interest(var val):
	interest += val
	if (interest > 100):
		interest = 100

func decrease_interest(var val):
	interest -= val
	if (interest < 0):
		interest = 0

func set_interest(var val):
	interest = val
	if (interest < 0) : 
		interest = 0
	if (interest > 100):
		interest = 100
	
func get_interest():
	return interest