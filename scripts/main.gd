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

const DECK_OPPONENT_PATH = "deck_opponent.gd"
const DECK_OPPONENT_CLASS = preload(DECK_OPPONENT_PATH)

const CARD_EFFECTS_PATH = "card_effects.gd"
const CARD_EFFECTS_CLASS = preload(CARD_EFFECTS_PATH)

const HISTORIC_PATH = "historic.gd"
const HISTORIC_CLASS = preload(HISTORIC_PATH)

const gauge_load = preload ("res://scenes/gauge.tscn")
onready var gauge =  gauge_load.instance()

var table
var scene_size

var turn_time = 0
var difficulty = 0.01

const nb_player = 2
var at_player = true # at the opponent if false

var player
var opponent

func _ready():
	self.set_name("engine")
	scene_size = get_viewport().get_visible_rect().size
	
	var sfx_player = AudioStreamPlayer.new()
	sfx_player.set_name("sfx_player")
	sfx_player.set_autoplay(true)
	sfx_player.set_volume_db(-10)
	add_child(sfx_player)
	
	# place the gauge on the main scene
	gauge.set_position(Vector2(0.9* scene_size.x, 0.1 * scene_size.y))
	gauge.set_interest(50)
	add_child(gauge)
	
	# TEST
	var table = TABLE_CLASS.new(10, "player_1", "player_2")
	var card_effects = CARD_EFFECTS_CLASS
	# example of effects written in the card_effects script named function01
	var effect_init = funcref(card_effects, "play_guitar")
	
#	var cards = []
#	for i in range(10):
#		cards.append(CARD_CLASS.new(i, "test_name", "testgraphics", [effect_init]))
	
#	var cards_op = []
#	for i in range(10):
#		cards_op.append(CARD_CLASS.new(i, "test_name", "testgraphics", [effect_init]))

	var cards = []
	for i in range(10):
		cards.append(CARD_CLASS.new(i, "test_name", [], "res://scenes/cards/question_whatdoyoulike.tscn"))
		
	var deck_op = DECK_OPPONENT_CLASS.new(cards, false)
	
	self.opponent = OPPONENT_CLASS.new("res://assets/pictures/woman_face2.svg", deck_op, 5)
	add_child(self.opponent)
	
	
	cards = []
	for i in range(10):
		cards.append(CARD_CLASS.new(i, "test_name", [effect_init], "res://scenes/cards/i_play_guitar.tscn"))
	
	var deck = DECK_CLASS.new(cards, false)
	
	self.player = PLAYER_CLASS.new("philippe", deck)
	add_child(self.player)
	
	# pick starting hand size cards for the hand
	for i in range(4) :
		self.player.draw_card_from_deck()
	
	# create game historic
	add_child(HISTORIC_CLASS.new(self.player, self.opponent))


func _process(delta):
	turn_time += delta
	gauge.decrease_interest(difficulty*turn_time)
	 
	# bot play
	if not at_player :
		
		# Ask bot to play a card
		var card_played = self.get_node("./opponent").play(self)
		
		bot_play_card(card_played)
		
		self.player.draw_card_from_deck()

# used by bot
func bot_play_card(var card):
	
	# add card to historic
	self.get_node("./historic").add_card(card, opponent)
	
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
		self.get_node("./historic").add_card(card, player)
		
		# at the bot to play
		at_player = false
		
		# Do the effects of the card
		card.play(self)
		
		var effects = card.get_effects()
		for effect in effects:
			effect.call_func(self)
	else:
		print("not your turn !")
