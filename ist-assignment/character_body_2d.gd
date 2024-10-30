extends CharacterBody2D

var direction = Vector2.ZERO
@export var timer : Timer
@export var timer2 : Timer
@export var timer3 : Timer
@export var timer4 : Timer
@export var timer5 : Timer
@export var SlidingAnimationStart: Timer
@export var SlidingAnimationMiddle : Timer
@export var SlidingAnimationEnd : Timer
@export var JumpingTimer: Timer
@export var TextEdit1: TextEdit
var jump = false
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
var Entered = false 
var swinging = false
var dashinganimation = false
var slidinganimation = false

var body2 = CharacterBody2D.new()
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
		
	
		
		
var SwingCounter = 0
func _ready():
	timer.timeout.connect(_on_timer_timeout)
	timer2.timeout.connect(_on_timer_timeout2)
	timer3.timeout.connect(_on_timer_timeout3)
	
func _physics_process(delta):
	if is_on_floor() == false and jump == false and dashinganimation == false:
		AnimatedSprite.play("Fall")
	TextEdit1.set_line(0,str(get_meta("Health")))
	if Input.is_action_just_pressed("LeftClick") and swinging == false and dashinganimation == false and slidinganimation == false and jump == false and  is_on_floor() == true:
		
		SwingCounter += 1
		if SwingCounter % 2 != 0:
			print("lalala")
			AnimatedSprite.play("Swing 1")
			swinging = true
			timer4.start(0.4)
		else:
			AnimatedSprite.play("Swing 2")
			swinging = true
			timer4.start(0.5)
		if Entered == true and body2 is CharacterBody2D:
			body2.set_meta("Health",body2.get_meta("Health")-20) 
			print(body2.get_meta("Health"))
	if Input.is_action_just_pressed("slide") and currentslides < maxslides and dashing == false:
		sliding = true
		slidinganimation = true
		SlidingAnimationStart.start(0.001)
		print("Sliding")
		
		EnableNormalMovement = false
		if direction.length() != 0:
			velocity.x  += 1500 * direction.x
			timer2.start(0.2)
		else:
			velocity.x += 1500
			
			timer2.start(0.5)
		currentslides +=  1
	if currentslides >= maxslides and onlyonce == false:
		onlyonce = true 
		timer3.start(5)
	if Input.is_action_just_pressed("Dash") and currentdashes < maxdashes and sliding == false :
		dashing = true 
		AnimatedSprite.play("Dash")
		dashinganimation = true
		timer5.start(0.4)
		if direction.length() != 0:
				velocity.x += 1500 * direction.x
		else:
			velocity.x += 1500
	
		currentdashes += 1 
	if currentdashes >= maxdashes and onlyonce == false:
		
		timer.start(2)
		onlyonce = true
		print(timer.time_left)
	if Input.is_action_pressed("move_right"):
		direction.x = 1
		if swinging == false and dashinganimation == false and slidinganimation == false and jump == false and  is_on_floor() == true:
			AnimatedSprite.play("Run")
		AnimatedSprite.flip_h = false
		#velocity.x = direction.x * 500
	elif Input.is_action_pressed("move_left"):
		direction.x = -1
		if swinging == false and dashinganimation == false and slidinganimation == false and jump == false and  is_on_floor() == true:
			AnimatedSprite.play("Run")
		
		AnimatedSprite.flip_h = true
		##velocity.x = direction.x * 500
		
	else:
		direction.x = 0
		if swinging == false and dashinganimation == false and slidinganimation == false and jump == false and  is_on_floor() == true:
			AnimatedSprite.play("Idle")
	
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -800
		jump = true
		AnimatedSprite.play("Jump")
		JumpingTimer.start(0.2)
	else:
		velocity.y += 50
	
	if Input.is_action_just_pressed("jump") and is_on_floor() and timeframe == true:
		print("ddddddddddddddd")
		velocity.y = -1500
		velocity.x += 500
	if sliding == true and velocity.x == 0:
		EnableNormalMovement = true
	if EnableNormalMovement == true :
		
		velocity = velocity.move_toward(Vector2(direction.x* 500,velocity.y),2300 * delta)
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


func _on_area_2d_body_entered(body: Node2D) -> void:
	Entered = true 
	body2 = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	Entered = false
	body = CharacterBody2D.new()


func _on_timer_4_timeout() -> void:
	swinging = false


func _on_timer_5_timeout() -> void:
	dashinganimation = false


func _on_sliding_animation_start_timeout() -> void:
	AnimatedSprite.play("Slide Start")
	SlidingAnimationMiddle.start(0.3)



func _on_sliding_animation_middle_timeout() -> void:
	AnimatedSprite.play("Slide")
	SlidingAnimationEnd.start(0.3)


func _on_sliding_animation_end_timeout() -> void:
	AnimatedSprite.play("Slide End")
	slidinganimation = false


func _on_jumping_timer_timeout() -> void:
	jump = false
	
	
