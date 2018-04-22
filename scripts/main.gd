extends Node2D

const TABLE_PATH = "table.gd"
const TABLE_CLASS = preload(TABLE_PATH)

const PLAYER_PATH = "player.gd"
const PLAYER_CLASS = preload(PLAYER_PATH)

const OPPONENT_PATH = "opponent.gd"
const OPPONENT_CLASS = preload(OPPONENT_PATH)

const CARD_PATH = "card.gd"
const CARD_CLASS = preload(CARD_PATH)

const DECK_PATH = "deck.gd"
const DECK_CLASS = preload(DECK_PATH)

const CARD_EFFECTS_PATH = "card_effects.gd"
const CARD_EFFECTS_CLASS = preload(CARD_EFFECTS_PATH)

const HISTORIC_PATH = "historic.gd"
const HISTORIC_CLASS = preload(HISTORIC_PATH)

const gauge_load = preload ("res://scenes/gauge.tscn")
const deck_load = preload("res://scenes/deck_sprite.tscn")
onready var deck = deck_load.instance();
onready var gauge =  gauge_load.instance()

var table
var scene_size


var turn_time = 0
var difficulty = 0.01

const nb_player = 2
var at_player = true # at the opponent if false

func _ready():
	self.set_name("engine")
	scene_size = get_viewport().get_visible_rect().size
	
	
	# place the gauge on the main scene
	gauge.set_position(Vector2(0.9* scene_size.x, 0.1 * scene_size.y))
	gauge.set_interest(100)
	add_child(gauge)

	# place the deck on the main scene
	deck.set_position(Vector2(0.92* scene_size.x, 0.88 * scene_size.y))
	deck.set_scale(0.8*Vector2(1,1))
	add_child(deck)
	
	
	var table = TABLE_CLASS.new(10, "player_1", "player_2")
	var card_effects = CARD_EFFECTS_CLASS.new()
	
	# TEST
	# example of effects written in the card_effects script named function01
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
	
	var cards_op = []
	for i in range(10):
		cards_op.append(CARD_CLASS.new(i, "test_name", [effect_init]))
	
	var deck_op = DECK_CLASS.new(cards_op, false)
	
	var opponent = OPPONENT_CLASS.new("res://assets/pictures/woman_face2.svg", deck_op, 5)
	add_child(opponent)
	
	var player = PLAYER_CLASS.new("philippe", deck)
	add_child(player)
		# pick starting hand size cards for the hand
	for i in range(5) :
		player.draw_card_from_deck()
	
	# create game historic
	add_child(HISTORIC_CLASS.new())


func _process(delta):
	turn_time += delta
	
	gauge.set_interest(gauge.get_interest() - (difficulty*turn_time))
	 
	# bot play
	if not at_player :
		
		# Ask bot to play a card
		var card_played = self.get_node("./opponent").play(self)
		
		bot_play_card(card_played)

# used by bot
func bot_play_card(var card):
	
	# add card to historic
	self.get_node("./historic").add_card(card, at_player)
	
	# change turn
	at_player = true
	
	# Do the effects of the card
	var effects = card.get_effects()
	for effect in effects:
		print(effect)
#		effect.call_func(self)
	

func on_played_card(var card):
	
	if at_player :
		
		# add card to historic
		self.get_node("./historic").add_card(card, at_player)
		
		# at the bot to play
		at_player = false
		
		# Do the effects of the card
		var effects = card.get_effects()
		for effect in effects:
			print(effect)
			# effect.call_func(self)
	else:
		print("not your turn !")
