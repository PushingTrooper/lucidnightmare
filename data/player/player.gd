extends CharacterBody3D


@export var base_speed = 10
@export var sprint_speed = 12
@export var jump_velocity = 5.5
@export var sensitivity = 0.2
@export var accel = 10
var speed = base_speed
var sprinting = false
var camera_fov_extents = [75.0, 85.0] #index 0 is normal, index 1 is sprinting
var projectile = preload("res://data/projectile/projectile.tscn")

@onready var cooldownTimer = $CooldownTimer
@onready var swordAnimation = $AnimationPlayer

@onready var parts = {
	"head": $head,
	"weapon": $head/camera/MeshInstance3D2,
	"projectile_spawn": $head/camera/projectile_spawn,
	"camera": $head/camera,
	"camera_animation": $head/camera/camera_animation
}
@onready var world = get_parent()

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var isEvenBullet = true


func _ready():
	world.pause.connect(_on_pause)
	world.unpause.connect(_on_unpause)
	
	parts.camera.current = true

func _process(delta):
	if Input.is_action_pressed("move_sprint"):
		sprinting = true
		speed = sprint_speed
		parts.camera.fov = lerp(parts.camera.fov, camera_fov_extents[1], 10*delta)
	else:
		sprinting = false
		speed = base_speed
		parts.camera.fov = lerp(parts.camera.fov, camera_fov_extents[0], 10*delta)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_pressed("move_jump") and is_on_floor():
		velocity.y += jump_velocity

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = input_dir.normalized().rotated(-parts.head.rotation.y)
	direction = Vector3(direction.x, 0, direction.y)
	if is_on_floor(): #don't lerp y movement
		velocity.x = lerp(velocity.x, direction.x * speed, accel * delta)
		velocity.z = lerp(velocity.z, direction.z * speed, accel * delta)
	
	#bob head
	if input_dir and is_on_floor():
		parts.camera_animation.play("head_bob", 0.5)
	else:
		parts.camera_animation.play("reset", 0.5)

	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		if !world.paused:
			parts.head.rotation_degrees.y -= event.relative.x * sensitivity
			parts.head.rotation_degrees.x -= event.relative.y * sensitivity
			parts.head.rotation.x = clamp(parts.head.rotation.x, deg_to_rad(-90), deg_to_rad(90))
			
	if event.is_action_pressed("mouse_left_click") and Orchestrator.haveGun and cooldownTimer.is_stopped():
		var initProjectile = projectile.instantiate()
		var characterPosition = self.position
#		var proPosition = Vector3()
		initProjectile.position = parts.projectile_spawn.global_position
		initProjectile.transform.basis = parts.projectile_spawn.global_transform.basis
#		initProjectile.position.y += 0.2
#		parts.projectile_spawn.instantiate(projectile)
		world.add_child(initProjectile)
		move_and_slide()
		cooldownTimer.start()
		if isEvenBullet:
			swordAnimation.play("swing")
		else:
			swordAnimation.play_backwards("swing")
		
		isEvenBullet = !isEvenBullet
#		swordAnimation.
		
			
#			parts.weapon.rotation_degrees.y -= event.relative.x * sensitivity
#			parts.weapon.rotation_degrees.x -= event.relative.y * sensitivity
#			parts.weapon.rotation.x = clamp(parts.head.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _on_pause():
	pass

func _on_unpause():
	pass
