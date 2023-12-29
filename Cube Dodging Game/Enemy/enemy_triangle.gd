extends CharacterBody2D

var player
var file = "res://PlayerInfo.txt"
var player2_id


func _ready():
	if Game.gamemode == "singleplayer":
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		velocity.x = direction.x * Game.enemy_triangle_speed
		velocity.y = direction.y * Game.enemy_triangle_speed
		look_at(player.position)
	else:
		if position.x >= 0 and position.x <= 570:
			player = get_node("/root/MultiplayerGameScene/1")
			var direction = (player.position - position).normalized()
			velocity.x = direction.x * Game.enemy_triangle_speed
			velocity.y = direction.y * Game.enemy_triangle_speed
			look_at(player.position)
		else:
			var f = FileAccess.open(file, FileAccess.READ)
			player2_id = f.get_as_text()
			var path = "/root/MultiplayerGameScene/" + player2_id
			f.close()

			player = get_node(path)
			var direction = (player.position - self.position).normalized()
			velocity.x = direction.x * Game.enemy_triangle_speed
			velocity.y = direction.y * Game.enemy_triangle_speed
			look_at(player.position)


func _physics_process(_delta):
	if position.x <= -10 or position.x >= 1200 or position.y >= 700 or position.y <= -10:
		self.queue_free()
		Game.points += 100
		Game.round_points += 100
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.name == "1":
		self.queue_free()
		Game.winner = "player2"
		get_tree().change_scene_to_file("res://end_scene.tscn")
	elif body.name == player2_id:
		self.queue_free()
		Game.winner = "player1"
		get_tree().change_scene_to_file("res://end_scene.tscn")
