extends Node2D

class_name Renderer

func draw_triangle(triangle, canvas):
	var c = Color("#d7ffc7")
	canvas.draw_line(triangle.a, triangle.b,c)
	canvas.draw_line(triangle.b, triangle.c, c)
	canvas.draw_line(triangle.c, triangle.a, c)
	
func delaunay(triangles, canvas):
	for triangle in triangles:
		draw_triangle(triangle, canvas)
	return triangles
	
func vedges(nodes, canvas):
	for node in nodes:
		for edge in node.neighbours:
			canvas.draw_line(edge.a, edge.b, Color("#ffffff"))
			
func voronoi(nodes, canvas):
	for node in nodes:
		if node.edge_node: continue
		canvas.draw_colored_polygon(node.polygon, Color(randf(), randf(), randf()))
		
func districts(districts, canvas):
	for district in districts:
		canvas.draw_colored_polygon(district.polygon, district.color)
