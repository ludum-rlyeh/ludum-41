extends Node

const HAND_PATH = "res://scripts/hand.gd"
const HAND_CLASS = preload(HAND_PATH)

var hand
var deck

func _init(var name, var deck, var starting_hand_size):
	self.name = name
	
	self.hand = HAND_CLASS.new()
	add_child(self.hand)
	
	self.deck = deck
	# pick starting hand size cards for the hand
	
	for i in range(starting_hand_size) :
		draw_card_from_deck()
	

func draw_card_from_deck():
	var card = self.deck.draw_first_card()
	
	if card != null:
		self.hand.add_card(card)
	else:
		print("The deck is empty")
		
	return card

