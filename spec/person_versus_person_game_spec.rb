require_relative 'spec_helper'

describe PersonVersusPersonGame do
	before :each do
		block_game_running
		silence_output
	end

	context 'player creation' do
		before :each do
			allow_any_instance_of(UserInterface).to receive(:get_input)
			@player_1 = PersonPlayer.new("Player 1", "X")
			@player_2 = PersonPlayer.new("Player 2", "O")
		end

		it 'creates two person players' do
			expect(PersonPlayer).to receive(:new).twice.and_return(@player_1, @player_2)
			described_class.new
		end

		it 'second player creation receives player to check against' do
			game = described_class.new
			allow_any_instance_of(FirstPlayerGenerator).to receive(:create_person_player).with(no_args).and_return(@player_1)
			expect_any_instance_of(AdditionalPlayerGenerator).to receive(:create_person_player).with(an_instance_of(PersonPlayer)).and_return(@player_2)
			game.create_players
		end
	end
end