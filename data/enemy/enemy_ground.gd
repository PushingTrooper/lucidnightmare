extends CharacterBody3D

@onready var player = get_node("../player")
@export var accel = 5
var speed = 3
var shouldMove = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player_pos = player.global_position
	look_at(player.global_position)
	#velocity.z = lerp(velocity.z, 1 * speed, accel * delta)
	if(distance_to_player() < 20):
		shouldMove = true
	else: shouldMove = false
	#print(self.rotation.y)
	#if shouldMove:
		#move_and_slide()
	pass

func distance_to_player():
	return int(self.transform.origin.distance_to(player.transform.origin))


func _on_body_entered(body):
	print(body.get_name())
	pass # Replace with function body.
