extends KinematicBody2D

var pheromone = preload("res://Pheromone.tscn")

export var speed = 50
export var wanderStrength = .05

var target = null

func _ready():
	look_at(get_global_mouse_position())
	pass

func _process(delta):
	# head for target if available
	if target:
		look_at(target)
	
	# add randomness
	rotate(rand_range(-wanderStrength, wanderStrength))
	
	# forward
	var velocity: Vector2 = Vector2(speed, 0).rotated(rotation)
	# apply movement
	move_and_slide(velocity)

func _on_Left_area_entered(area):
	pass # Replace with function body.
func _on_Right_area_entered(area):
	pass # Replace with function body.
func _on_Front_area_entered(area):
	pass # Replace with function body.

func _on_Eyes_area_entered(area):
	if 'Food' in area.get_parent().name:
		target = area.get_global_position()

func _on_Mouth_area_entered(area):
	target = null
	area.get_parent().queue_free()
	rotate(PI)
	# todo ant is now carrying food

func _on_PheromoneDropTimer_timeout():
	var pheromone_instance = pheromone.instance()
	pheromone_instance.position = global_position
	get_tree().root.add_child(pheromone_instance)
	print('tick')
	pass # Replace with function body.
