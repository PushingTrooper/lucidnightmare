extends Node3D

enum States{STATE_RED, STATE_BLUE}

var _state : int = States.STATE_BLUE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("State is " + str(_state))
	if Input.is_action_just_pressed("state_change") and _state == States.STATE_BLUE:
		_state = States.STATE_RED
	elif Input.is_action_just_pressed("state_change") and _state == States.STATE_RED:
		_state = States.STATE_BLUE
	
func _get_state():
	return _state
