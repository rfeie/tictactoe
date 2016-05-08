require_relative 'spec_helper'

describe AdditionalPlayerGenerator do
	let (:generator) {described_class.new}
	let (:config) {get_config_values["player"]}

	before :each do
		silence_output
	end

	context '#create_computer_player' do
		before :each do
			allow(generator).to receive(:get_player_mark)
		end

		it 'will use a different name if name is used' do
			player_1 = double(:player, :mark => "X", :name => "Mao")
			player_2 = generator.create_computer_player(player_1)
			expect(player_1.name).to_not eq(player_2.name)
		end
	end

	context '#create_person_player' do
		before :each do
			allow(generator).to receive(:get_player_mark).and_return("O")
			allow(generator).to receive(:get_person_player_name).and_return("Player 2")

		end

		it 'creates a a second player with the supplied second mark' do
			player_1 = double(:player, :mark => "X", :name => "Player 1")
			player_2 = generator.create_person_player(player_1)
			expect(player_2.mark).to eq("O")
		end
		
		it 'creates a a second player with the supplied second name' do
			player_1 = double(:player, :mark => "X", :name => "Player 1")
			player_2 = generator.create_person_player(player_1)
			expect(player_2.name).to eq("Player 2")
		end
	end

	context '#get_person_player_name' do

		it 'does not accept name that match the supplied name' do
			existing_name = "Player 1"
			valid_name = "Player 2"
			player_1 = double(:player, :mark => "X", :name => existing_name)			
			allow(generator.ui.input).to receive(:gets).and_return("O", existing_name, valid_name)
			name = generator.create_person_player(player_1).name
			expect(name).to eq(valid_name)			
		end
	end

	context '#get_player_mark' do

		it 'does not accept mark that match the supplied mark' do
			existing_mark = "X"
			valid_mark = "O"
			player_1 = double(:player, :mark => existing_mark, :name => "Player 1")			
			allow(generator.ui.input).to receive(:gets).and_return(existing_mark, valid_mark, "Player 2")
			mark = generator.create_person_player(player_1).mark
			expect(mark).to eq(valid_mark)			
		end

		it 'does not accept a numerical, blank, or long mark with a supplied mark' do
			numerical_mark = "1"
			long_mark = "AB"
			no_mark = ""
			existing_mark = "X"
			valid_mark = "O"
			player_1 = double(:player, :mark => existing_mark, :name => "Player 1")			
			allow(generator.ui.input).to receive(:gets).exactly(4).times
										.and_return(no_mark, long_mark, numerical_mark, valid_mark, "Player 2")
			mark = generator.create_person_player(player_1).mark
			expect(mark).to eq(valid_mark)			
		end

	end
end