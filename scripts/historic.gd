extends Control

const nb_cards_in_historic = 5
var cards = []

const RELATIVE_POSITION = Vector2(0,0.5)
const RELATIVE_SIZE = Vector2(0.2, 0.2)

func _init():
	self.name = "historic"

func _ready():
	#creation container
	var container = HBoxContainer.new()
	container.set_name("container")
	var viewport_size = get_viewport().get_size()
	container.set_custom_minimum_size(viewport_size * RELATIVE_SIZE)
	container.set_size(viewport_size * RELATIVE_SIZE)
	container.set_alignment(BoxContainer.ALIGN_CENTER)
	self.set_position(viewport_size * RELATIVE_POSITION)
	add_child(container)

func add_card(var card, var player):
	print("HISTORIC ADD CARD : ", card.name)
	self.cards.append({"card": card, "player": player})
	call_deferred("update_view")

func update_view():
	var container = self.get_node("./container")
	var last = self.cards.back()
	container.add_child(last.card)
	last.card.resize_card(get_viewport().get_size(), 1.0)
	last.card.set_block_signals(true)
	var children = last.card.get_children()
	for child in children:
		child.set_block_signals(true)
	print("nombre de cartes dans l'historique ", container.get_child_count())
	while container.get_child_count() > nb_cards_in_historic :
		container.remove_child(container.get_child(0))
		