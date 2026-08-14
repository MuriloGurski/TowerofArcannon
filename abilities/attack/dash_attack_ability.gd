extends Ability

@export var speed := 500.0
@export var duration := 0.25

@export var is_projectile : bool

@export var damage := 50.0
@export var startup := 0
@export var active_time := 0.25
@export var startup2 := 0.15
@export var damage2 := 100.0
@export var active_time2 := 0.3

@export var hitbox_shape : Shape2D
@export var hitbox_offset := 0.0
@export var hitbox_shape2 : Shape2D
@export var hitbox_offset2 := 0.0

func use(controller):
	controller.start_dash(controller.last_direction, speed, duration)
	controller.play_animation(animation_id, controller.last_direction)
	await controller.start_attack(self)
	controller.second_attack(self)
	controller.play_animation(animation_id, controller.last_direction)
