extends Control

const nb_cards_in_historic = 5
var cards = []

const RELATIVE_POSITION = Vector2(0,0.5)
const RELATIVE_SIZE = Vector2(0.2, 0.2)

var containers = {}
var names = []

func _init(var player, var opponent):
	self.name = "historic"
	self.names.append(player.get_name())
	self.names.append(opponent.get_name())

func _ready():
	var viewport_size = get_viewport().get_size()
	
	#creation container opponent
#	for i in range(self.containers.get_size()):
#		container[self.names[i]] = HBoxContainer.new()
#		containers[self.names[1]] = HBoxContainer.new()
#	var container.append(containers[self.names[0]])
#	container.append(containers[self.names[1]])
#	for 
#	container0.set_custom_minimum_size(viewport_size * RELATIVE_SIZE)
#	container0.set_size(viewport_size * RELATIVE_SIZE)
#	container0.set_alignment(BoxContainer.ALIGN_CENTER)
#	add_child(container0)
#	container1.set_custom_minimum_size(viewport_size * RELATIVE_SIZE)
#	container1.set_size(viewport_size * RELATIVE_SIZE)
#	container1.set_alignment(BoxContainer.ALIGN_CENTER)
#	self.container_opponent(viewport_size * (Vector2(RELATIVE_POSITION.x, RELATIVE_POSITION.y + RELATIVE_SIZE.y)
#	add_child(container0)
#
#	#creation container opponent
#	var container_player = HBoxContainer.new()
#	container_player.set_name("containerPlayer")
#	var viewport_size = get_viewport().get_size()
#	container_player.set_custom_minimum_size(viewport_size * RELATIVE_SIZE)
#	container_player.set_size(viewport_size * RELATIVE_SIZE)
#	container_player.set_alignment(BoxContainer.ALIGN_CENTER)
#	self.set_position(viewport_size * RELATIVE_POSITION)
#	add_child(container_player)

func add_card(var card, var player):
	print("HISTORIC ADD CARD : ", card.name)
	self.cards.append({"card": card, "player": player})
	call_deferred("update_view")

func update_view():
	var container = self.get_node("./containerOpponent")
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
		