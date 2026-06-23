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
enum Attributes{
	STR, #0
	DEX, 
	INT #2
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
