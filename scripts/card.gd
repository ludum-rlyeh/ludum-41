extends Control

var id
var effects = []

#AHHHHHH it's ugly, but it's the lonely solution for the moment ...
const SCALE_VIEWPORT = 0.3

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
	var viewport_size = get_viewport().get_size()
	var texture_rect = TextureRect.new()
	texture_rect.set_name("textureRect")
	texture_rect.set_texture(load("res://assets/pictures/card_argument.png"))
	print(get_parent().get_size())
	var scale_factor
	if texture_rect.get_texture().get_size().y < (viewport_size.y * SCALE_VIEWPORT):
		scale_factor = texture_rect.get_texture().get_size().y / (viewport_size.y * SCALE_VIEWPORT)
	else:
		scale_factor = (viewport_size.y * SCALE_VIEWPORT) / texture_rect.get_texture().get_size().y
	print(scale_factor)
	texture_rect.set_scale(Vector2(scale_factor, scale_factor))
	self.set_custom_minimum_size(texture_rect.get_texture().get_size() * Vector2(scale_factor, scale_factor))
	add_child(texture_rect)
	
	# TODO : resize texture