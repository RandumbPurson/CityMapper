extends Node
class_name PolyGraph

var vertex_dict

func _init():
	vertex_dict = {}

func dict_list_append(key, val, dict):
	if key in dict:
		dict[key].append(val)
	else:
		dict[key] = [val]

func dict_list_in(key, val, dict):
	if key in dict:
		if val in dict[key]: return true
	return false
	
func dict_list_erase(key, val, dict):
	dict[key].erase(val)
	if dict[key].size() == 0:
		dict.erase(key)

func add_edge(edge):
	if !dict_list_in(edge.a, edge.b, vertex_dict):
		dict_list_append(edge.a, edge.b, vertex_dict)
		dict_list_append(edge.b, edge.a, vertex_dict)
	else:
		dict_list_erase(edge.a, edge.b, vertex_dict)
		dict_list_erase(edge.b, edge.a, vertex_dict)

func add_site(site):
	for edge in site.neighbours:
		add_edge(edge)
		
func get_cycle():
	if vertex_dict.size() == 0: return []
	
	var prev = null
	var start = vertex_dict.keys()[0]
	var cur = start
	var next = null
	
	var cycle = []
	while true:
		cycle.append(cur)
		next = vertex_dict[cur].filter(func(v): return v != prev)
		next = next[0]
		prev = cur
		cur = next
				
		if cur == start: break
	cycle.append(start)
	return cycle
