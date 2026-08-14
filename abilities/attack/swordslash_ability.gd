extends Ability

@export var is_projectile : bool

@export var damage := 500.0
@export var startup := 0.25
@export var active_time := 0.1

@export var hitbox_shape : Shape2D
@export var hitbox_offset := 0.2



func use(controller, dir):
	controller.start_attack(damage,startup,active_time,hitbox_shape,hitbox_offset)
	controller.play_animation(animation_id, dir)
