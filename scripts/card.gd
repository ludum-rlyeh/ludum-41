extends Control

var id
var effects = []



func print_card():
	print("[ " , self.id , ", " , self.name + " ]")


func _init(var id, var name, var effects):
	self.effects = effects
	self.id = id
	self.name = name

func get_effects():
	return effects


func _ready():
	print("Card ", self.id, " instanced")
	var textureRect = TextureRect.new()
	textureRect.set_texture(load("res://assets/pictures/card_argument.png"))
	add_child(textureRect)
	
	# TODO : resize texture
	
	 