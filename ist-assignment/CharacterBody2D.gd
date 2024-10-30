extends CharacterBody2D
var StartPos = global_position
@export  var Shapecast: ShapeCast2D
@export var Area2d: Area2D
@onready var Projectile = get_node("CharacterBody2D")
var Entered = false
@export var DeathTimer: Timer
@export var StunTimer: Timer
@export var ArrowTimer: Timer
var PlayerLoc = Vector2.ZERO
var PlayerBody2D = CharacterBody2D
var onlyonce = false
var onlyonce2 = false 
var onlyonce3 = false
var temphealth = 100
@export var AnimatedSprite: AnimatedSprite2D 
var scene = load("res://Projectile.tscn")
var gettinghit = false
func _physics_process(delta):
	print(AnimatedSprite.animation)
	print(gettinghit)
	if temphealth != get_meta("Health"):
		temphealth = get_meta("Health")
		AnimatedSprite.play("Archer-Hurt")
		gettinghit = true
	elif onlyonce2 == false:
		onlyonce2 = true
		StunTimer.start(0.3)
		
	

	
	if get_meta("Health") < 0:
		AnimatedSprite.play("Archer-Death")
		if onlyonce == false:
			onlyonce = true
			DeathTimer.start(0.7)
			
	move_and_slide()
	
	


	if Shapecast.get_collider(0) and get_meta("Health") > 0  and gettinghit == false and onlyonce3 == false:
		ArrowTimer.start(1)
		onlyonce3 = true





	


func _on_timer_timeout():
	onlyonce3 = false
	if Shapecast.get_collider(0) and get_meta("Health") > 0  and gettinghit == false:
		print("AGVYtfkytulewh")
		AnimatedSprite.play("Archer-Shoot")
		var dupe = scene.instantiate()
		add_child(dupe)
		dupe.global_position = global_position
		dupe.set_meta("Direction",(Shapecast.get_collider(0).get_node("CollisionShape2D").global_position - get_node("CollisionShape2D").global_position).normalized())
		dupe.set_meta("Position",Shapecast.get_collider(0).get_node("CollisionShape2D").global_position)
	
		


func _on_death_timer_timeout() -> void:
	print("kAKLakAKA")
	queue_free()


func _on_stun_timer_timeout() -> void:
	gettinghit = false
	onlyonce2 = false
