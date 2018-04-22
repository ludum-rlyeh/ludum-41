extends Control

signal play_card

var id
var effects = []
var is_inside

#AHHHHHH it's ugly, but it's the lonely solution for the moment ...
const SCALE_VIEWPORT = 0.3

func print_card():
	print("[ " , self.id , ", " , self.name + " ]")


func _init(var id, var name, var effects):
	self.effects = effects
	self.id = id
	self.name = name
	self.is_inside = false

func get_effects():
	return effects

func _ready():
	print("Card ", self.id, " instanced")
	var viewport_size = get_viewport().get_size()
	var texture_rect = TextureRect.new()
	texture_rect.set_name("textureRect")
	texture_rect.set_texture(load("res://assets/pictures/card_argument.png"))
	add_child(texture_rect)
	
	var scale_factor
	if texture_rect.get_texture().get_size().y < (viewport_size.y * SCALE_VIEWPORT):
		scale_factor = texture_rect.get_texture().get_size().y / (viewport_size.y * SCALE_VIEWPORT)
	else:
		scale_factor = (viewport_size.y * SCALE_VIEWPORT) / texture_rect.get_texture().get_size().y
	print("viewport : ", viewport_size)
	print("scale factor", Vector2(scale_factor, scale_factor))
	print("texture : ", texture_rect.get_texture().get_size())
	texture_rect.set_scale(Vector2(scale_factor, scale_factor))
	self.set_custom_minimum_size(texture_rect.get_texture().get_size() * Vector2(scale_factor, scale_factor))
	texture_rect.connect("mouse_entered", self, "on_mouse_entered_in_card")
	texture_rect.connect("mouse_exited", self, "on_mouse_exited_from_card")
	self.connect("play_card", self.get_tree().get_root().get_node("engine"), "on_played_card")
		
func resize_card(var texture_rect, var viewport_size, scale_factor_viewport):
	var scale_factor
	if texture_rect.get_texture().get_size().y < (viewport_size.y * scale_factor_viewport):
		scale_factor = texture_rect.get_texture().get_size().y / (viewport_size.y * scale_factor_viewport)
	else:
		scale_factor = (viewport_size.y * scale_factor_viewport) / texture_rect.get_texture().get_size().y
	print("viewport : ", viewport_size)
	print("scale factor", Vector2(scale_factor, scale_factor))
	print("texture : ", texture_rect.get_texture().get_size())
	texture_rect.set_scale(Vector2(scale_factor, scale_factor))
	self.set_custom_minimum_size(texture_rect.get_texture().get_size() * Vector2(scale_factor, scale_factor))

#func on_resized():
#	print("size")
#	resize_card(self.get_node("textureRect"), get_viewport().get_size(), SCALE_VIEWPORT)
	
func on_mouse_entered_in_card():
	resize_card(self.get_node("textureRect"), get_viewport().get_size(), SCALE_VIEWPORT+0.1)
	self.is_inside = true

func on_mouse_exited_from_card():
	resize_card(self.get_node("textureRect"), get_viewport().get_size(), SCALE_VIEWPORT)
	self.is_inside = false

func _input(event):
	if self.is_inside and event.is_action_released("ui_accept"):
		resize_card(self.get_node("textureRect"), get_viewport().get_size(), SCALE_VIEWPORT)
		self.is_inside = false
		emit_signal("play_card", self)
		get_parent().remove_child(self)
		