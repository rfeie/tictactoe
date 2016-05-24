class Board

	attr_accessor :nodes, :height, :width, :max_length

	def initialize(width: 3, height: 3, board_data: NodeMap.new(width, height), board_view: BoardView.new(board_data))
		@board_view = board_view 
		@nodes = board_data.nodes
		@width = width
		@height = height
		@max_length = @height < @width ? @height : @width
		@board_operator = BoardOperator.new

	end

	def create_paths_in_each_direction(node, length = max_length)
		directions = board_operator.get_path_for_each_direction(node)
		full_row_directions = board_operator.create_full_row_from_directions(directions, length)
	end

	def get_longest_streak(nodes)
		longest_streak = []
		nodes.each do |node|
			possible_streaks = board_operator.get_path_for_each_direction(node)
			removed_other_mark_and_nil = board_operator.trim_directions(possible_streaks, node.content)
			streak = board_operator.get_longest_directions_streak(removed_other_mark_and_nil)
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

	private

	attr_reader :board_view, :board_operator

end