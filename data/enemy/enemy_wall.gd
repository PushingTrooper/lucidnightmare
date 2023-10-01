extends RigidBody3D

var projectile = preload("res://data/enemy_projectile/enemy_projectile.tscn")
@onready var world = get_parent()
@onready var player = get_node("../player")
@export var damageTaken := 1
var hp = 1
var hasShot = false
var canShoot = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(distance_to_player() < 30):
		canShoot = true
	else: canShoot = false
	look_at(player.global_position)
	if !hasShot && canShoot:
		shoot_projectile()
	pass

func wait(s):
	await get_tree().create_timer(s, false, false, true).timeout
	hasShot = false
func shoot_projectile():
	var initProjectile = projectile.instantiate()
	var characterPosition = self.position
#	var proPosition = Vector3()
	initProjectile.position = global_position
	initProjectile.transform.basis = global_transform.basis
	world.add_child(initProjectile)
	hasShot = true
	wait(2)

func distance_to_player():
	return int(self.transform.origin.distance_to(player.transform.origin))

func hit():
	hp-=1
	if(hp < 1):
		self.queue_free()
