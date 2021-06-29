extends KinematicBody2D

export var speed = 100

func _ready():
	pass

func _process(delta):
	look_at(get_global_mouse_position())
	move_and_slide(Vector2(speed, 0).rotated(rotation))
