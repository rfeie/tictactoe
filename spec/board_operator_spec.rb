require_relative 'spec_helper'

describe BoardOperator do
	let(:board) {Board.new}
	let(:board_operator) {described_class.new}
	let(:nodes) {board.nodes}

	context '#get_path_for_direction' do
		it 'returns path of specified direction for a node' do
			node = nodes[0]
			second_node = nodes[4]
			third_node = nodes[8]
			expected_path = [node, second_node, third_node]
			expect(board_operator.get_path_for_direction(node, :lower_right)).to eq(expected_path)
		end
	end

	context '#get_path_for_each_direction' do
		it 'returns each path in each direction for a node' do
			node = nodes[0]
			expected_object = {
				right: board_operator.get_path_for_direction(node, :right),
				below: board_operator.get_path_for_direction(node, :below),
				lower_right: board_operator.get_path_for_direction(node, :lower_right)
			}
			expect(board_operator.get_path_for_each_direction(node)).to eq(expected_object)
		end		
	end

	context '#trim_directions' do
		it "cleans each direction only including at supplied object with no marks" do
			node = nodes[0]
			supplied_object = board_operator.get_path_for_each_direction(node)
			expected_object = {}
			expect(board_operator.trim_directions(supplied_object, "X")).to eq(expected_object)
		end
		it "cleans each direction only including at supplied object with marks set" do
			node = nodes[0]
			second_node = nodes[1]
			node.content = "X"
			second_node.content = "X"
			supplied_object = board_operator.get_path_for_each_direction(node)
			expected_object = {right: [node, second_node], below: [node], lower_right: [node]}
			expect(board_operator.trim_directions(supplied_object, "X")).to eq(expected_object)
		end
	end

	context '#create_full_row_from_directions' do
		it 'creates merged directions from a directions array removing any merged directions that are less than three' do
			mock_directions = {
				above: [3,0],
				below: [3,6],
				right: [3, 4,5],
				upper_right: [3, 1],
				lower_right: [3, 7]
			}
			expected_full_directions = {
				vertical: [0,3,6],
				horizontal: [3, 4, 5]
			}
			max_length = 3
			
			expect(board_operator.create_full_row_from_directions(mock_directions, max_length)).to eq(expected_full_directions)
		end
	end


end