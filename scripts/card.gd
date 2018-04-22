extends Control

signal play_card

var id
var effects = []
var is_inside

var size_container

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
	
	
	#resize cards to be contained in the hboxcontainer
	var layout_size = get_parent().get_size()
	var scale_factor_texture
	if texture_rect.get_texture().get_size().y < layout_size.y:
		scale_factor_texture = texture_rect.get_texture().get_size().y / layout_size.y
	else:
		scale_factor_texture = layout_size.y / texture_rect.get_texture().get_size().y
	texture_rect.set_scale(Vector2(scale_factor_texture, scale_factor_texture))
	self.set_custom_minimum_size(Vector2(get_parent().get_size().x/10.0, get_parent().get_size().y ))
	
	
	self.size_container = get_parent().get_size()
	print("size_container ", size_container)
	texture_rect.connect("mouse_entered", self, "on_mouse_entered_in_card")
	texture_rect.connect("mouse_exited", self, "on_mouse_exited_from_card")
	self.connect("play_card", self.get_tree().get_root().get_node("engine"), "on_played_card")

func resize_card(var texture_rect, var viewport_size, var scale_factor):
	var layout_size = get_parent().get_size()
	var scale_factor_texture
	if texture_rect.get_texture().get_size().y < layout_size.y:
		scale_factor_texture = texture_rect.get_texture().get_size().y / layout_size.y
	else:
		scale_factor_texture = layout_size.y / texture_rect.get_texture().get_size().y
	scale_factor_texture *= scale_factor
	texture_rect.set_scale(Vector2(scale_factor_texture, scale_factor_texture))
	if scale_factor > 1:
		self.set_size(Vector2(get_parent().get_size().x/10.0, get_parent().get_size().y *  scale_factor))
	else:
		self.set_size(Vector2(self.size_container.x/10.0, self.size_container.y *  scale_factor))

#func on_resized():
#	print("size")
#	resize_card(self.get_node("textureRect"), get_viewport().get_size(), 1.0)
	
	
func on_mouse_entered_in_card():
	print("enter")
	resize_card(self.get_node("textureRect"), get_viewport().get_size(), 1.1)
	self.is_inside = true

func on_mouse_exited_from_card():
	print("exit")
	resize_card(self.get_node("textureRect"), get_viewport().get_size(), 1.0)
	self.is_inside = false

func _input(event):
	if self.is_inside and event.is_action_released("ui_accept"):
		resize_card(self.get_node("textureRect"), get_viewport().get_size(), 1.0)
		self.is_inside = false
		emit_signal("play_card", self)
		get_parent().remove_child(self)
		