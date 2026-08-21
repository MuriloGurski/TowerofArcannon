extends Resource
class_name Item

enum ItemCategory {
	ARMOR,
	JEWELRY,
	CONSUMABLE,
	MATERIAL,
	TRINKET,
	MISC
}

@export var name : String = "Unknown Item"
@export var texture : Texture2D
@export var is_stackable : bool = false
@export var max_stack : int = 99
@export var category : ItemCategory
@export var equipment_type : EquipmentType.Type
