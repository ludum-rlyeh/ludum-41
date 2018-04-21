extends Node

var id

func print_card():
	print("[ " , self.id , ", " , self.name + " ]")

func _init(var id, var name):
	self.id = id
	self.name = name

#func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
#	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
