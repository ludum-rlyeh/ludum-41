extends Node

var cards = []

func print_cards():
	for card in self.cards:
		card.print_card()

func shuffle():
	var current_max = cards.size() - 1

	for i in range(self.cards.size() - 1):
		var rand = randi()
		var swapped = 0
		
		if current_max != 0:
			swapped = rand % current_max
		
		var old_max = self.cards[current_max]
		self.cards[current_max] = self.cards[swapped]
		self.cards[swapped] = old_max

		current_max -= 1

func draw_cards(var number):
	var cards = []
	
	for i in range(number):
		cards.append(self.cards.pop_front())
	
	return cards

func draw_first_card():
	return self.cards.pop_front()

#
# is_shuffled:
#	false: Shuffles the deck
#	true: Does not shuffle the deck
#
func _init(var cards, var is_shuffled = false):
	randomize()
	self.cards = cards
	
	if !is_shuffled:
		self.shuffle()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
