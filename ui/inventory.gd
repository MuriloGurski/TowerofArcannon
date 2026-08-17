extends Control

@onready var inventory_slots : GridContainer = $"Inventory Container/Inventory Slots"
@onready var equipment_box : HBoxContainer = $"Inventory Container/Equipment Box"

var inventory_map : Dictionary = {}
var equipment_map : Dictionary = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_ready_inventory()
	_ready_equipment()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _ready_inventory():
	
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
func _ready_equipment():
	
	var equipment_left = equipment_box.get_child(0)
	var equipment_right = equipment_box.get_child(2)
	
	var left_children = equipment_left.get_children()
	var right_children = equipment_right.get_children()
	
	for i in range(left_children.size()):
		
		var slot_node = left_children[i]
		
		var y = i
		var coords = Vector2i(0,y)
		equipment_map[coords] = null
		
		if slot_node.has_method("set_grid_position"):
			slot_node.set_grid_position(coords)
	
	for i in range(right_children.size()):
		
		var slot_node = right_children[i]
		
		var y = i
		var coords = Vector2i(1,y)
		equipment_map[coords] = null
		
		if slot_node.has_method("set_grid_position"):
			slot_node.set_grid_position(coords)
	
	print("Equipment map initialized: ", equipment_map.size(), " slots mapped.")
func _find_free_inventory_slot():
	for key in inventory_map:
		if inventory_map[key] == null:
			print(key)
			return key
		else:
			pass
			
	print("Inventory Full")
