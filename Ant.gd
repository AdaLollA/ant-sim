extends KinematicBody2D

var pheromone = preload("res://Pheromone.tscn")
enum State {LOOKING_FOR_FOOD, HEADING_HOME}

export var speed = 50
export var wanderStrength = .05

var state = State.LOOKING_FOR_FOOD
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
	# picked up food
	target = null
	area.get_parent().queue_free()
	rotate(PI)
	state = State.HEADING_HOME
	# todo ant is now carrying food

enum Type {HOME, FOOD}
func _on_PheromoneDropTimer_timeout():
	var pheromone_instance = pheromone.instance()
	if state == State.LOOKING_FOR_FOOD:
		pheromone_instance.type = Type.HOME
	elif state == State.HEADING_HOME:
		pheromone_instance.type = Type.FOOD
	pheromone_instance.position = global_position
	get_tree().root.add_child(pheromone_instance)
