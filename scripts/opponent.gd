extends Control

const HAND_PATH = "res://scripts/hand.gd"
const HAND_CLASS = preload(HAND_PATH)

var texture_path

var likes = []
var hand = []
var deck


func _init(var texture_path, var deck, var starting_hand_size):
	
	self.name = "opponent"
	
	self.texture_path = texture_path
	
	self.deck = deck
	# pick starting hand size cards for the hand
	for i in range(starting_hand_size) :
		draw_card_from_deck()
	

func _ready():
	var texture_rect = TextureRect.new()
	texture_rect.set_texture(load(self.texture_path))
	
	var texture_size = texture_rect.get_texture().get_size() 
	var viewport_size = get_viewport().get_size()
	
	self.set_position(Vector2(viewport_size.x / 2 - texture_size.x / 2, 
	viewport_size.y / 2 - texture_size.y / 2))
	
	add_child(texture_rect)

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
