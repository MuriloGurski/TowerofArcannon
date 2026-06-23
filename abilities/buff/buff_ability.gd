extends Ability


@export var attribute : Attributes
@export var value: float
@export var duration : float
@export var multi : bool

func use(controller):
	controller.apply_buff(ability_name, attribute, value, duration, multi, cooldown)
