extends CharacterBody2D

func _physics_process(delta):
	global_position = get_global_mouse_position()
	if get_meta("Health") <= 0:
		get_tree().quit(3)
