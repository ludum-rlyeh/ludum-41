extends Control

const HAND_PATH = "res://scripts/hand.gd"
const HAND_CLASS = preload(HAND_PATH)

const portrait = preload("res://scenes/ThatGirl.tscn")

var port
var texture_path

var likes = ["guitar"]
var hand = []
var deck

func _process(delta):
	var engine = self.get_tree().get_root().get_node("engine")
	
	if engine.gauge.interest >= 60 and port.get_node("./AnimationPlayer").get_current_animation() != 'HAPPY':
		port.get_node("./AnimationPlayer").play("HAPPY")
	elif (engine.gauge.interest >= 40 and engine.gauge.interest < 60) and port.get_node("./AnimationPlayer").get_current_animation() != 'IDLE':
		port.get_node("./AnimationPlayer").play("IDLE")
	elif engine.gauge.interest < 40 and port.get_node("./AnimationPlayer").get_current_animation() != 'BORED':
		port.get_node("./AnimationPlayer").play("BORED")

func _init(var texture_path, var deck, var starting_hand_size):
	
	self.name = "opponent"

	self.texture_path = texture_path
	
	self.deck = deck
	# pick starting hand size cards for the hand
	for i in range(starting_hand_size) :
		draw_card_from_deck()
	

func _ready():
	self.port = portrait.instance()
	port.get_node("./AnimationPlayer").play("IDLE")
	
	var texture_size = port.get_node('./Sprite').get_texture().get_size()
	var viewport_size = get_viewport().get_size()
	
	self.set_position(Vector2(viewport_size.x / 2 , 
	texture_size.y / 2))
	
	add_child(port)
	

# behaviour fonction of the opponent
func play(var table):
	randomize()
	var random_card = randi() % self.hand.size()
	
	return self.hand[random_card]

func draw_card_from_deck():
	var card = self.deck.draw_first_card()
	
	if card != null:
		self.hand.append(card)
	else:
		print("The opponent's deck is empty")
		
	return card
