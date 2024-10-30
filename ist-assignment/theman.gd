extends CharacterBody2D
var StartPos = global_position
@export  var Shapecast: ShapeCast2D
@export var Area2d: Area2D
@export var AnimatedSprite: AnimatedSprite2D
@export var StunTimer: Timer
@export var SlashingTimer: Timer
@export var DelayTimer: Timer
@export var DeathTimer: Timer
var Entered = false
var PlayerLoc = Vector2.ZERO
var PlayerBody2D = CharacterBody2D
var temphealth = 100
var gettinghit = false
var onlyonce2 = false
var slashing = false 
var onlyonce = false
var onlyonce3 = false
func _physics_process(delta):
	
	if temphealth != get_meta("Health")   and get_meta("Health") >= 0:
		temphealth = get_meta("Health")
		AnimatedSprite.play("Sword-enemy-Hurt")
		gettinghit = true
		onlyonce2 = true
	elif onlyonce2 == false:
		StunTimer.start(0.5)
	
	
	
	var direction = (Shapecast.get_collision_point(0)-global_position).normalized()
	velocity.x = direction.x * 300
	velocity.y = 500
	
	if velocity.x <= 0 and get_meta("Health") >= 0:
		AnimatedSprite.flip_h = true
	else:
		AnimatedSprite.flip_h = false
	if velocity.x >= -5 and velocity.x <= 0   and get_meta("Health") >= 0 :
	
		AnimatedSprite.play("Sword-enemy-Idle")
	elif gettinghit == false and slashing == false and get_meta("Health") >= 0:
		
		AnimatedSprite.play("Sword-enemy-Run")
		
	if get_meta("Health") <= 0:
		
		
		AnimatedSprite.play("Sword-enemy-Death")
		if onlyonce == false:
			onlyonce = true
			DeathTimer.start(1.5)

	move_and_slide()




func _on_area_2d_body_entered(body):
	
	if body.name == "Player":
			Entered = true





func _on_area_2d_body_exited(body):
	if body.name == "Player":
		Entered = false



func _on_timer_timeout():
	
	if Entered == true and gettinghit == false and slashing == false  and get_meta("Health") >= 0 :
		print("AahHAHa")
		slashing = true
		SlashingTimer.start(1)
		DelayTimer.start(0.8)
		AnimatedSprite.play("Sword-enemy-Slash")
		
		
		print("Take Damage")


func _on_stun_timer_timeout() -> void:
	gettinghit = false
	onlyonce2 = false


func _on_slashing_timer_timeout() -> void:

	slashing = false


func _on_damage_delay_timeout() -> void:
	if Shapecast.get_collider(0) and Entered == true:
		print(Shapecast.get_collider(0).get_meta("Health"))
		Shapecast.get_collider(0).set_meta("Health",Shapecast.get_collider(0).get_meta("Health")-20)


func _on_death_timer_timeout() -> void:
	print("kAKLakAKA")
	queue_free()
