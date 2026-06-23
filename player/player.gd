extends CharacterBody2D


var last_direction: Vector2 = Vector2.RIGHT
var dash_timer: float = 0 
var dash_speed: float = 0
var iframes : float = 0.0
enum State {
	IDLE, #0
	ATTACK,
	CAST,
	INVULNERABLE,
	HIT,
	DODGE,
	PARRY,
	RUN #7
}
var current_state : State = State.IDLE
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var hero: Hero

func _ready():
	if hero:
		apply_hero(hero)
	print(Ability)


func _physics_process(_delta: float) -> void:
	if current_state == State.DODGE:
		handle_dash(_delta)
		move_and_slide()
		return
	if current_state == State.ATTACK:
		velocity = Vector2.ZERO
		return
	if Input.is_action_just_pressed("attack") and current_state != State.ATTACK:
		hero.attack_ability.use(self,last_direction)
	if Input.is_action_just_pressed("dodge") and current_state != State.DODGE:
		hero.mobility_ability.use(self,last_direction)
	#Parar de se mover ao atacar
	
	move()
	move_and_slide()
	#hero.animation_type()
	

func apply_hero(h: Hero):
	hero = h
	animated_sprite_2d.sprite_frames = hero.sprite_frames
	

func move()-> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	if direction != Vector2.ZERO:
		velocity = direction * hero.speed
		last_direction = direction
	else:
		velocity = Vector2.ZERO
	
#Define quando será tocada a animação Idle, Run, Attack e Dodge	
func animation_type() -> void:
	if current_state == State.ATTACK:
		return
	if current_state == State.DODGE:
		return
	if velocity != Vector2.ZERO:
		play_animation(State.RUN, last_direction)
	else:
		play_animation(State.IDLE, last_direction)
	
	
func play_animation(state: State, dir: Vector2) -> void:
	var key := state
	
	if dir.x != 0:
		#flipa a animação de andar pra direita para a esquerda
		animated_sprite_2d.flip_h = dir.x < 0
		
	var anim_name = hero.animations.get(key, "")

	if anim_name != "":
		animated_sprite_2d.play(anim_name)
		
#----------------------------------------#
#	     		 ATACAR			 		 #
#----------------------------------------#
		
func attack()-> void:
	current_state = State.ATTACK
	play_animation(State.ATTACK, last_direction)

func _on_animated_sprite_2d_animation_finished() -> void:
	if current_state == State.ATTACK:
		current_state == State.IDLE
	if current_state == State.DODGE:
		current_state == State.IDLE
		
#----------------------------------------#
#	     		 DASH 			 		 #
#----------------------------------------#
func start_dash(dir: Vector2, speed: float, duration: float):
	current_state = State.DODGE
	iframes = duration
	dash_timer = duration
	dash_speed = speed
	
func handle_dash(delta):
	velocity = last_direction * dash_speed

	dash_timer -= delta
	if dash_timer <= 0:
		current_state = State.IDLE
		dash_speed = 0
