class NodeMap 
	attr_accessor :nodes, :width, :height

	def initialize(width = 3, height = 3)
		@nodes = []
		@width = width
		@height = height
		area = width * height
		area.times do |pos|
			@nodes << Node.new(pos)
		end
		map_nodes
	end

	private

	def map_nodes
		@height.times do |row_num|
			@width.times do |col_num|
				grid_position = (row_num * @width) + col_num
				current_node = @nodes[grid_position]
				map_node(current_node, row_num, col_num)
			end
		end
	end

	def map_node(node, row_num, col_num)
		node.directions.each do |direction, value|
			map_direction(node, direction, row_num, col_num)
		end
	end

	def map_direction(node, direction, row_num, col_num)
		case direction
		when :above
			set_above(node, row_num)
		when :below
			set_below(node, row_num)
		when :left
			set_left(node, col_num)
		when :right
			set_right(node, col_num)
		when :upper_left
			set_upper_left(node, row_num, col_num)
		when :upper_right
			set_upper_right(node, row_num, col_num)
		when :lower_left
			set_lower_left(node, row_num, col_num)
		when :lower_right
			set_lower_right(node, row_num, col_num)		
		end
	end

	def set_above(node, row_num)
		if row_num != 0
			connecting_node_pos = node.pos - @width
			connecting_node = @nodes[connecting_node_pos]
			connect_nodes(node, connecting_node, :above)
		else
			node.directions[:above] = :edge
		end
	end

	def set_below(node, row_num)
		if row_num != @height - 1
			connecting_node_pos = node.pos + @width
			connecting_node = @nodes[connecting_node_pos]
			connect_nodes(node, connecting_node, :below)
		else
			node.directions[:below] = :edge
		end
	end

	def set_left(node, col_num)
		if col_num != 0
			connecting_node_pos = node.pos - 1 
			connecting_node = @nodes[connecting_node_pos]
			connect_nodes(node, connecting_node, :left)
		else
			node.directions[:left] = :edge
		end
	end

	def set_right(node, col_num)
		if col_num != @width -1
			connecting_node_pos = node.pos + 1 
			connecting_node = @nodes[connecting_node_pos]
			connect_nodes(node, connecting_node, :right)
		else
			node.directions[:right] = :edge
		end
	end

	def set_upper_left(node, row_num, col_num)
		if row_num != 0 && col_num != 0
			connecting_node_pos = node.pos - @width - 1 
			connecting_node = @nodes[connecting_node_pos]
			connect_nodes(node, connecting_node, :upper_left)
		else
			node.directions[:upper_left] = :edge
		end
	end

	def set_upper_right(node, row_num, col_num)
		if row_num != 0 && col_num != @width - 1
			connecting_node_pos = node.pos - @width + 1
			connecting_node = @nodes[connecting_node_pos]
			connect_nodes(node, connecting_node, :upper_right)
		else
			node.directions[:upper_right] = :edge
		end
	end

	def set_lower_left(node, row_num, col_num)
		if row_num != @height - 1 && col_num != 0
			connecting_node_pos = node.pos + @width - 1 
			connecting_node = @nodes[connecting_node_pos]
			connect_nodes(node, connecting_node, :lower_left)
		else
			node.directions[:lower_left] = :edge
		end
	end

	def set_lower_right(node, row_num, col_num)
		if row_num != @height - 1 && col_num != @width - 1
			connecting_node_pos = node.pos + @width + 1
			connecting_node = @nodes[connecting_node_pos]
			connect_nodes(node, connecting_node, :lower_right)
		else
			node.directions[:lower_right] = :edge
		end
	end

	def connect_nodes(node, connecting_node, direction)
		opposite_directions = {
			left: :right,
			right: :left,
			above: :below,
			below: :above,
			upper_left: :lower_right,
			lower_right: :upper_left,
			upper_right: :lower_left,
			lower_left: :upper_right
		}
		opposite_direction = opposite_directions[direction]
		node.directions[direction] = connecting_node
		connecting_node.directions[opposite_direction] = node
	end

end