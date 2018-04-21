extends Control

var cards = []

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func add_card(var card, var player):
	
	self.cards.append({"card": card, "player": player})
	
	if self.cards.size() > 5 :
		self.cards.remove(0)
	
	update_view()

func update_view():
	pass