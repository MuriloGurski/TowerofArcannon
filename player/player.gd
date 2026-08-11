extends CharacterBody2D


var last_direction: Vector2 = Vector2.RIGHT
var dash_timer: float = 0 
var dash_speed: float = 0
var iframes : float = 0.0
var special_cooldown : float = 0.0
var mobility_cooldown : float = 0.0
var secondary_cooldown : float = 0.0
var buff_list : Array[Buff] = []
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
	
	tick_cooldowns(_delta)
	update_buffs(_delta)
	if current_state == State.DODGE:
		handle_dash(_delta)
		move_and_slide()
		return
		
	if current_state == State.ATTACK:
		velocity = Vector2.ZERO
		return
		
	if Input.is_action_just_pressed("attack") and can_use_attack():
		hero.attack_ability.use(self,last_direction)
		
	if Input.is_action_just_pressed("dodge") and can_use_mobility():
		hero.mobility_ability.use(self,last_direction)
		
	if Input.is_action_just_pressed("special") and can_use_special():
		hero.special_ability.use(self)
		print(get_strength())
	#Parar de se mover ao atacar
	move()
	move_and_slide()
	animation_type()
	

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
		

func _on_animated_sprite_2d_animation_finished() -> void:
	if current_state == State.ATTACK:
		current_state = State.IDLE
	if current_state == State.DODGE:
		current_state = State.IDLE
#----------------------------------------#
#	     		 ATACAR			 		 #
#----------------------------------------#
		
func start_attack()-> void:
	current_state = State.ATTACK

func can_use_attack() -> bool:
	if current_state != State.ATTACK:
		return true
	else:
		return false

#----------------------------------------#
#	     		SPECIAL 			 	 #
#----------------------------------------#

func start_special_cooldown(cooldown : float):
	special_cooldown = cooldown

func can_use_special() -> bool:
	if special_cooldown < 0.0:
		return true
	else:
		return false

#----------------------------------------#
#	     	   SECONDARY 			 	 #
#----------------------------------------#

func start_secondary_cooldown(cooldown : float):
	secondary_cooldown = cooldown
	
func can_use_secondary() -> bool:
	if secondary_cooldown < 0.0:
		return true
	else:
		return false
		
#----------------------------------------#
#	     	   MOBILITY 			 	 #
#----------------------------------------#

func start_mobility_cooldown(cooldown : float):
	mobility_cooldown = cooldown

func can_use_mobility() -> bool:
	if mobility_cooldown < 0.0 and current_state != State.DODGE:
		return true
	else:
		return false
	
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

#----------------------------------------#
#	     		 BUFF 			 		 #
#----------------------------------------#

func apply_buff(name : String, stat : int, value : float ,duration : float, multi : bool):
	var buff = Buff.new(name, stat,value,duration,multi)
	buff_list.append(buff)

func update_buffs(delta):
	for i in range(buff_list.size() - 1, -1, -1):
		var buff = buff_list[i]
		
		if buff.tick(delta):
			print("Removed buff:", buff.name)
			buff_list.remove_at(i)

#----------------------------------------#
#	     		 ATBRT 			 		 #
#----------------------------------------#

func get_strength() -> int:
	var value = hero.strength
	var buff_mod := 1.0
	var buff_flat := 0
	
	for buff in buff_list:
		if buff.target_stat == 0:
			if buff.multi:
				buff_mod *= buff.value
			else:
				buff_flat += buff.value
				
	value += buff_flat
	value = value*buff_mod

	return value

func get_dexterity() -> int:
	var value = hero.dexterity
	var buff_mod := 1.0
	var buff_flat := 0
	
	for buff in buff_list:
		if buff.target_stat == 1:
			if buff.multi:
				buff_mod *= buff.value
			else:
				buff_flat += buff.value
				
	value += buff_flat
	value = value*buff_mod
	
	return value

func get_intellect() -> int:
	var value = hero.intellect
	var buff_mod := 1.0
	var buff_flat := 0
	
	for buff in buff_list:
		if buff.target_stat == 2:
			if buff.multi:
				buff_mod *= buff.value
			else:
				buff_flat += buff.value
				
	value += buff_flat
	value = value*buff_mod
	
	return value

#----------------------------------------#
#	     		 CLDWN 			 		 #
#----------------------------------------#

func tick_cooldowns(delta : float):
	special_cooldown -= delta
	mobility_cooldown -= delta
	secondary_cooldown -= delta
