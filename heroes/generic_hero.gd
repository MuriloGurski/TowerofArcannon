extends Resource

class_name Hero
var animations = {
	0:"idle",
	1:"attack",
	2:"cast",
	3:"invulnerability",
	4:"hit",
	5:"dodge",
	6:"parry",
	7:"run"
}

@export var hero_name: String
@export var sprite_frames: SpriteFrames
@export var health: int = 100
@export var speed = 300
@export var attack_ability : Resource
@export var secondary_ability : Resource
@export var mobility_ability : Resource
@export var special_ability : Resource
