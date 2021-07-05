extends CollisionPolygon2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_node("../star").name)
	var polygon = get_node("../star").polygon
	set_polygon(polygon)
	print(polygon)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
