extends Node2D

var cards = []
func _init():
	self.name = "hand"
	var container = HBoxContainer.new()
	container.set_name("container")
	add_child(container)

func add_card(var card):
	var container = self.get_node("./container")
	container.add_child(card) #call _ready function of card
	self.cards.append(card)


func find_card_index(var card):
	for i in range(self.cards.size()):
		if self.cards[i] != null && self.cards[i].id == card.id:
			return i
	return -1

func pick_card(var card):
	var card_index = find_card_index(card)
	if card_index != -1:
		self.cards.remove(card_index)
		return true
	else:
		return false

func _ready():
	#Try to resize correctly the HBoxLayout child
	var container = self.get_node("./container")
	var viewport_size = get_viewport().get_size()
	var relative_position = get_parent().RELATIVE_POSITION
	container.set_custom_minimum_size(Vector2(viewport_size.x, (1.0 - relative_position.y) * viewport_size.y))
	container.set_size(Vector2(viewport_size.x, (1.0 - relative_position.y) * viewport_size.y))
	container.set_alignment(BoxContainer.ALIGN_CENTER)