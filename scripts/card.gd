extends Control

signal play_card

var id
var effects = []
var is_inside

var size_container
var container

var last_depth

var path_graphics_scene

var ghost = Control.new()

func print_card():
	print("[ " , self.id , ", " , self.name + " ]")

func _init(var id, var name, var path_graphics_scene, var effects):
	self.effects = effects
	self.id = id
	self.name = name
	self.is_inside = false
	self.path_graphics_scene = path_graphics_scene

func get_effects():
	return effects

#GRAPHICS PART
func _ready():
	print("Card ", self.id, " instanced")
	var viewport_size = get_viewport().get_size()
	var scene = load(path_graphics_scene).instance()
#	var texture_rect = TextureRect.new()
#	texture_rect.set_name("textureRect")
#	texture_rect.set_texture(load("res://assets/pictures/card_argument.png"))
	add_child(scene)
#	add_child(texture_rect)
	resize_card(viewport_size, 1.0, 0.1)
	self.size_container = get_parent().get_size()
	var texture_rect = self.get_node("textureRect")
	texture_rect.connect("mouse_entered", self, "on_mouse_entered_in_card")
	texture_rect.connect("mouse_exited", self, "on_mouse_exited_from_card")
	self.connect("play_card", self.get_tree().get_root().get_node("engine"), "on_played_card")

func resize_card(var viewport_size, var scale_factor, var between):
	var texture_rect = get_node("textureRect")
	var layout_size = get_parent().get_size()
	var scale_factor_texture
	if texture_rect.get_texture().get_size().y < layout_size.y:
		scale_factor_texture = texture_rect.get_texture().get_size().y / layout_size.y
	else:
		scale_factor_texture = layout_size.y / texture_rect.get_texture().get_size().y
	texture_rect.set_scale(Vector2(scale_factor_texture, scale_factor_texture))
	self.set_custom_minimum_size(Vector2(get_parent().get_size().x * between, get_parent().get_size().y ))
	self.set_size(Vector2(get_parent().get_size().x * between, get_parent().get_size().y ))
	ghost = self.duplicate()
	
func on_mouse_entered_in_card():
	if !self.is_inside:
		print("enter ", self.id)
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
	container.add_child(self.ghost)
	container.move_child(self.ghost, self.last_depth)

func on_mouse_exited_from_card():
	if self.is_inside:
		print("exit ", self.id)
		call_deferred("insert_in_container")
		#resize_card(self.get_node("textureRect"), get_viewport().get_size(), 1.0)
	self.is_inside = false

func insert_in_container():
	get_parent().remove_child(self)
	self.set_scale(Vector2(1.0, 1.0))
	
	container.remove_child(self.ghost)
	container.add_child(self)
	container.move_child(self, self.last_depth)
	
func _input(event):
	if self.is_inside and event.is_action_released("ui_accept"):
		self.is_inside = false
		print("take")
		emit_signal("play_card", self)
		get_parent().remove_child(self.ghost)
		self.ghost.queue_free()
		get_parent().remove_child(self)
		
		