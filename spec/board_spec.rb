require_relative 'spec_helper'

describe Board do
	let(:board) {described_class.new}
	let(:nodes) {board.nodes}

	context '#create_paths_in_each_direction' do

		it 'creates arrays for each possible direction' do
				node = board.nodes[0]
				keys = [:vertical, :horizontal, :l_to_r_diagonal]

				output = board.create_paths_in_each_direction(node)
				is_array = output.to_a.all? {|item| item[1].class == Array}
				result = keys.all? {|key| output.has_key?(key)}

				expect(result).to be(true)
				expect(is_array).to be(true)
		end

		it 'creates each possible direction for a center square' do
				node = board.nodes[4]
				keys = [:vertical, :horizontal, :l_to_r_diagonal, :r_to_l_diagonal]

				output = board.create_paths_in_each_direction(node)
				result = keys.all? {|key| output.has_key?(key)}

				expect(result).to be(true)
		end

		it 'the paths have length of three' do
				node = board.nodes[0]

				output = board.create_paths_in_each_direction(node)
				result = output.to_a.all? {|item| item[1].length == 3}

				expect(result).to be(true)
		end
	end

	context '#get_all_with_content' do
		it 'retrieves an empty list if there are no matches' do
			expect(board.get_all_with_content("X").length).to eq(0)
		end

		it 'retrieves all nodes matching a certain mark' do
			nodes[0].content = "X"
			nodes[5].content = "X"
			nodes[8].content = "X"
			expect(board.get_all_with_content("X").length).to eq(3)
		end
	end

end