extends Node2D

const TABLE_PATH = "table.gd"
const TABLE_CLASS = preload(TABLE_PATH)

const CARD_PATH = "card.gd"
const CARD_CLASS = preload(CARD_PATH)

const DECK_PATH = "deck.gd"
const DECK_CLASS = preload(DECK_PATH)

func _ready():
	var table = TABLE_CLASS.new(10, "player_1", "player_2")
	var card = CARD_CLASS.new(0, "test_name")
	
	table.print_table()
	
	table.add_card("player_1", card)
	table.print_table()
	
	table.add_card("player_2", card)
	table.print_table()
	
	table.remove_card("player_1", card)
	table.print_table()
	
	table.clear_side("player_2")
	table.print_table()
	
	var cards = []
	for i in range(10):
		cards.append(CARD_CLASS.new(i, "test_name"))
	
	var deck = DECK_CLASS.new(cards, false)
	deck.print_cards()
	
	var hand = deck.draw_cards(5)
	for card in hand:
		card.print_card()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
