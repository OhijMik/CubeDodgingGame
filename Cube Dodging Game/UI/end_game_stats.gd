extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Round " + str(Game.game_round) + "       Points: " + str(Game.points) + "\n"
	if Game.game_round > Game.top_round:
		Game.top_round = Game.game_round
		text += "\n" + "Highest round: " + str(Game.top_round) + "  new highscore!!"
	else:
		text += "\n" + "Highest round: " + str(Game.top_round)
		
	if Game.points > Game.top_points:
		Game.top_points = Game.points
		text += "\n" + "Highest points: " + str(Game.top_points) + "  new highscore!!"
	else:
		text += "\n" + "Highest points: " + str(Game.top_points)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
