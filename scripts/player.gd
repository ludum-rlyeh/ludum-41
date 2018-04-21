extends Node

var hand = []
var deck
var playFunction

func _init(var name, var playFunction, var deck, var starting_hand_size):
	self.name = name
	self.playFunction = playFunction
	self.deck = deck
	# pick starting hand size cards for the hand
	deck.draw_cards(starting_hand_size)
	
func add_card_to_hand(var card):
	self.hand.append(card)

func draw_card_from_deck():
	var card = self.deck.pick_first()
	if card != null:
		add_card_from_hand(card)
		return card
	else:
		print("The deck is empty")
		return null

func find_card_index(var card):
	for i in range(self.hand.size()):
		if self.hand[i] != null && self.hand[i].id == card.id:
			return i
	return -1

func pick_card(var card):
	var card_index = find_card_index(card)
	if card_index != -1:
		hand.remove(card_index)
		return true
	else:
		return false

