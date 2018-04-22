#to be generic all functions need to take the same input like the table, and the players
# TODO : write an engine class


# play guitar depends on if the opponent likes guitar or not
func play_guitar(var engine):
	
	# sfx !!
	var sfx_player = engine.get_node("./sfx_player")
	sfx_player.set_stream(load("res://assets/sounds/holee.wav"))
	sfx_player.play()


func function01(var engine):
	print("FUNCTION : ", engine)


