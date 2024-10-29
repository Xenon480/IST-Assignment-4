extends CharacterBody2D
var StartPos = global_position
@export  var Shapecast: ShapeCast2D
@export var Area2d: Area2D
@onready var Projectile = get_node("CharacterBody2D")
var Entered = false
var PlayerLoc = Vector2.ZERO
var PlayerBody2D = CharacterBody2D
@export var AnimatedSprite: AnimatedSprite2D 
var scene = load("res://Projectile.tscn")
func _physics_process(delta):
	

	

	
		
	move_and_slide()
	
	








	


func _on_timer_timeout():
	if Shapecast.get_collider(0):
		AnimatedSprite.play("Archer-Shoot")
		var dupe = scene.instantiate()
		add_child(dupe)
		dupe.global_position = global_position
		dupe.set_meta("Direction",Shapecast.get_collider(0).global_position - global_position)
		
	
		
