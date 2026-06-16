extends Node2D
@export var room_scene : PackedScene
@onready var rooms_container = $Rooms
const ROOM_WIDTH = 1152
const ROOM_HEIGHT = 656
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D.zoom = Vector2(0.075, 0.075)
	var directions = [
	Vector2i(1, 0),
	Vector2i(-1, 0),
	Vector2i(0, 1),
	Vector2i(0, -1)
]
	var frontier = [Vector2i(0,0)]
	var dungeon_grid = {}
	var room_instances = {}
	dungeon_grid[Vector2i(0,0)] = "start"
	
	while dungeon_grid.size() < 15:
		var origin
		#Picking frontier
		if randf() < 0.5:
			origin = frontier.back()
		else:
			origin = frontier.pick_random()
		
		#Picking candidate
		var direction = directions.pick_random()
		var candidate = origin + direction
		
		if abs(candidate.x) > 5:
			continue
		if abs(candidate.y) > 5:
			continue
		
		#Verify if candidate is valid
		if not dungeon_grid.has(candidate):
			var neighbours_count = 0
			for dir in directions:
				if dungeon_grid.has(candidate+dir):
					neighbours_count += 1
			
			var should_place = false
			
			if neighbours_count <= 1:
				should_place = true
			elif randf() < 0.1:
				should_place = true
				
			if should_place:
				dungeon_grid[candidate] = "normal"
				frontier.append(candidate)
				
	#Print Dungeon Layout
	#for y in range(-7, 7):
		#var line = ""
		#for x in range(-7, 7):
			#var pos = Vector2i(x, y)
			#if dungeon_grid.has(pos):
				#line += "# "
			#else:
				#line += ". "
		#print(line)
			
	#for pos in dungeon_grid:
		#print(pos)
	
	pass # Replace with function body.

	#Place Rooms
	
	for pos in dungeon_grid:
		var room = room_scene.instantiate()
		
		room.name = "Room_" + str(pos.x) + "_" + str(pos.y)
		
		room.position = Vector2(
			pos.x * ROOM_WIDTH,
			pos.y * ROOM_HEIGHT
		)
		rooms_container.add_child(room)
		room_instances[pos] = room
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
