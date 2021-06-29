extends KinematicBody2D

export var speed = 100
export var wanderStrength = .1

func _ready():
	look_at(get_global_mouse_position())
	pass

func _process(delta):
	# add randomness
	rotate(rand_range(-wanderStrength, wanderStrength))
	# forward
	var velocity: Vector2 = Vector2(speed, 0).rotated(rotation)
	# apply movement
	move_and_slide(velocity)
