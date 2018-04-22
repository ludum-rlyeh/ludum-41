extends Control

const nb_cards_in_historic = 5
var cards = []

func _init():
	self.name = "historic"
	var container = HBoxContainer.new()
	container.set_name("container")
	add_child(container)

func _ready():
	var container = self.get_node("./container")
	var viewport_size = get_viewport().get_size()
	container.set_custom_minimum_size(Vector2(viewport_size.x * 0.5, viewport_size.y + 0.5))
	container.set_size(Vector2(viewport_size.x * 0.5, viewport_size.y + 0.5))
	container.set_alignment(BoxContainer.ALIGN_CENTER)
	
	self.set_position(Vector2(0, viewport_size.y * 0.25))


func add_card(var card, var player):
	
	print("HISTORIC ADD CARD : ", card.name)
	
	self.cards.append({"card": card, "player": player})
	
	call_deferred("update_view")

func update_view():
	
	var container = self.get_node("./container")
	if container.get_child_count() == nb_cards_in_historic :
		container.get_child(0).queue_free()
	
	var last = self.cards.back()
	
	container.add_child(last["card"])
	container.print_tree()
	