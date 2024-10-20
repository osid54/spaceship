extends CharacterBody2D

var speed := 300.0
@export var maxSpeed := 500.0
var targetV := 300.0
@export var normalV := 300.0
@export var accel := 50.0
@export var rotSpeed := PI/2
@export var friction := 10.0
@export var timeToFull := 15.0
var speedbya := Vector2()
var vel := 0.0
var x := 0.0
var goSpeed := Vector2()
var xF := {}

func _ready() -> void:
	targetV = normalV

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		rotate(-rotSpeed*delta)
	if Input.is_action_pressed("right"):
		rotate(rotSpeed*delta)
	var drive := Input.get_axis("up","down")
	if drive:
		if drive > 0:
			drive *= .3
		#vel = move_toward(vel,targetV,accel)
		#x = vel/targetV
		#speed = targetV * (1-pow((1-x),3))
		#goSpeed = Vector2(drive*cos(rotation+PI/2),drive*sin(rotation+PI/2))*speed
		#velocity = velocity.move_toward(goSpeed, accel)
		print(velocity,"\t",accel*delta)
		var v = velocity.length() + accel*delta
		#x = v/targetV
		x=clampf(x+delta*-drive,0,timeToFull)
		var s = targetV * (1-pow((1-x/timeToFull),3))
		speed = s
		speedbya = Vector2(drive*cos(rotation+PI/2),drive*sin(rotation+PI/2))*s
		print(v,"\t",x,"\t",s,"\t")
	
	var sumXF := Vector2()
	for force in xF:
			sumXF += xF[force]
	#if sumXF != Vector2():
		#velocity += sumXF
		#velocity = velocity.move_toward(velocity+sumXF,accel)
		#targetV = maxSpeed
	#else: 
		#velocity = velocity.move_toward(Vector2(), friction)
		#targetV = normalV
	velocity = velocity.move_toward(speedbya+sumXF,accel)
	velocity = velocity.move_toward(Vector2(), friction)
	#vel = move_toward(vel,0,friction)
	$CanvasLayer/Label.text = str(vel,"\n",x,"\n",speed,"\n",velocity.length())

	move_and_slide()
