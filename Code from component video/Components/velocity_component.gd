extends Node
class_name VelocityComponent

@export var base_mov_speed: float
@export var base_acceleration: float

var velocity: Vector2 = Vector2.ZERO
var altering_mov_speed: float
var altering_acceleration: float


func _ready():
	altering_mov_speed = base_mov_speed
	altering_acceleration = base_acceleration


func accelerate_in_direction(direction: Vector2):
	var target_velocity = direction * altering_mov_speed
	#Gradually builds up to the target velocity based on the percent provided
	velocity = velocity.lerp(target_velocity, 1 - exp(-get_process_delta_time() * altering_acceleration))


func move(body):
	body.velocity = velocity
	body.move_and_slide()
	#Re-setting the velocity here in the script because move and slide alters the character velocity
	velocity = body.velocity


func stop_moving():
	altering_mov_speed = 0
	altering_acceleration = 100


func start_moving():
	altering_mov_speed = base_mov_speed
	altering_acceleration = base_acceleration
