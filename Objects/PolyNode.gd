extends BaseButton

var polygon
var neighbours
var edge_node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.button_pressed:
		self.set_position(get_global_mouse_position())

func update(site):
	polygon = site.polygon
	neighbours = site.neighbours
	edge_node = site.neighbours.size() != site.source_triangles.size()

func distance(node):
	return sqrt(pow(self.position.x - node.position.x, 2) + pow(self.position.y - node.position.y, 2))
