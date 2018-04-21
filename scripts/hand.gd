extends Node2D

var cards = []

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func add_card(var card):
	add_child(card) #call _ready function of card
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
