require_relative 'spec_helper'

describe PersonVersusComputerGame do

	before :each do
		block_game_running
		silence_output
		allow_any_instance_of(UserInterface).to receive(:get_input).and_return("X","Player 1", "O")
	end

	context 'player creation' do

		it 'creates a person player' do
			expect(PersonPlayer).to receive(:new).and_return(PersonPlayer.new("Player 1", "X"))
			described_class.new
		end
		it 'creates a computer player' do
			expect(ComputerPlayer).to receive(:new).and_return(ComputerPlayer.new("Computer Player 2", "O"))
			described_class.new
		end

		it 'computer player has correct mark' do
			game = described_class.new
			expect(game.player_2.mark).to eq("O")
		end

	end	
	
end