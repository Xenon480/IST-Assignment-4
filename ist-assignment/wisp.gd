extends CharacterBody2D


const speed = 200
var player = CharacterBody2D.new()
var damage = 2
var cooldown = false
var entered = false 
var body2 = CharacterBody2D.new()
var apprearonlyonce = false
@export var AnimatedSprite: AnimatedSprite2D
@export var timer: Timer
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D



	



func _physics_process(delta: float) -> void:
	
	if apprearonlyonce == false:
		AnimatedSprite.play("Wisp Appear")
		await get_tree().create_timer(1).timeout
		apprearonlyonce = true
		if get_meta("Health") <= 0:
			AnimatedSprite.play("Wisp Death")
			queue_free()
			
	if get_meta("Health") > 0:
		
		if apprearonlyonce == true:
			AnimatedSprite.play("Wisp Idle Walk")
			
			
		player = get_parent().get_parent().find_child("Player").find_child("CollisionShape2D")
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		
		velocity = dir* speed
		move_and_slide()
		makepath()
		if cooldown == false and entered == true:
			body2.set_meta("Health",body2.get_meta("Health")-damage)
			cooldown = true
			timer.start(2)
	
	
	
func makepath() -> void:
	nav_agent.target_position = player.global_position
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		entered = true
		body2 = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		entered = false
		body2 = CharacterBody2D.new()


func _on_timer_timeout() -> void:
	cooldown = false
