extends Node2D

const HAND_PATH = "res://scripts/hand.gd"
const HAND_CLASS = preload(HAND_PATH)

#Be careful if you modify here, need to modify in the card.gd script
# modify the SCALE_VIEWPORT like RELATIVE_POSITION.y - RELATIVE_POSITION.y = 0
const RELATIVE_POSITION = Vector2(0, 0.7)

var hand
var deck

func _init(var name, var deck):
	self.name = name
	
	self.hand = HAND_CLASS.new()
	self.deck = deck
	

func draw_card_from_deck():
	var card = self.deck.draw_first_card()
	
	if card != null:
		self.hand.add_card(card)
	else:
		print("The deck is empty")
	return card

func _ready():
	var viewport_size = get_viewport().get_size()
	self.set_position(viewport_size * RELATIVE_POSITION)
	
	add_child(self.hand)
	add_child(self.deck)