extends RigidBody3D
var SPEED = 3
var shouldMove = true
var hp = 1
@export var damageTaken := 1
@onready var player = get_node("../player")
signal enemy_hit(dmg)
func _ready():
	pass

func _process(delta):
	look_at(player.global_position)
	if shouldMove:
		position += transform.basis * Vector3(player.global_position.x, player.global_position.y, -SPEED) * delta
	pass

func _on_body_entered(body):
	print(body.get_name())
	var name = body.get_name()
	if(name == "player"):
		shouldMove = false
		await wait(1)
		shouldMove = true
	pass

func wait(s):
	await get_tree().create_timer(s, false, false, true).timeout
	
func hit():
	emit_signal("enemy_hit", damageTaken)
	print("got hit")
	hp-=1
	if(hp < 1):
		self.queue_free()
