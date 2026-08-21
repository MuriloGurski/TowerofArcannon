extends Panel

signal inventory_slot_clicked(coords: Vector2i, event_button : int)

var grid_position : Vector2i
@onready var item_sprite: TextureRect = $"Item Sprite"
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
		inventory_slot_clicked.emit(grid_position, event.button_index)
	
func set_item(item : Item):
	if item == null:
		item_sprite.texture = null
		return
		
	item_sprite.texture = item.texture
