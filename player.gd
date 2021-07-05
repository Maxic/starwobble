extends KinematicBody2D


export var GRAVITY = 9.81
export var MOVE_SPEED = 300 # Speed to walk with
export var BONE_INFLUENCE = .1
export var MAX_DISPLACEMENT = .06
export var JIGGLE_SPEED = 15.0
export var ROTATION_SPEED = .1

var velocity = Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Get input
	var action_strength_right = Input.get_action_strength("right")
	var action_strength_left = Input.get_action_strength("left")
	var action_strength_up = Input.get_action_strength("up")
	var action_strength_down = Input.get_action_strength("down")
	var move_h = (action_strength_right - action_strength_left) * MOVE_SPEED
	var move_v = (action_strength_down - action_strength_up) * MOVE_SPEED
	
	var action_strength_rotate_cclockwise = Input.get_action_strength("rotate_cclockwise")
	var action_strength_rotate_clockwise = Input.get_action_strength("rotate_clockwise")
	var rotate_amount = (action_strength_rotate_cclockwise - action_strength_rotate_clockwise) * ROTATION_SPEED

	var bone_force = (action_strength_right - action_strength_left) * BONE_INFLUENCE
	
	
	# apply rotation
	self.rotation -= rotate_amount
	
	# apply the walking
	velocity.x += move_h		
	velocity.y += move_v		
	move_and_slide(velocity, Vector2.UP)	# Actually apply all the forces
	apply_velocity_to_bone(velocity, get_node("Skeleton2D/mid_left"), .02, JIGGLE_SPEED)
	apply_velocity_to_bone(velocity, get_node("Skeleton2D/mid_right"), .02, JIGGLE_SPEED)
	apply_velocity_to_bone(velocity, get_node("Skeleton2D/bottom_left"), .03, JIGGLE_SPEED)
	apply_velocity_to_bone(velocity, get_node("Skeleton2D/bottom_right"), .03, JIGGLE_SPEED)
	apply_velocity_to_bone(velocity, get_node("Skeleton2D/top"), .06, JIGGLE_SPEED)

	velocity.x -= move_h		# take away the walk speed again
	velocity.y -= move_v		# take away the walk speed again
	

func apply_velocity_to_bone(force: Vector2, bone: Bone2D, bone_influence: float, jiggle_speed: float):
	
	if force.x > 0:
		print("force: " + str(force))
		print("rotated force: " + str(force.rotated(rotation)))
	bone.position = bone.position.linear_interpolate(force.rotated(rotation) * bone_influence * -1, get_process_delta_time() * jiggle_speed)
	

	
	
