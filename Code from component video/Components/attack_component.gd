extends Attack
class_name AttackComponent

@export var attack_shape: CollisionShape2D
@export var disable_on_ready: bool = true

@onready var attack_rate_timer: Timer = $AttackRateTimer

var wait_time

func _ready():
	if(disable_on_ready):
		attack_shape.disabled = true
	
	if(self.attacks_per_second <= 0):
		return
	
	wait_time = 1 / self.attacks_per_second
	
	attack_rate_timer.timeout.connect(on_timer_timeout)
	
	set_status_effect_data()


func on_timer_timeout() -> void:
	if(attack_shape.disabled == false):
		attack_shape.set_deferred("disabled", true)
	else:
		attack_shape.set_deferred("disabled", false)


func start_attacking() -> void:
	attack_shape.set_deferred("disabled", false)
	
	if(wait_time == null):
		return
	
	attack_rate_timer.wait_time = wait_time
	attack_rate_timer.start()


func stop_attacking() -> void:
	attack_shape.set_deferred("disabled", true)
	
	if(wait_time == null):
		return
	
	attack_rate_timer.wait_time = wait_time
	attack_rate_timer.stop()


func set_status_effect_data() -> void:
	for status_effect in status_effects:
		status_effect.set_data()
