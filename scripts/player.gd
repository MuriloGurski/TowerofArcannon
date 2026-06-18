extends CharacterBody2D


var last_direction: Vector2 = Vector2.RIGHT

var is_attacking: bool = false
var is_dodging: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var hero: PackedScene

func _physics_process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("attack"):
		hero.attack()
	if Input.is_action_just_pressed("dodge"):
		hero.dodge()
			
	move()
	move_and_slide()
	#hero.animation_type()

func move()-> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	if direction != Vector2.ZERO:
		velocity = direction * hero.SPEED
		hero.last_direction = direction
	else:
		velocity = Vector2.ZERO
	
#Define quando será tocada a animação Idle, Run, Attack e Dodge	
func animation_type() -> void:
	if is_attacking:
		return
	if is_dodging:
		return
	if velocity != Vector2.ZERO:
		play_animation("run", last_direction)
	else:
		play_animation("idle", last_direction)
	
	
func play_animation(prefix: String, dir: Vector2) -> void:
	if dir.x != 0:
		#flipa a animação de andar pra direita para a esquerda
		animated_sprite_2d.flip_h = dir.x < 0
		animated_sprite_2d.play(prefix + "_right")
	elif dir.y < 0:
		animated_sprite_2d.play(prefix + "_up")
	elif dir.y > 0:
		animated_sprite_2d.play(prefix + "_down")
		
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
