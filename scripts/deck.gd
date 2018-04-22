extends Node

signal change_label_number

const RELATIVE_POSITION = Vector2(0.92,0.88)
const DECK_SCALE = Vector2(0.8,0.8)

const DECK_SPRITE_PATH = "res://scenes/deck_sprite.tscn"

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
	emit_signal("change_label_number", cards.size())
	return cards

func draw_first_card():
	var card = self.cards.pop_front()
	emit_signal("change_label_number", cards.size())
	return card
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
	var viewport_size = get_viewport().get_size()
	var deck_sprite = load(DECK_SPRITE_PATH).instance()
	deck_sprite.set_position(viewport_size * RELATIVE_POSITION)
	deck_sprite.set_scale(DECK_SCALE)
	add_child(deck_sprite)
	self.connect("change_label_number", deck_sprite, "set_size")


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
