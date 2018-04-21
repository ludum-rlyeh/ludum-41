extends Node

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