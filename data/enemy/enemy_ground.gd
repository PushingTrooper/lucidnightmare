extends CharacterBody3D
@onready var world = get_parent()
@onready var player = world.get_node("player")
@export var accel = 2
@export var speed = 1
@export var damageTaken := 1
var shouldMove = true
var can_attack = true
var hp = 2
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	var player_pos = player.global_position
	var current_pos = self.global_position
	var dir_x = player_pos.x - current_pos.x
	var dir_z = player_pos.z - current_pos.z
	look_at(player.global_position)
	velocity.x = lerp(velocity.x, dir_x * speed, accel * delta)
	velocity.z = lerp(velocity.z, dir_z * speed, accel * delta)
	#if(distance_to_player() < 20):
	shouldMove = true
	#else: shouldMove = false
	if shouldMove:
		move_and_slide()
	pass

func distance_to_player():
	return int(self.transform.origin.distance_to(player.transform.origin))

func _on_area_3d_body_entered(body):
	print(body.get_name())
	if(name == "player"):
		speed = 0
		await wait(5)
		speed = 3
	pass # Replace with function body.

func wait(s):
	await get_tree().create_timer(s, true, false, true).timeout
	
func hit():
	emit_signal("enemy_hit", damageTaken)
	print("got hit")
	hp-=1
	if(hp < 1):
		self.queue_free()
