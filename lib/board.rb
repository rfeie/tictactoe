class Board

	attr_accessor :nodes, :height, :width, :max_length

	def initialize(width: 3, height: 3, board_data: NodeMap.new(width, height), board_view: BoardView.new(board_data))
		@board_view = board_view 
		@nodes = board_data.nodes
		@width = width
		@height = height
		@max_length = @height < @width ? @height : @width

	end

	def get_longest_streak(nodes)
		longest_streak = []
		nodes.each do |node|
			possible_streaks = get_path_for_each_direction(node)
			removed_other_mark_and_nil = trim_directions(possible_streaks, node.content)
			streak = get_longest_directions_streak(removed_other_mark_and_nil)
			longest_streak = streak if streak.length > longest_streak.length
		end
		longest_streak
	end

	def get_all_with_content(content)
		matches = []
		nodes.each do |node|
			matches << node if node.content == content
		end
		matches
	end

	def generate_board 
		board_view.generate_board
	end

	def set_nodes_content(pos, content)
		node = nodes[pos]
		node.content = content
	end

	def get_path_for_each_direction(node)
		directions = {}
		node.directions.each do |direction, adjacent_space| 
			unless adjacent_space == :edge
				directions[direction] = get_path_for_direction(node, direction)
			end
		end
		directions
	end
	
	def get_path_for_direction(node, direction)
		path = []
		space_to_check = node
		until space_to_check == :edge
			path << space_to_check
			space_to_check = space_to_check.directions[direction]			
		end
		path
	end

	def trim_directions(directions, correct_char)
		trimmed_directions = {}
		directions.each do |direction, path|
			cleaned_path = clean_path(path, correct_char)
			trimmed_directions[direction] = cleaned_path if cleaned_path != []
		end
		trimmed_directions
	end

	def clean_path(path, correct_char)
		cleaned_path = []
		path.each do |item|
			if item.content == correct_char
				cleaned_path << item  
			else 
				return cleaned_path
			end
		end
		cleaned_path
	end

	def get_longest_directions_streak(directions)
		longest_streak = []
		directions.each do |direction, streak|
			longest_streak = streak if streak.length > longest_streak.length
		end
		longest_streak
	end
 
	def get_full_rows_of_node(node, length = max_length)
		directions = get_path_for_each_direction(node)
		full_row_directions = create_full_row_from_directions(directions, length)
	end

	def create_full_row_from_directions(directions, length = max_length)
		full_directions = {
			vertical: merge_directions(directions[:above], directions[:below]),
			horizontal: merge_directions(directions[:left], directions[:right]),
			l_to_r_diagonal: merge_directions(directions[:upper_left], directions[:lower_right]),	
			r_to_l_diagonal: merge_directions(directions[:upper_right], directions[:lower_left])				
		}
		full_directions.delete_if {|direction, array| array.length < length} 
		full_directions
	end

	def merge_directions(front, back)
		merged_array = []
		if front && back
			front_reversed_without_lead_node = front[1..-1].reverse
			merged_array = front_reversed_without_lead_node.concat back
		elsif front
			return front
		elsif back 
			return back
		end
		merged_array
	end

	def path_empty?(path)
		path.all? { |node| node.content.nil?}
	end

	def get_empty_nodes_in_path(path)
		path.select{ |node| node.content.nil? }
	end

	def count_of_non_mark_in_path(path, mark_to_ignore)
		invalid_path_count = 0

		return invalid_path_count if path.any? {|node| node.content == mark_to_ignore}

		path.count do |node|
			node.content
		end
	end	

	def find_unmixed_mark(path)
		unmixed_mark_path = get_unmixed_path(path.dup)
		unmixed_mark_path.first
	end

	def count_unmixed_mark(path)
		unmixed_mark_path = get_unmixed_path(path.dup)
		unmixed_mark_path.length
	end

	def get_unmixed_path(path)
		mark = nil
		processed_path = []
		until path.empty?
			node = path.shift			
			content = node.content
			next if content.nil?
			mark ||= content
			if mark != content
				return []
			else
				processed_path << content
			end
		end
		processed_path
	end

	private 

	attr_reader :board_view

end