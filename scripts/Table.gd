extends Node

var initial_length
var player_1
var player_2

var cards = {player_1: [], player_2: []}

func print_table():
	print("Side " + player_1 + ":")
	for i in range(initial_length):
		if cards.player_1[i] != null:
			cards.player_1[i].print_card()
		else:
			print("[ ]")
	
	print("Side " + player_2 + ":")
	for i in range(initial_length):
		if cards.player_2[i] != null:
			cards.player_2[i].print_card()
		else:
			print("[ ]")

func find_first_empty_index(var array):
	for i in range(array.size()):
		if array[i] == null:
			return i
	return -1

func find_card_index(var side, var card):
	for i in range(self.cards[side].size()):
		if self.cards[side][i] != null && card.id == self.cards[side][i].id:
			return i
	return -1

func add_card(var side, var card):
	var first_empty = find_first_empty_index(self.cards[side])
	if first_empty != -1:
		self.cards[side][first_empty] = card
		return true
	else:
		return false

func remove_card(var side, var card):
	var card_index = find_card_index(side, card)
	if card_index != -1:
		self.cards[side][card_index] = null
		return true
	else:
		return false

func clear_side(var side):
	for i in range(initial_length):
		self.cards[side][i] = null

func _ready():
	pass

func _init(var initial_length, var player_1, var player_2):
	self.initial_length = initial_length
	self.player_1 = player_1
	self.player_2 = player_2
	
	for i in range(self.initial_length):
		self.cards[self.player_1].append(null)
		self.cards[self.player_2].append(null)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
