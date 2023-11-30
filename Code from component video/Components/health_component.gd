extends Node
class_name HealthComponent

signal dead
signal damaged(damage_amount)
signal healed(healing_amount)

@export var max_health: float

var current_health


func _ready():
	if(max_health == 0):
		printerr("Did not set health for " + owner.name)
		return
	
	current_health = max_health


func damage(damage_amount: float):
	current_health = maxf(0.0, current_health - damage_amount)
	
	if(current_health == 0):
		dead.emit()
	else:
		damaged.emit(damage_amount)


func heal(heal_amount: float):
	current_health = minf(max_health, current_health + heal_amount)
	healed.emit(heal_amount)
