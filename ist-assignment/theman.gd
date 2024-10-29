extends CharacterBody2D
var StartPos = global_position
@export  var Shapecast: ShapeCast2D
@export var Area2d: Area2D
@export var AnimatedSprite: AnimatedSprite2D
@export var StunTimer: Timer
var Entered = false
var PlayerLoc = Vector2.ZERO
var PlayerBody2D = CharacterBody2D
var temphealth = 100
var gettinghit = false
var onlyonce2 = false
func _physics_process(delta):
	
	if temphealth != get_meta("Health"):
		temphealth = get_meta("Health")
		AnimatedSprite.play("Sword-enemy-Hurt")
		gettinghit = true
	elif onlyonce2 == false:
		StunTimer.start(0.3)
	
	if get_meta("Health") <= 0:
		queue_free()
	
	var direction = (Shapecast.get_collision_point(0)-global_position).normalized()
	velocity.x = direction.x * 300
	velocity.y = 500
	
	if velocity.x <= 0:
		AnimatedSprite.flip_h = true
	else:
		AnimatedSprite.flip_h = false
	if velocity.x >= -5 and velocity.x <= 0 :
	
		AnimatedSprite.play("default")
	elif gettinghit == false:
		
		AnimatedSprite.play("Sword-enemy-Run")
	

	move_and_slide()




func _on_area_2d_body_entered(body):
	
	if body.name == "Player":
			Entered = true





func _on_area_2d_body_exited(body):
	if body.name == "Player":
		Entered = false



func _on_timer_timeout():
	
	if Entered == true and gettinghit == false:
		print("AahHAHa")
		AnimatedSprite.play("Sword-enemy-Slash")
		Shapecast.get_collider(0).set_meta("Health",Shapecast.get_collider(0).get_meta("Health")-20)
		print(Shapecast.get_collider(0).get_meta("Health"))
		print("Take Damage")


func _on_stun_timer_timeout() -> void:
	gettinghit = false
	onlyonce2 = false
