extends CharacterBody2D

var player

func _ready():
	player = get_node("../../Player/Player")
	var direction = (player.position - self.position).normalized()
	velocity.x = direction.x * Game.enemy_triangle_speed
	velocity.y = direction.y * Game.enemy_triangle_speed
	look_at(player.position)


func _physics_process(_delta):
	if Game.gamemode == "multiplayer":
		if position.x > 570 and position.x < 580:
			self.queue_free()
		elif position.x <= -10 or position.x >= 1200 or position.y >= 700 or position.y <= -10:
			self.queue_free()
	else:
		if position.x <= -10 or position.x >= 1200 or position.y >= 700 or position.y <= -10:
			self.queue_free()
			Game.points += 100
			Game.round_points += 100
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		self.queue_free()
		get_tree().change_scene_to_file("res://end_scene.tscn")
