extends Control

@onready var inventory_slots : GridContainer = $"Inventory Container/Inventory Slots"

var inventory_map : Dictionary = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var cols : int = inventory_slots.columns
	var children = inventory_slots.get_children()
	
	for i in range(children.size()):
		
		var slot_node = children[i]
		
		var x = i % cols
		var y = i / cols
		var coords = Vector2i(x,y)
		
		inventory_map[coords] = null
		
		if slot_node.has_method("set_grid_position"):
			slot_node.set_grid_position(coords)
		
	print("Inventory map initialized: ", inventory_map.size(), " slots mapped.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
