extends RigidBody3D

@onready var mesh1 = $MeshInstance3D
@onready var mesh2 = $MeshInstance3D2
@onready var rayCast = $RayCast3D

const SPEED = 60

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
#	var rayCastVector = Vector3(rayCast.get_position().x, rayCast.get_position().y, rayCast.get_position().z)
#	move_and_collide(rayCast.position)
