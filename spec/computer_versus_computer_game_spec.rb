require_relative 'spec_helper'

describe ComputerVersusComputerGame do

	before :each do 
		allow_any_instance_of(described_class).to receive(:start)
		allow_any_instance_of(Kernel).to receive(:sleep)
		silence_output
		ui = generate_ui
		@game = described_class.new(ui: ui)
		allow(ui).to receive(:get_input).twice.and_return("A","B")
		allow(ui).to receive(:display)
	end

	it 'creates two computer players' do
		expect(ComputerPlayer).to receive(:new).twice.and_return(ComputerPlayer.new("Computer Player 1", "A"), ComputerPlayer.new("Computer Player 2", "B"))
		@game.create_players
	end

	it 'ends in a draw' do
		@game.create_players
		@game.current_turns_player = @game.player_1
		allow(@game).to receive(:end_game)
		@game.run
		expect(@game.game_state).to eq(:draw)		
	end

end