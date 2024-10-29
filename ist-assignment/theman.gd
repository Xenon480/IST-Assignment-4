extends CharacterBody2D
var StartPos = global_position
@export  var Shapecast: ShapeCast2D
@export var Area2d: Area2D
@export var AnimatedSprite: AnimatedSprite2D
var Entered = false
var PlayerLoc = Vector2.ZERO
var PlayerBody2D = CharacterBody2D

func _physics_process(delta):
	
	var direction = (Shapecast.get_collision_point(0)-global_position).normalized()
	velocity.x = direction.x * 300
	velocity.y = 500
	
	if velocity.x <= 0:
		AnimatedSprite.flip_h = true
	else:
		AnimatedSprite.flip_h = false
	if velocity.x >= -5 and velocity.x <= 0 :
	
		AnimatedSprite.play("default")
	else:
		
		AnimatedSprite.play("Sword-enemy-Run")
	

	move_and_slide()




func _on_area_2d_body_entered(body):
	
	if body.name == "Player":
			Entered = true





func _on_area_2d_body_exited(body):
	if body.name == "Player":
		Entered = false



func _on_timer_timeout():
	
	if Entered == true:
		print("AahHAHa")
		Shapecast.get_collider(0).set_meta("Health",Shapecast.get_collider(0).get_meta("Health")-20)
		print(Shapecast.get_collider(0).get_meta("Health"))
		print("Take Damage")
