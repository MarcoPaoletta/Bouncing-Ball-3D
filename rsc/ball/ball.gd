extends RigidBody

var rolling_force: int = 40
var jump_force: int = 1000

func _ready():
	# makes the node ignore its parents transformations
	$camera_rig.set_as_toplevel(true) 
	$floor_check.set_as_toplevel(true)

func _physics_process(delta):
	# smooth camera movement
	var old_camera_pos: Vector3 = $camera_rig.global_transform.origin
	var ball_pos: Vector3 = global_transform.origin
	var new_camera_pos = lerp(old_camera_pos, ball_pos, 0.1)
	$camera_rig.global_transform.origin = new_camera_pos # update cameras position to the ball position
	
	$floor_check.global_transform.origin = global_transform.origin # to move the raycast along the ball
	
	if Input.is_action_pressed("forward"):
		angular_velocity.x -= rolling_force * delta
		
	elif Input.is_action_pressed("back"):
		angular_velocity.x += rolling_force * delta
		
	if Input.is_action_pressed("left"):
		angular_velocity.z += rolling_force * delta
		
	elif Input.is_action_pressed("right"):
		angular_velocity.z -= rolling_force * delta
		
	if Input.is_action_just_pressed("jump") and $floor_check.is_colliding():
		apply_central_impulse(Vector3.UP * jump_force)
