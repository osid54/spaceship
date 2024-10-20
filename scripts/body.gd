extends Node2D

@export var mass := 100

func _ready() -> void:
	rotation = 0
	mass = randi_range(80,300)
	$Label.text = str(mass)
	$StaticBody2D/CollisionShape2D.shape.radius = randi_range(32,256)

func _physics_process(_delta: float) -> void:
	var inAtmos = $Area2D.get_overlapping_bodies()
	if inAtmos.is_empty():
		return
	var ship = inAtmos[0]
	var force = -mass/pow((global_position - inAtmos[0].global_position).length()/10,2)
	#print(force)
	var angle = get_angle_to(ship.position)
	ship.xF[self] = Vector2(cos(angle),sin(angle))*force

func _on_area_2d_body_exited(body: Node2D) -> void:
	body.xF.erase(self)
