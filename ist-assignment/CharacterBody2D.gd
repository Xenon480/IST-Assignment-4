extends CharacterBody2D
var StartPos = global_position
@export  var Shapecast: ShapeCast2D
@export var Area2d: Area2D
@onready var Projectile = get_node("CharacterBody2D")
var Entered = false
var PlayerLoc = Vector2.ZERO
var PlayerBody2D = CharacterBody2D
var scene = load("res://Projectile.tscn")
func _physics_process(delta):
	

	var direction = (Shapecast.get_collision_point(0)-global_position).normalized()
	velocity.x = direction.x * 300
	velocity.y = 500

	
		
	move_and_slide()
	
	


func _on_area_2d_body_entered(body):
	if body.name == "CharacterBody2D2":
			Entered = true





func _on_area_2d_body_exited(body):
	if body.name == "CharacterBody2D2":
		Entered = false
	


func _on_timer_timeout():
	if Shapecast.get_collider(0):
		var dupe = scene.instantiate()
		add_child(dupe)
		dupe.global_position = global_position
		dupe.set_meta("Direction",Shapecast.get_collider(0).global_position - global_position)
	if Entered == true:
		Shapecast.get_collider(0).set_meta("Health",Shapecast.get_collider(0).get_meta("Health")-20)
		print(Shapecast.get_collider(0).get_meta("Health"))
		print("Take Damage")
		
