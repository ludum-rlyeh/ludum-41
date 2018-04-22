extends Control

const nb_cards_in_historic = 5
var cards = []

const RELATIVE_POSITION = Vector2(0, 0.5)
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
	for i in range(self.names.size()):
		self.containers[self.names[i]] = HBoxContainer.new()
		self.containers[self.names[i]].set_custom_minimum_size(viewport_size * RELATIVE_SIZE)
		self.containers[self.names[i]].set_size(viewport_size * RELATIVE_SIZE)
		self.containers[self.names[i]].set_position(Vector2(viewport_size.x * RELATIVE_POSITION.x, viewport_size.y * RELATIVE_POSITION.y - viewport_size.y * RELATIVE_SIZE.y + (self.names.size() - 1 - i) * RELATIVE_SIZE.y * viewport_size.y))
		add_child(self.containers[self.names[i]])

func add_card(var card, var player):
	print("HISTORIC ADD CARD : ", card.name)
	self.cards.append({"card": card, "player": player})
	call_deferred("update_view")

func update_view():
	var last = self.cards.back()
	print(last)
	self.containers[last.player.get_name()].add_child(last.card)
	last.card.resize_card(get_viewport().get_size(), 1.0, 0.25)
	last.card.set_block_signals(true)
	var children = last.card.get_children()
	for child in children:
		child.set_block_signals(true)
	while self.containers[last.player.get_name()].get_child_count() > nb_cards_in_historic :
		self.containers[last.player.get_name()].remove_child(self.containers.get_child(0))
		