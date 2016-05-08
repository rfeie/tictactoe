require_relative 'spec_helper'


describe PersonPlayer do
	let (:player) {described_class.new("Player 1", "X")}
	let (:ui) {player.ui}
	let (:board) {NodeMap.new}

	before :each do
		silence_output
		player.board = board
	end

	context 'get move' do

		it 'calls for user input' do
			expect(ui).to receive(:get_input)
			player.get_move
		end

		it 'returns the numerical value minus one' do
			expect(ui).to receive(:get_input).and_return("9")
			expect(player.get_move).to eq(8)
		end

		it 'does not accept a value less than one' do
			allow(ui.input).to receive(:gets).twice.and_return("0", "2")
			expect(player.get_move).to eq(1)
		end
		it 'does not accept a value more than 9' do
			allow(ui.input).to receive(:gets).twice.and_return("10", "9")
			expect(player.get_move).to eq(8)
		end

		it 'allows for valid values if width and height of board change' do
			player.board.height = 4
			player.board.width = 4
			allow(ui.input).to receive(:gets).twice.and_return("16")
			expect(player.get_move).to eq(15)
		end

		it 'still disallows invalid values if width and height of board change' do
			player.board.height = 4
			player.board.width = 4
			allow(ui.input).to receive(:gets).twice.and_return("17", "15")
			expect(player.get_move).to eq(14)
		end
	end	

end