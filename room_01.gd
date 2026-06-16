extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var rect = $TileMap.get_used_rect()
	print("Width in tiles: ", rect.size.x)
	print("Height in tiles: ", rect.size.y)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
