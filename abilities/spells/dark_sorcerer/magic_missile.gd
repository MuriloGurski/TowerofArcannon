extends Ability

@export var is_projectile : bool

@export var damage := 500.0
@export var cast_time := 0.5
@export var active_time := 6
@export var speed_multiplier := 0.2
@export var projectile_speed := 3
@export var projectile_count := 0

@export var hitbox_shape : Shape2D
@export var hitbox_offset := 0.2



func use(controller):
	controller.start_attack(self)
	controller.start_primary_cooldown(cooldown)
	controller.play_animation(animation_id, controller.last_direction)
	
