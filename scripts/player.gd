extends CharacterBody2D


const SPEED = 300.0
var dodge_speed := 500.0
var dodge_duration := 0.25

var last_direction: Vector2 = Vector2.RIGHT
var is_attacking: bool = false
var is_dodging: bool = false
var dodge_direction: Vector2 = Vector2.ZERO
var dodge_timer := 0.0


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("attack") and not is_attacking:
		attack()
	if Input.is_action_just_pressed("dodge") and not is_dodging:
		dodge()
		
	#Parar de se mover ao atacar
	if is_attacking:
		velocity = Vector2.ZERO
		return
	
	movements()
	animation_type()
	move_and_slide()
	
	#----------------------------------------#
	#	     MOVIMENTOS E ANIMAÇÕES			 #
	#----------------------------------------#
	
func movements() -> void: 
	var direction := Input.get_vector("left", "right", "up", "down")
	
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		last_direction = direction
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
#	     		 DODGE			 		 #
#----------------------------------------#

func dodge()-> void:
	dodge_direction = Vector2.RIGHT
		
	is_dodging = true
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
	
