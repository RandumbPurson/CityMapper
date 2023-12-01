extends Node2D

var win_size = Vector2(800, 600)
var n_nodes = 30
var n_districts = 4

var rng = RandomNumberGenerator.new()

var Delaunay = preload("res://addons/gdDelaunay/Delaunay.gd")

var Renderer = preload("res://Source/Renderer.gd")
var render = Renderer.new()

var District = preload("res://Objects/District.tscn")
var districts = Array()

var PolyNode = preload("res://Objects/PolyNode.tscn")
var nodes = Array()


func gen_nodes(n):
	var nodes = Array()
	for i in n:
		var location = Vector2(rng.randi_range(0, win_size.x), rng.randi_range(0, win_size.y))
		var poly_node = PolyNode.instantiate()
		poly_node.position = location
		poly_node.button_up.connect(redraw)
		nodes.append(poly_node)
	return nodes

# Called when the node enters the scene tree for the first time.
func _ready():
	districts.resize(n_districts)
	for n in n_districts:
		var ds = District.instantiate()
		ds.init(Array(), Color(randf(), randf(), randf()))
		districts[n] = ds
	nodes = gen_nodes(n_nodes)
	for node in nodes:
		add_child(node) # Replace with function body.
	partition()

func assign_districts(nodes):
	var num_nodes = nodes.size()/n_districts
	for district in districts:
		if num_nodes == 0: break
		district.reset()
		var cur = nodes.pop_back()
		district.add_node(cur)
		
		for i in num_nodes - 1:
			var dists = []
			for other in nodes:
				dists.append(cur.distance(other))
			var closest_idx = dists.find(dists.min())
			cur = nodes.pop_at(closest_idx)
			district.add_node(cur)

	if nodes.size() > 0:
		var district = districts[0]
		var cur = nodes.pop_back()

		while nodes.size() > 0:
			district.add_node(cur)
			var dists = []
			for other in nodes:
				dists.append(cur.distance(other))
			var closest_idx = dists.find(dists.min())
			cur = nodes.pop_at(closest_idx)

func partition():
	var delaunay = Delaunay.new(Rect2(0, 0, win_size.x, win_size.y))
	for node in nodes:
		delaunay.add_point(node.position)
	var sites = delaunay.make_voronoi(delaunay.triangulate())
	
	# update PolyNodes with site information
	for i in nodes.size(): nodes[i].update(sites[i])
	
	var cnodes = nodes.filter(func(node): return !node.edge_node)
	
	# partition into districts
	assign_districts(cnodes)

func redraw():
	partition()
	queue_redraw()

func _draw():
	#render.voronoi(nodes, self)
	render.districts(districts, self)
	render.vedges(nodes, self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
