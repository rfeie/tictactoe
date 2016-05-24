class MoveRater 

	BLANK_PATH_RATING = 1
	MARK_RATING = 2

	attr_accessor :board, :mark

	def initialize(mark, board = Board.new)
		@mark = mark
		@board = board
		@path_operator = PathOperator.new
	end
	
	def get_best_node_from_open_spaces
		nodes = @board.get_all_with_content(nil)
		best_move = {
			rating: 0,
			node: nodes.sample
		}
		nodes.each do |node|
			rating = rate_node(node)
			if best_move[:rating] < rating
				best_move[:rating] = rating
				best_move[:node] = node
			end
		end
		best_move[:node]
	end

	private

	def rate_node(node)
		rating = 0
		full_rows_of_node = @board.create_paths_in_each_direction(node)

		full_rows_of_node.each do |direction, path|
			empty_nodes_rating = reserve_node_and_rate_empty_nodes(node, path)
			if @path_operator.path_empty?(path)
				rating += BLANK_PATH_RATING
			else
				rating += rate_path_contents(path)
			end
			rating -= empty_nodes_rating
		end		
		rating
	end

	def rate_path_contents(path)
		mark = @path_operator.find_unmixed_mark(path)
		mark_count = @path_operator.count_unmixed_mark(path)

		if able_to_win?(mark, mark_count)
			multiplier = (mark_count ** mark_count) * 2
		else
			multiplier = mark_count ** mark_count					
		end
		calculated = MARK_RATING * multiplier		
	end

	def able_to_win?(mark, mark_count)
		mark == @mark && mark_count >= @board.max_length - 1
	end

	def reserve_node_and_rate_empty_nodes(node, path)
		node.content = @mark
		empty_nodes_rating = rate_empty_nodes_in_path(path)
		node.content = nil		
		empty_nodes_rating
	end

	def rate_empty_nodes_in_path(path)
		rating = 0
		empty_nodes = @path_operator.get_empty_nodes_in_path(path)
		empty_nodes.each do |node|
			rating += rate_opposing_node(node)
		end
		rating
	end

	def rate_opposing_node(node)
		rating = 0
		full_rows_of_node = @board.create_paths_in_each_direction(node)

		full_rows_of_node.each do |direction, path|
			mark_count = @path_operator.count_of_non_mark_in_path(path, @mark)
			rating += mark_count
		end		
		calculate_opposing_node_rating(rating)
	end

	def calculate_opposing_node_rating(rating)
		rating_threshold = 2
		if rating >= rating_threshold
			rating * 2
		else
			0
		end		
	end

end