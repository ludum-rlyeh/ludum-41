#to be generic all functions need to take the same input like the table, and the players
# TODO : write an engine class


# play guitar depends on if the opponent likes guitar or not
func i_play_guitar(var engine):
	
	# sfx !!
	var sfx_player = engine.get_node("./sfx_player")
	sfx_player.set_stream(load("res://assets/sounds/holee.wav"))
	sfx_player.play()
	
	# Do the effect
	var opponent = engine.get_node("./opponent")
	if opponent.likes.has("guitar") :
		engine.gauge.increase_interest(10)
	else :
		engine.gauge.decrease_interest(10)

func function01(var engine):
	print("FUNCTION : ", engine)


