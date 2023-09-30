extends Node3D

@onready var collider = $Area3D/CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_area_3d_body_entered(body):
	Orchestrator.haveGun = true
	#self.process_mode = 4 # = Mode: Disabled
	self.queue_free()
