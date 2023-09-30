extends RigidBody3D
const SPEED = 3

@onready var player = get_node("../player")

func _ready():
	print(player)
	pass

func _process(delta):
	look_at(player.global_position)
	position += transform.basis * Vector3(player.position.x, player.position.y, -SPEED) * delta
	pass

func _on_body_entered(body):
	print(body.get_name())
	pass # Replace with function body.
