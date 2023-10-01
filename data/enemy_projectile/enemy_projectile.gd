extends RigidBody3D

@onready var mesh1 = $MeshInstance3D
@onready var mesh2 = $MeshInstance3D2s
@onready var rayCast = $RayCast3D
@onready var freeQueueTimer = $freeQueueTimer

const SPEED = 60

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	#if freeQueueTimer.is_stopped():
	#	self.queue_free()
	if rayCast.is_colliding():
		mesh1.visible = false
		mesh2.visible = false
		rayCast.enabled = false
		if rayCast.get_collider().is_in_group("player"):
			rayCast.get_collider().hit()
		
	if freeQueueTimer.is_stopped():
		self.queue_free()
#	var rayCastVector = Vector3(rayCast.get_position().x, rayCast.get_position().y, rayCast.get_position().z)
#	move_and_collide(rayCast.position)

