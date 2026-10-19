extends Area2D

var direction: Vector2 = Vector2.RIGHT
var speed: float = 500.0
var active_time: float = 1.0

var hit_targets: Array[Node] = []

func setup(
		shape: Shape2D,
		projectile_position: Vector2,
		angle: float,
		projectile_speed: float,
		lifetime: float
	) -> void:

	var collision := CollisionShape2D.new()
	collision.shape = shape
	add_child(collision)
	
	position = projectile_position
	rotation = angle
	
	direction = Vector2.RIGHT.rotated(angle)
	speed = projectile_speed
	active_time = lifetime
	var timer := get_tree().create_timer(active_time)
	timer.timeout.connect(queue_free)
	
	body_entered.connect(_on_body_entered)
	
func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body in hit_targets:
		return

	hit_targets.append(body)

	# Apply damage or trigger your hit logic here.

func _on_lifetime_timeout() -> void:
	queue_free()
