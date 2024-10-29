
extends CharacterBody2D

var direction = Vector2.ZERO
@export var timer : Timer
@export var timer2 : Timer
@export var timer3 : Timer
@export var TextEdit1: TextEdit
@export var  AnimatedSprite: AnimatedSprite2D
var maxdashes = 1
var currentdashes = 0
var maxslides = 1
var currentslides = 0
var dashing  = false
var sliding = false 
var onlyonce = false
var timeframe = false
var EnableNormalMovement = true
func wait(seconds: float) -> void:

	await get_tree().create_timer(seconds).timeout
func _on_timer_timeout():
	print("Working")
	currentdashes = 0
	onlyonce = false
	dashing = false
func _on_timer_timeout2():
	print("Timeframe")
	timeframe = true
	
	await get_tree().create_timer(0.5).timeout
	timeframe = false
		
	
		
		

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	timer2.timeout.connect(_on_timer_timeout2)
	timer3.timeout.connect(_on_timer_timeout3)
	
func _physics_process(delta):
	TextEdit1.set_line(0,str(get_meta("Health")))
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
	if Input.is_action_just_pressed("LeftClick"):
		if Entered == true:
			body2.set_meta("Health",body2.get_meta("Health")-20)
			print("Teeeeeee")
=======
>>>>>>> parent of a264970 (Merge branch 'main' of https://github.com/Xenon480/IST-Assignment-4)
=======
>>>>>>> parent of a264970 (Merge branch 'main' of https://github.com/Xenon480/IST-Assignment-4)
=======
>>>>>>> parent of a264970 (Merge branch 'main' of https://github.com/Xenon480/IST-Assignment-4)
=======
>>>>>>> parent of 8d14f54 (dddd)
	if Input.is_action_just_pressed("slide") and currentslides < maxslides and dashing == false:
		sliding = true
		print("Sliding")
		EnableNormalMovement = false
		if direction.length() != 0:
			velocity.x  += 1500 * direction.x
			timer2.start(0.5)
		else:
			velocity.x += 1500
			
			timer2.start(0.5)
		currentslides +=  1
	if currentslides >= maxslides and onlyonce == false:
		onlyonce = true 
		timer3.start(5)
	if Input.is_action_just_pressed("Dash") and currentdashes < maxdashes and sliding == false :
		dashing = true 
		if direction.length() != 0:
				velocity.x += 300 * direction.x
		else:
			velocity.x += 1000
	
		currentdashes += 1 
	if currentdashes >= maxdashes and onlyonce == false:
		
		timer.start(2)
		onlyonce = true
		print(timer.time_left)
	if Input.is_action_pressed("move_right"):
		direction.x = 1
		AnimatedSprite.play("default")
		AnimatedSprite.flip_h = false
		#velocity.x = direction.x * 500
	elif Input.is_action_pressed("move_left"):
		direction.x = -1
		AnimatedSprite.play("default")
		AnimatedSprite.flip_h = true
		##velocity.x = direction.x * 500
		
	else:
		direction.x = 0
		if AnimatedSprite:
			AnimatedSprite.pause()
	
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -800
	else:
		velocity.y += 50
	
	if Input.is_action_just_pressed("jump") and is_on_floor() and timeframe == true:
		print("ddddddddddddddd")
		velocity.y = -1500
		velocity.x += 500
	if sliding == true and velocity.x == 0:
		EnableNormalMovement = true
	if EnableNormalMovement == true :
		
		velocity = velocity.move_toward(Vector2(direction.x* 700,velocity.y),2300 * delta)
	elif sliding == true and EnableNormalMovement == false:
			velocity = velocity.move_toward(Vector2(0,velocity.y),2000 * delta)
	

	if (get_meta("Health")) <= 0:
		get_tree().quit()
	move_and_slide()
func _on_timer_timeout3():
	print("Working3")
	currentslides = 0
	sliding =  false
	onlyonce = false
