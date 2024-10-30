extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


	
func _physics_process(delta: float) -> void:
	
	velocity = get_meta("Direction") * 500
	velocity.y += 10
	move_and_slide()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
		
	if body.name == "TileMap":
		queue_free()
	if body.name == "Player":
		print(body.get_meta("Health"))
		if body.get_meta("Parry") == false:
			body.set_meta("Health",body.get_meta("Health")-20)
