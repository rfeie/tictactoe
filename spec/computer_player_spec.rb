require_relative 'spec_helper' 

describe ComputerPlayer do

	before :each do
		@player = ComputerPlayer.new("Computer Player 1", "O")
		@player.board = Board.new
		silence_output
	end

	context '#get_move' do
		before :each do
			allow_any_instance_of(Kernel).to receive(:sleep)
		end

		it 'returns a digit' do
			expect(@player.get_move.class).to eq(Fixnum)
		end
	end

	context 'computer interaction' do
		it 'thinks about it' do
			expect(@player).to receive(:sleep).at_least(:once)
			@player.get_move
		end
	end

end