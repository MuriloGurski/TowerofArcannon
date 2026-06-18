extends Resource
class_name Ability

enum State {
	IDLE,
	ATTACK,
	CAST,
	INVULNERABLE,
	HIT,
	DODGE,
	PARRY,
	RUN
}
@export var ability_name: String
@export var cooldown : float = 0.0
@export var animation_id : State

func can_use(controller) -> bool:
	return true
	
func start(controller):
	pass
func end(controller):
	pass
