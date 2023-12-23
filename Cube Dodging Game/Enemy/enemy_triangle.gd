extends CharacterBody2D

var player
const speed = 180.0

func _ready():
	player = get_node("../../Player")
	var direction = (player.position - self.position).normalized()
	velocity.x = direction.x * speed
	velocity.y = direction.y * speed
	look_at(player.position)


func _physics_process(delta):
	if Game.gamemode == "multiplayer":
		if position.x > 570 and position.x < 580:
			self.queue_free()
		elif position.x <= -10 or position.x >= 1200 or position.y >= 700 or position.y <= -10:
			self.queue_free()
	else:
		if position.x <= -10 or position.x >= 1200 or position.y >= 700 or position.y <= -10:
			self.queue_free()
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		self.queue_free()
		get_tree().change_scene_to_file("res://end_scene.tscn")
