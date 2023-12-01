extends StaticBody2D

var PolyGraph = preload("res://Source/PolyGraph.gd")
var graph

var nodes
var color
var collisionNode
var polygon

func init(nodes=Array(), color=Color(randf(), randf(), randf())):
	collisionNode = get_node("CollisionPolygon2D")
	self.nodes = nodes
	self.color = color
	set_nodes(nodes)

func add_node(node):
	self.nodes.append(node)
	graph.add_site(node)
	self.polygon = graph.get_cycle()
	collisionNode.set_polygon(self.polygon)

func reset():
	self.nodes = []
	self.graph = PolyGraph.new()

func set_nodes(nodes):
	self.reset()
	for node in nodes:
		add_node(node)

