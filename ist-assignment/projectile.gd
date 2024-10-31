extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


	
func _physics_process(delta: float) -> void:
	#Settign the velocity of the arrow by taking the direction that was fed into by the archer entity 
	velocity = get_meta("Direction") * 500
	velocity.y += 10
	move_and_slide()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	#Checking if the arrrow entered any nodes if its the tilemap then destory it if its the player then damage and then destroy
	if body.name == "TileMap":
		queue_free()
	if body.name == "Player":
		queue_free()
		print(body.get_meta("Health"))
		if body.get_meta("Parry") == false:
			body.set_meta("Health",body.get_meta("Health")-20)
			
			
