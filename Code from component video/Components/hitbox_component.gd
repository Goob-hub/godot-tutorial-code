extends Area2D
class_name Hitbox_component

@export var status_effect_manager: StatusEffectManager
@export var health_component: HealthComponent
@export var hit_box_shape: CollisionShape2D

func _ready():
	self.area_entered.connect(on_area_entered)


func on_area_entered(other_area: Area2D):
	if(other_area is Attack):
		health_component.damage(other_area.damage)
		if(other_area.status_effects.size() > 0):
			status_effect_manager.handle_status_effects(other_area.status_effects)


func disable_hitbox() -> void:
	hit_box_shape.set_deferred("disabled", true)


func enable_hitbox() -> void:
	hit_box_shape.set_deferred("disabled", false)
