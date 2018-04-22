extends Control

signal play_card

var id
var effects = []
var is_inside

var size_container
var container

var last_depth

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
#	var layout_size = get_parent().get_size()
#	var scale_factor_texture
#	if texture_rect.get_texture().get_size().y < layout_size.y:
#		scale_factor_texture = texture_rect.get_texture().get_size().y / layout_size.y
#	else:
#		scale_factor_texture = layout_size.y / texture_rect.get_texture().get_size().y
#	texture_rect.set_scale(Vector2(scale_factor_texture, scale_factor_texture))
#	self.set_custom_minimum_size(Vector2(get_parent().get_size().x/10.0, get_parent().get_size().y ))
	resize_card(viewport_size, 1.0)
	self.size_container = get_parent().get_size()
	texture_rect.connect("mouse_entered", self, "on_mouse_entered_in_card")
	texture_rect.connect("mouse_exited", self, "on_mouse_exited_from_card")
	self.connect("play_card", self.get_tree().get_root().get_node("engine"), "on_played_card")

func resize_card(var viewport_size, var scale_factor):
	var texture_rect = get_node("textureRect")
	var layout_size = get_parent().get_size()
	var scale_factor_texture
	if texture_rect.get_texture().get_size().y < layout_size.y:
		scale_factor_texture = texture_rect.get_texture().get_size().y / layout_size.y
	else:
		scale_factor_texture = layout_size.y / texture_rect.get_texture().get_size().y
	texture_rect.set_scale(Vector2(scale_factor_texture, scale_factor_texture))
	self.set_custom_minimum_size(Vector2(get_parent().get_size().x/10.0, get_parent().get_size().y ))
	self.set_size(Vector2(get_parent().get_size().x/10.0, get_parent().get_size().y ))

#func on_resized():
#	print("size")
#	resize_card(self.get_node("textureRect"), get_viewport().get_size(), 1.0)
	
	
func on_mouse_entered_in_card():
	if !self.is_inside:
		call_deferred("extract_from_container")
		#resize_card(self.get_node("textureRect"), get_viewport().get_size(), 1.1)
		self.is_inside = true

func extract_from_container():
	#TODO : be careful, here it's not very clean...
	var position = self.get_position() + get_parent().get_parent().get_parent().get_position()
	self.container = self.get_parent()
	self.last_depth = self.get_index()
	var engine = self.get_tree().get_root().get_node("engine")
	self.container.remove_child(self)
	engine.add_child(self)
	self.set_position(position)
	self.set_scale(Vector2(1.1, 1.1))

func on_mouse_exited_from_card():
	if self.is_inside:
		call_deferred("insert_in_container")
		#resize_card(self.get_node("textureRect"), get_viewport().get_size(), 1.0)
	self.is_inside = false

func insert_in_container():
	get_parent().remove_child(self)
	self.set_scale(Vector2(1.0, 1.0))
	container.add_child(self)
	container.move_child(self, self.last_depth)
	
func _input(event):
	if self.is_inside and event.is_action_released("ui_accept"):
		self.is_inside = false
		print("take")
		emit_signal("play_card", self)
		get_parent().remove_child(self)
		