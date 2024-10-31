extends CharacterBody2D

var scene = load("res://Wisp.tscn")
const speed = 200
@export var player: Node2D
@export var AnimatedSprite: AnimatedSprite2D
@export var ShapeCast: ShapeCast2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@export var SlashingTimer: Timer
@export var wispreleasetimer: Timer
var spawning = false
var slashing = false



func _physics_process(delta: float) -> void:
	if get_meta("Health") < 0:
		AnimatedSprite.play("Reaper-Death")
		await get_tree().create_timer(1.7).timeout
		queue_free()
		player.set_meta("KilledBoss",true)
		
		
	if get_meta("Health") > 0:
		if slashing == false:
			AnimatedSprite.play("Reaper-Idle and Walk")
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir* speed
		if spawning == false:
			move_and_slide()
		
		makepath()
		if ShapeCast.get_collider(0) and slashing == false:
			AnimatedSprite.play("Reaper-2-Slices")
			
			slashing = true
			if   player.get_meta("Parry") == false:
				player.set_meta("Health",player.get_meta("Health")-25)
			await get_tree().create_timer(1).timeout
			SlashingTimer.start(3)
		
			if ShapeCast.get_collider(0) and player.get_meta("Parry") == false :
				print(ShapeCast.get_collider(0))
				player.set_meta("Health",player.get_meta("Health")-25)
			await get_tree().create_timer(0.3).timeout
			AnimatedSprite.play("Reaper-Idle and Walk")
		
func makepath() -> void:
	
	nav_agent.target_position = player.find_child("CollisionShape2D").global_position
	



	
		
		
	


func _on_slash_timer_timeout() -> void:
	slashing = false
	


func _on_wisp_release_timer_timeout() -> void:
	pass

	
