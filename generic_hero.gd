extends CharacterBody2D

class_name Hero
const SPEED = 300.0
var dodge_speed := 500.0
var dodge_duration := 0.25


var is_attacking: bool = false
var is_dodging: bool = false
var dodge_direction: Vector2 = Vector2.ZERO
var dodge_timer := 0.0

@export var health: int = 100



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#Parar de se mover ao atacar
	if is_attacking:
		velocity = Vector2.ZERO
		return
		
	
			

#----------------------------------------#
#	     		 DODGE			 		 #
#----------------------------------------#

func dodge()-> void:
	dodge_direction = Vector2.RIGHT
	
	dodge_timer = dodge_duration
	play_animation("dodge", last_direction)
	
func handle_dodge(delta)-> void:
	velocity = dodge_direction * dodge_speed
	
	dodge_timer -= delta
	
	if dodge_timer <= 0:
		is_dodging = false
		velocity = Vector2.ZERO
		
#----------------------------------------#
#	     		 ATACAR			 		 #
#----------------------------------------#
		
func attack()-> void:
	is_attacking = true
	play_animation("attack", last_direction)

func _on_animated_sprite_2d_animation_finished() -> void:
	if is_attacking:
		is_attacking = false
	if is_dodging:
		is_dodging = false
