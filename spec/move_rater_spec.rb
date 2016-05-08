require_relative 'spec_helper' 

describe MoveRater do

	let(:board) { Board.new }
	let(:player_move_mark) { "O" }
	let(:opposing_player_mark) { "X" }
	let(:rater) { described_class.new(player_move_mark, board) }

	context '#new' do
		it 'has a reference to the board' do
			expect(rater.board.class).to eq(Board)
		end

		it 'stores a mark' do
			expect(rater.mark).to eq(player_move_mark)
		end
	end

	context '#get_best_node_from_open_spaces' do
		it 'picks a square if the board is empty' do
			expect(rater.get_best_node_from_open_spaces.pos).to be_between(0, 8).inclusive 
		end

		it 'picks the middle square if board is not empty and it is open' do
			rater.board.nodes[0].content = "X"
			expect(rater.get_best_node_from_open_spaces.pos).to eq(4) 
		end

		it 'picks a square in the path of two existing marks if there is one' do
			rater.board.nodes[0].content = "X"
			rater.board.nodes[1].content = "O"
			rater.board.nodes[4].content = "X"
			expect(rater.get_best_node_from_open_spaces.pos).to eq(8) 
		end

		it 'picks a square in the path of its mark if players are tied for number of streaks' do
			rater.board.nodes[0].content = "X"
			rater.board.nodes[4].content = "O"
			move = rater.get_best_node_from_open_spaces.pos
			possible_moves = [1,2]
			expect(possible_moves.include?(move)).to be(true) 
		end

		it 'picks a square to prevent opponent from winning setting up two streaks' do
			rater.board.nodes[0].content = "X"
			rater.board.nodes[1].content = "O"
			rater.board.nodes[4].content = "O"
			rater.board.nodes[7].content = "X"
			expect(rater.get_best_node_from_open_spaces.pos).to eq(6) 
		end
		
		it 'picks a square to win' do
			rater.board.nodes[0].content = "O"
			rater.board.nodes[2].content = "X"
			rater.board.nodes[3].content = "O"
			rater.board.nodes[4].content = "X"
			rater.board.nodes[5].content = "X"
			expect(rater.get_best_node_from_open_spaces.pos).to eq(6) 
		end

		it 'picks a square if there is no clear good move' do
			rater.board.nodes[0].content = "O"
			rater.board.nodes[1].content = "O"
			rater.board.nodes[2].content = "X"
			rater.board.nodes[3].content = "X"
			rater.board.nodes[4].content = "X"
			rater.board.nodes[5].content = "O"
			rater.board.nodes[6].content = "O"
			expect(rater.get_best_node_from_open_spaces.pos).to be_between(7, 8).inclusive 
		end

		it 'picks a square to win to beat out other player' do
			rater.board.nodes[0].content = "X"
			rater.board.nodes[1].content = "O"
			rater.board.nodes[2].content = "X"
			rater.board.nodes[4].content = "O"
			rater.board.nodes[5].content = "X"
			expect(rater.get_best_node_from_open_spaces.pos).to be(7) 
		end

		it 'picks a square to prevent a no-win situation' do
			rater.board.nodes[0].content = "X"
			rater.board.nodes[4].content = "O"
			rater.board.nodes[8].content = "X"
			correct_moves = [1, 3, 5, 7]
			move = rater.get_best_node_from_open_spaces.pos
			expect(correct_moves.include?(move)).to be(true) 
		end
	end
end