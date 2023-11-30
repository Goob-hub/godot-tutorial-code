extends Area2D
class_name AttackRangeComponent 

signal start_attack
signal stop_attack

@export var attack_range_shape:CollisionShape2D

var enemies_in_range = 0

func _ready():
	self.area_entered.connect(on_area_entered)
	self.area_exited.connect(on_area_exited)


func on_area_entered(_other_area):
	enemies_in_range += 1
	
	if(enemies_in_range == 1):
		start_attack.emit()


func on_area_exited(_other_area):
	enemies_in_range -= 1
	
	if(enemies_in_range == 0):
		stop_attack.emit()


func disable_attack_range():
	enemies_in_range = 0
	attack_range_shape.set_deferred("disabled", true)


func enable_attack_range():
	attack_range_shape.set_deferred("disabled", false)
