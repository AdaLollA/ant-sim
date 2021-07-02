extends Sprite
enum Type {HOME, FOOD}

var type = Type.HOME setget setType

func setType(newValue):
	type = newValue
	if type == Type.HOME:
		modulate = Color(0,0,1,.2) # blue = home
	else:
		modulate = Color(1,0,0,.2) # red = fod
