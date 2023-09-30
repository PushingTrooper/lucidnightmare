extends CSGBox3D


func _input(event):
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var state = Orchestrator._get_state()
	if state == 0:
		self.use_collision = false
		self.transparency = 1
	else:
		self.use_collision = true
		self.transparency = 0
