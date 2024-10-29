extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:

	velocity = get_meta("Direction") * 100

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body.name == "TileMap":
		queue_free()
	if body.name == "Player":
		print(body.get_meta("Health"))
		body.set_meta("Health",body.get_meta("Health")-20)
