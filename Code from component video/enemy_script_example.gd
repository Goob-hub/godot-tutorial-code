extends CharacterBody2D

@onready var attack_range_component = $%AttackRangeComponent as AttackRangeComponent
@onready var attack_component = $%AttackComponent as AttackComponent
@onready var hitbox_component = $%HitboxComponent as Hitbox_component
@onready var velocity_component = $%VelocityComponent as VelocityComponent
@onready var health_component = $%HealthComponent as HealthComponent

@onready var animation_player = $%AnimationPlayer as AnimationPlayer

var direction: Vector2 = Vector2.RIGHT

func _ready():
	health_component.dead.connect(on_dead)
	attack_range_component.start_attack.connect(on_attack_start)
	attack_range_component.stop_attack.connect(on_attack_stop)
	
	animation_player.play("run")


func _process(_delta):
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(self)


func on_dead():
	hitbox_component.disable_hitbox()
	velocity_component.stop_moving()
	attack_component.stop_attacking()
	attack_range_component.disable_attack_range()
	
	animation_player.play("death")


func on_attack_start():
	velocity_component.stop_moving()
	attack_component.start_attacking()
	
	animation_player.play("attack")


func on_attack_stop():
	velocity_component.start_moving()
	attack_component.stop_attacking()
	
	animation_player.play("run")