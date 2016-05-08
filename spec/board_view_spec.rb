require_relative 'spec_helper'

describe BoardView do
	let (:board) {described_class.new}
	
	context 'new' do
		it 'loads a board' do
			file_path = File.join(File.dirname(__FILE__), '/assets')
			expected_board_template = File.read(file_path + '/board.txt')
			expect(board.board_template).to eq(expected_board_template)
		end
	end

	context '#generate_board' do
		it 'draws a blank board with numerical placeholders' do
			blank_board = "     |     |     
  1  |  2  |  3  
     |     |     
=================
     |     |     
  4  |  5  |  6  
     |     |     
=================
     |     |     
  7  |  8  |  9  
     |     |     "

			expect(board.generate_board).to eq(blank_board)
		end

		it 'draws a board with placeholders and marks in the correct place' do
			board.board_data.nodes[0].content = "X"
			board.board_data.nodes[4].content = "O"
			board.board_data.nodes[3].content = "X"
			customized_board = "     |     |     
  X  |  2  |  3  
     |     |     
=================
     |     |     
  X  |  O  |  6  
     |     |     
=================
     |     |     
  7  |  8  |  9  
     |     |     "

			expect(board.generate_board).to eq(customized_board)
		end

	end

end