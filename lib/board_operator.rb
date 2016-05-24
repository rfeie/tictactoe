class BoardOperator

	def get_path_for_each_direction(node)
		directions = {}
		node.directions.each do |direction, adjacent_space| 
			unless adjacent_space == :edge
				directions[direction] = get_path_for_direction(node, direction)
			end
		end
		directions
	end

	def get_longest_directions_streak(directions)
		longest_streak = []
		directions.each do |direction, streak|
			longest_streak = streak if streak.length > longest_streak.length
		end
		longest_streak
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

	def trim_directions(directions, correct_char)
		trimmed_directions = {}
		directions.each do |direction, path|
			cleaned_path = clean_path(path, correct_char)
			trimmed_directions[direction] = cleaned_path if cleaned_path != []
		end
		trimmed_directions
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

	private

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


end