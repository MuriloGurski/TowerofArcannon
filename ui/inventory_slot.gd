extends Panel

var grid_position : Vector2i
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_grid_position(coords: Vector2i) -> void:
	grid_position = coords

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_on_slot_clicked()
			
func _on_slot_clicked():
	print("Clicked visual slot at grid coordinate: ", grid_position)
