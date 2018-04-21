extends Node2D

const TABLE_PATH = "table.gd"
const TABLE_CLASS = preload(TABLE_PATH)

const PLAYER_PATH = "player.gd"
const PLAYER_CLASS = preload(PLAYER_PATH)

const CARD_PATH = "card.gd"
const CARD_CLASS = preload(CARD_PATH)

const DECK_PATH = "deck.gd"
const DECK_CLASS = preload(DECK_PATH)

const CARD_EFFECTS_PATH = "card_effects.gd"
const CARD_EFFECTS_CLASS = preload(CARD_EFFECTS_PATH)

const gauge_load = preload ("res://scenes/gauge.tscn")
onready var gauge =  gauge_load.instance()

var table
var scence_size

func _ready():
	scence_size = get_viewport().get_visible_rect().size
	
	gauge.set_position(Vector2(0.9* scence_size.x, 0.1 * scence_size.y))
	add_child(gauge)
	
	
	var table = TABLE_CLASS.new(10, "player_1", "player_2")
	var card_effects = CARD_EFFECTS_CLASS.new()
	
	# TEST
	#example of effects written in the card_effects script named function01
	var effect_init = funcref(card_effects, "function01")
	var card = CARD_CLASS.new(0, "test_name", [effect_init])
	
	table.print_table()
	
	table.add_card("player_1", card)
	table.print_table()
	
	table.add_card("player_2", card)
	table.print_table()
	
	table.remove_card("player_1", card)
	table.print_table()
	
	var cards = []
	for i in range(10):
		cards.append(CARD_CLASS.new(i, "test_name", [effect_init]))
	
	var deck = DECK_CLASS.new(cards, false)
	deck.print_cards()
	
	var hand = deck.draw_cards(5)
	for card in hand:
		card.print_card()
		
		
	var effects = card.get_effects()
	for effect in effects:
		effect.call_func(table)
	
	var player = PLAYER_CLASS.new("philippe", deck, 5)
	add_child(player)

func _process(delta):
#	gauge.set_interest(delta + gauge.get_interest())

	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass
