extends Ability

@export var speed := 500.0
@export var duration := 0.25

func use(controller):
	controller.start_mobility_cooldown(cooldown)
	controller.start_dash(controller.last_direction, speed, duration)
	controller.play_animation(animation_id, controller.last_direction)
