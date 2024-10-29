extends CharacterBody2D
var StartPos = global_position
@export  var Shapecast: ShapeCast2D
@export var Area2d: Area2D
@onready var Projectile = get_node("CharacterBody2D")
var Entered = false
@export var DeathTimer: Timer
@export var StunTimer: Timer
var PlayerLoc = Vector2.ZERO
var PlayerBody2D = CharacterBody2D
var onlyonce = false
var onlyonce2 = false 
var temphealth = 100
@export var AnimatedSprite: AnimatedSprite2D 
var scene = load("res://Projectile.tscn")
var gettinghit = false
func _physics_process(delta):
	
	if temphealth != get_meta("Health"):
		temphealth = get_meta("Health")
		AnimatedSprite.play("Archer-Hurt")
		gettinghit = true
	elif onlyonce2 == false:
		StunTimer.start(0.3)
		
	

	print(get_meta("Health"))
	if get_meta("Health") <= 0:
		AnimatedSprite.play("Archer-Death")
		if onlyonce == false:
			onlyonce = true
			DeathTimer.start(0.7)
			
	move_and_slide()
	
	








	


func _on_timer_timeout():
	if Shapecast.get_collider(0) and get_meta("Health") > 0  and gettinghit == false:
		AnimatedSprite.play("Archer-Shoot")
		var dupe = scene.instantiate()
		add_child(dupe)
		dupe.global_position = global_position
		dupe.set_meta("Direction",(Shapecast.get_collider(0).get_node("CollisionShape2D").global_position - get_node("CollisionShape2D").global_position).normalized())
		
	
		


func _on_death_timer_timeout() -> void:
	print("kAKLakAKA")
	queue_free()


func _on_stun_timer_timeout() -> void:
	gettinghit = false
	onlyonce2 = false
