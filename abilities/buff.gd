class_name Buff
extends RefCounted
enum Attribute{
	STR, #0
	DEX,
	INT #2
}
var name : String
var target_stat : Attribute
var value: float
var duration: float
var multi : bool = false

func _init(_name : String, _target_stat : Attribute, _value : float, _duration : float, _multi : bool):
	name = _name
	target_stat = _target_stat
	value = _value
	duration = _duration
	multi = _multi
	
func tick(delta:float) -> bool:
	duration -= delta
	if duration <= 0:
		return true
	return false
