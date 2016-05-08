class BoardView
	attr_accessor :board_data, :board_template

	def initialize(board_data = NodeMap.new)
		config = GameConfig.new
		@board_data = board_data
		board_info = config.data["board"]
		@board_template = piece_together_board(board_info)
	end

	def generate_board
		processed_board = board_template.dup
		board_data.nodes.each do |node|
			visual_pos = node.pos + 1
			board_pos = visual_pos
			if node.content
				processed_board.sub!("{#{node.pos.to_s}}", node.content)
			else
				processed_board.sub!("{#{node.pos.to_s}}", board_pos.to_s)
			end
		end
		processed_board
	end

	private

	def piece_together_board(board_info)
		finished_board = ""
		width = board_info["width"]
		height = board_info["height"]
		column_separator = board_info["column_separator"]
		height.times do |row_num|
			row = ''
			width.times do |pos|
				grid_position = (row_num * width) + pos				
				procesed_cell = board_info["cell"].sub("{num}", "#{'{' + grid_position.to_s + '}'}")
				if pos == 0
					row << procesed_cell
				else
					row = combine_cells(row, procesed_cell, column_separator)
				end
			end
			finished_board += row
			if row_num != height - 1	
				finished_board += "\n"
				finished_board += create_row_separator(board_info["row_separator"], row)  
				finished_board += "\n"
			end
		end
		finished_board
	end

	def combine_cells(cell_1,cell_2, separator = '')
		cell_1_array = cell_1.split("\n")
		cell_2_array = cell_2.split("\n")
		joined_array = []
		cell_1_array.length.times do |num|
			new_value = cell_1_array[num] + separator + cell_2_array[num]
			joined_array << new_value

		end
		joined_array.join("\n")
	end

	def create_row_separator(separator, row)
		row_length = calculate_row_length(row)
		separator * row_length
	end

	def calculate_row_length(row)
		if row.index("\n")
			return row.index("\n")	
		else
			row.length
		end
	end

end