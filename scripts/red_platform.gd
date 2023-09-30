extends CSGBox3D

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _input(event):
	pass


func _process(delta):
	var state = Orchestrator._get_state()
	if state == 1:
		self.use_collision = false
		self.transparency = 1
	else:
		self.use_collision = true
		self.transparency = 0
