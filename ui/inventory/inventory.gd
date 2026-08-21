extends Control

@onready var inventory_slots : GridContainer = $"Inventory Container/Inventory Slots"
@onready var equipment_box : HBoxContainer = $"Inventory Container/Equipment Box"

var hold_coord = null
var inventory_map : Dictionary = {}
var equipment_map : Dictionary = {}
var inventory_slot_nodes : Dictionary = {}
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
		inventory_slot_nodes[coords] = slot_node
		
		if slot_node.has_method("set_grid_position"):
			slot_node.set_grid_position(coords)
		
		slot_node.inventory_slot_clicked.connect(_on_inventory_slot_clicked)
		
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
		
		slot_node.equipment_slot_clicked.connect(_on_equipment_slot_clicked)
		
	for i in range(right_children.size()):
		
		var slot_node = right_children[i]
		
		var y = i
		var coords = Vector2i(1,y)
		equipment_map[coords] = null
		
		if slot_node.has_method("set_grid_position"):
			slot_node.set_grid_position(coords)
		
		slot_node.equipment_slot_clicked.connect(_on_equipment_slot_clicked)
	
	print("Equipment map initialized: ", equipment_map.size(), " slots mapped.")
func _find_free_inventory_slot():
	for key in inventory_map:
		if inventory_map[key] == null:
			print(key)
			return key
		else:
			pass
			
	print("Inventory Full")
func _on_inventory_slot_clicked(coords: Vector2i, event_button: int):
	print("Inventory call")
	
	if event_button == MOUSE_BUTTON_LEFT:
		
		if hold_coord == null:
			
			if inventory_map[coords] != null:
				hold_coord = coords
				print("Holding: ", coords)
				
		else:
			
			if hold_coord == coords:
				hold_coord = null
				print("Cancelled holding item")
				return
				
			_move_item(hold_coord, coords)
			
	elif event_button == MOUSE_BUTTON_RIGHT:
		
		if inventory_map[coords] == null:
			var test_ring = load("res://items/ring.tres") as Item
			_add_item(test_ring, coords)


func _on_equipment_slot_clicked(coords : Vector2i, event_button : int):
	if event_button == MOUSE_BUTTON_LEFT:
		print("Left click on: ", coords)
	elif event_button == MOUSE_BUTTON_RIGHT:
		print("Right click on: ", coords)
func _add_item(item: Item, coords: Vector2i):
	
	if inventory_map[coords] == null:
		
		inventory_map[coords] = item
		var slot_node = inventory_slot_nodes[coords]
		
		if slot_node.has_method("set_item"):
			slot_node.set_item(item)
			
		print("Added item")
	else:
		print("Slot Occupied")
		
func _move_item(original_coords: Vector2i, target_coords: Vector2i):
	
	var item = inventory_map[original_coords]
	if item == null:
		return
		
	if inventory_map[target_coords] != null:
		print("Target occupied")
		return
		
	inventory_map[original_coords] = null
	inventory_map[target_coords] = item
	
	inventory_slot_nodes[original_coords].set_item(null)
	inventory_slot_nodes[target_coords].set_item(item)
	
	hold_coord = null
