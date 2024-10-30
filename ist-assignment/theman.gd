extends CharacterBody2D
var StartPos = global_position
@export  var Shapecast: ShapeCast2D
@export var Area2d: Area2D
@export var AnimatedSprite: AnimatedSprite2D
@export var StunTimer: Timer
@export var SlashingTimer: Timer
@export var DelayTimer: Timer
@export var DeathTimer: Timer
@export var Timer1: Timer
var Entered = false
var PlayerLoc = Vector2.ZERO
var PlayerBody2D = CharacterBody2D
var temphealth = 100
var gettinghit 
var onlyonce2 = false
var slashing = false 
var onlyonce = false
var onlyonce3 = false
var onlyonce4 = false
var onlyonce5 = false 
func _process(delta):
	gettinghit = get_meta("GettingHit")
	
	if gettinghit == true and onlyonce5 == false and get_meta("Health") > 0:
		AnimatedSprite.play("Sword-enemy-Hurt")
		StunTimer.start(0.4)
		onlyonce5 = true
		
	#print(AnimatedSprite.animation)
	if Entered == true and gettinghit == false and slashing == false  and get_meta("Health") > 0 and onlyonce4 == false :
		onlyonce4 =  true
		print("AahHAHa")
		slashing = true
		SlashingTimer.start(1)
		DelayTimer.start(0.8)
		AnimatedSprite.play("Sword-enemy-Slash")
		
		Timer1.start(2)
		print("Take Damage")
		
	
		
	elif onlyonce2 == false:
		onlyonce2 = true
		StunTimer.start(0.5)
	
	if get_meta("Health") <= 0:
		
		
		
		if onlyonce == false:
			onlyonce = true
			AnimatedSprite.cancel_free()
			AnimatedSprite.play("Sword-enemy-Death")
			DeathTimer.start(1.5)
	
	if gettinghit == false:
		var direction = (Shapecast.get_collision_point(0)-global_position).normalized()
		velocity.x = direction.x * 300
		velocity.y = 500
	
	
	if velocity.x <= 0 and get_meta("Health") > 0 and gettinghit == false:
		AnimatedSprite.flip_h = true
	elif gettinghit == false :
		AnimatedSprite.flip_h = false
	if velocity.x >= -5 and velocity.x <= 0   and get_meta("Health") > 0 and gettinghit == false :
	
		AnimatedSprite.play("Sword-enemy-Idle")
	if gettinghit == false and slashing == false and get_meta("Health") > 0 :
	
		AnimatedSprite.play("Sword-enemy-Run")
		
	

	move_and_slide()




func _on_area_2d_body_entered(body):
	
	if body.name == "Player":
			Entered = true





func _on_area_2d_body_exited(body):
	if body.name == "Player":
		Entered = false



func _on_timer_timeout():
	onlyonce4 = false
	


func _on_stun_timer_timeout() -> void:
	set_meta("GettingHit",false)
	onlyonce5 = false


func _on_slashing_timer_timeout() -> void:

	slashing = false


func _on_damage_delay_timeout() -> void:
	if Shapecast.get_collider(0) and Entered == true and gettinghit == false:
		print(Shapecast.get_collider(0).get_meta("Health"))
		if Shapecast.get_collider(0).get_meta("Parry") == false:
			Shapecast.get_collider(0).set_meta("Health",Shapecast.get_collider(0).get_meta("Health")-20)


func _on_death_timer_timeout() -> void:
	print("kAKLakAKA")
	queue_free()
