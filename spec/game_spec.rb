require_relative 'spec_helper'

describe Game do
	let (:ui) { generate_ui }

	before :each do
		allow_any_instance_of(UserInterface).to receive(:get_input)
		allow_any_instance_of(Player).to receive(:choose_mark)
	end	

	context "new" do
		before :each do
			allow_any_instance_of(Game).to receive(:run)
		end
	
		it "creates nodemap for the board info" do
			expect(NodeMap).to receive(:new).and_return(NodeMap.new)
			described_class.new(ui: ui)			
		end
		it "creates the board" do
			expect(Board).to receive(:new)
			described_class.new(ui: ui)		
		end		

	end

	context '#start' do
		before :each do
			allow_any_instance_of(Game).to receive(:run)
			@game = described_class.new(ui: ui)
		end

		it "creates players" do
			expect(Player).to receive(:new).twice.and_return(Player.new("Player", "X"))
			@game.start
		end
		
		it "asks who should start first" do
			expect(@game).to receive(:choose_player_to_go_first)
			@game.start			
		end
		
		it "sets the correct current turn" do
			allow(@game.ui).to receive(:get_input).and_return("Player 1")
			@game.start
			expect(@game.current_turns_player).to eq(@game.player_1)
		end

	end

	context '#update_game_state' do
		before :each do
			allow_any_instance_of(Game).to receive(:run)
			@game = described_class.new(ui: ui)
			@game.player_1.mark = "X"
			@game.player_2.mark = "O"
		end

		it "does not update the state if game board is blank" do
			@game.update_game_state
			expect(@game.game_state).to eq(:in_progress)
		end
		
		it "does not update the state if game board is contains only two" do

			@game.board.nodes[2].content = "X" 
			@game.board.nodes[4].content = "X" 
			@game.update_game_state
			expect(@game.game_state).to eq(:in_progress)
		end

		it "returns that a player wins if game board is contains three across consecutively" do

			@game.board.nodes[0].content = "X" 
			@game.board.nodes[1].content = "X" 
			@game.board.nodes[2].content = "X" 
			@game.update_game_state
			expect(@game.game_state).to eq(:player_1_wins)
		end

		it "returns that a player wins if game board is contains three down consecutively" do

			@game.board.nodes[1].content = "O" 
			@game.board.nodes[4].content = "O" 
			@game.board.nodes[7].content = "O" 
			@game.update_game_state
			expect(@game.game_state).to eq(:player_2_wins)
		end

		it "returns that a player wins if game board is contains three diagonally consecutively" do

			@game.board.nodes[2].content = "X" 
			@game.board.nodes[4].content = "X" 
			@game.board.nodes[6].content = "X" 
			@game.update_game_state
			expect(@game.game_state).to eq(:player_1_wins)
		end

		it "returns :draw if board is full but there are no winners" do
			@game.board.nodes[0].content = "X" 
			@game.board.nodes[1].content = "O" 
			@game.board.nodes[2].content = "X" 
			@game.board.nodes[3].content = "O" 
			@game.board.nodes[4].content = "X" 
			@game.board.nodes[5].content = "X" 
			@game.board.nodes[6].content = "O" 
			@game.board.nodes[7].content = "X" 
			@game.board.nodes[8].content = "O" 
			@game.update_game_state
			expect(@game.game_state).to eq(:draw)

		end
	end

	context '#legal_move?' do
		before :each do
			block_game_running
			silence_output
			@game = described_class.new(ui: ui)
			@game.player_1.mark = "X"
			@game.player_2.mark = "O"
		end
		it 'returns false if move is out of bound' do
			illegal_move = 9
			expect(@game.legal_move?(illegal_move)).to be(false)			
		end
		it 'returns false if move is not open' do
			@game.board.nodes[7].content = "X"
			illegal_move = 7
			expect(@game.legal_move?(illegal_move)).to be(false)			
		end
	end

	context '#end_game' do
		before :each do
			block_game_running
			@game = described_class.new(ui: ui)
			@game.player_1.mark = "X"
			@game.player_2.mark = "O"
		end		

		it "announces the end game state if player 1 wins" do
			@game.board.nodes[2].content = "X" 
			@game.board.nodes[4].content = "X" 
			@game.board.nodes[6].content = "X" 
			@game.update_game_state
			@game.end_game			
			expect(@game.ui.output.output.string).to match(/Game is over! Player 1 wins!/)
		end

		it "announces the end game state if player 2 wins" do
			@game.board.nodes[0].content = "O" 
			@game.board.nodes[3].content = "O" 
			@game.board.nodes[6].content = "O" 
			@game.update_game_state
			@game.end_game			
			expect(@game.ui.output.output.string).to match(/Game is over! Player 2 wins!/)
		end

		it "announces the end game state if there is a draw" do
			@game.board.nodes[0].content = "X" 
			@game.board.nodes[1].content = "O" 
			@game.board.nodes[2].content = "X" 
			@game.board.nodes[3].content = "O" 
			@game.board.nodes[4].content = "X" 
			@game.board.nodes[5].content = "X" 
			@game.board.nodes[6].content = "O" 
			@game.board.nodes[7].content = "X" 
			@game.board.nodes[8].content = "O" 
			@game.update_game_state
			@game.end_game			
			expect(@game.ui.output.output.string).to match(/Game is over! This game was a draw!/)
		end
		
		it "says goodbye" do
			@game.end_game			
			expect(@game.ui.output.output.string).to match(/Thank you for playing!\s+Goodbye!/)
		end			
	end
end