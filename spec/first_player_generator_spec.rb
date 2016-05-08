require_relative 'spec_helper'

describe FirstPlayerGenerator do
	let (:generator) {described_class.new}
	let (:config) {get_config_values["player"]}

	before :each do
		silence_output
	end

	context '#create_computer_player' do
		before :each do
			allow(generator).to receive(:get_player_mark)
		end

		it 'pulls the default computer player names from the config file' do
			names = config["computer_player"]["default_names"]
			player = generator.create_computer_player
			expect(names.include?(player.name)).to be(true)
		end

	end

	context '#create_person_player' do
		before :each do
			allow(generator).to receive(:get_player_mark).twice.and_return("X", "O")
			allow(generator).to receive(:get_person_player_name).twice.and_return("Player 1", "Player 2")

		end

		it 'creates a player with the supplied mark' do
			player = generator.create_person_player
			expect(player.mark).to eq("X")
		end
		
		it 'creates a player with the supplied name' do
			player = generator.create_person_player
			expect(player.name).to eq("Player 1")
		end

	end

	context '#get_person_player_name' do


		it 'does not accept a name shorter than two' do
			short_name = "X"
			valid_name = "Player 1"
			allow(generator.ui.input).to receive(:gets).twice.and_return(short_name, valid_name)
			name = generator.create_person_player.name
			expect(name).to eq(valid_name)			
		end

		it 'does not accept a name longer than config value' do
			max_length = config["person_player"]["maximum_length"]
			long_name = "X" * (max_length + 1)
			valid_name = "Player 1"
			allow(generator.ui.input).to receive(:gets).at_least(3).times.and_return("X", long_name, valid_name)
			name = generator.create_person_player.name
			expect(name).to eq(valid_name)			
		end

	end

	context '#get_player_mark' do
		it 'gets player mark' do
			player_mark = "X"
			allow(generator.ui.input).to receive(:gets).and_return(player_mark, "Player 1")
			mark = generator.create_person_player.mark
			expect(mark).to eq(player_mark)			
		end

		it 'does not accept a mark longer than one' do
			long_mark = "AB"
			valid_mark = "X"
			allow(generator.ui.input).to receive(:gets).twice.and_return(long_mark, valid_mark, "Player 1")
			mark = generator.create_person_player.mark
			expect(mark).to eq(valid_mark)			
		end

		it 'does not accept an empty mark' do
			no_mark = ""
			valid_mark = "X"
			allow(generator.ui.input).to receive(:gets).twice.and_return(no_mark, valid_mark, "Player 1")
			mark = generator.create_person_player.mark
			expect(mark).to eq(valid_mark)			
		end

		it 'does not accept a numerical mark' do
			numerical_mark = "1"
			valid_mark = "X"
			allow(generator.ui.input).to receive(:gets).twice.and_return(numerical_mark, valid_mark, "Player 1")
			mark = generator.create_person_player.mark
			expect(mark).to eq(valid_mark)			
		end

	end
end