require_relative 'spec_helper'

describe Board do
	let(:board) {Board.new}
	let(:nodes) {board.nodes}

	context '#get_path_for_direction' do
		it 'returns path of specified direction for a node' do
			node = nodes[0]
			second_node = nodes[4]
			third_node = nodes[8]
			expected_path = [node, second_node, third_node]
			expect(board.get_path_for_direction(node, :lower_right)).to eq(expected_path)
		end
	end

	context '#get_path_for_each_direction' do
		it 'returns each path in each direction for a node' do
			node = nodes[0]
			expected_object = {
				right: board.get_path_for_direction(node, :right),
				below: board.get_path_for_direction(node, :below),
				lower_right: board.get_path_for_direction(node, :lower_right)
			}
			expect(board.get_path_for_each_direction(node)).to eq(expected_object)
		end		
	end

	context '#trim_directions' do
		it "cleans each direction only including at supplied object with no marks" do
			node = nodes[0]
			supplied_object = board.get_path_for_each_direction(node)
			expected_object = {}
			expect(board.trim_directions(supplied_object, "X")).to eq(expected_object)
		end
		it "cleans each direction only including at supplied object with marks set" do
			node = nodes[0]
			second_node = nodes[1]
			node.content = "X"
			second_node.content = "X"
			supplied_object = board.get_path_for_each_direction(node)
			expected_object = {right: [node, second_node], below: [node], lower_right: [node]}
			expect(board.trim_directions(supplied_object, "X")).to eq(expected_object)
		end
	end

	context '#count_unmixed_mark' do
		let (:path) do
			[nodes[0], nodes[1], nodes[2]]
		end

		it 'returns 0 if there are two different marks' do
			path[0].content = "X"
			path[1].content = "O"
			expect(board.count_unmixed_mark(path)).to eq(0)
		end
		it 'returns 0 if the path is empty' do
			expect(board.count_unmixed_mark(path)).to eq(0)
		end
		it 'returns 2 if there are two of a mark in the path' do
			path[0].content = "X"
			path[1].content = "X"
			expect(board.count_unmixed_mark(path)).to eq(2)
		end
	end

	context '#find_unmixed_mark' do
		let (:path) do
			[nodes[0], nodes[1], nodes[2]]
		end

		it 'returns nil if there are two different marks' do
			path[0].content = "X"
			path[1].content = "O"
			expect(board.find_unmixed_mark(path)).to eq(nil)
		end
		it 'returns nil if the path is empty' do
			expect(board.find_unmixed_mark(path)).to eq(nil)
		end
		it 'returns "X" if there are two of a mark in the path' do
			path[0].content = "X"
			path[1].content = "X"
			expect(board.find_unmixed_mark(path)).to eq("X")
		end
	end

	context '#path_empty?' do
		let (:path) do
			[nodes[0], nodes[1], nodes[2]]
		end
		it 'returns true if the content in the nodes in the path are all nil' do
			expect(board.path_empty?(path)).to be(true)
		end

		it 'returns false if there is non-nil content' do
			path[0].content = "X"
			expect(board.path_empty?(path)).to be(false)
		end
	end

	context '#merge_directions' do
		it 'merges two arrays on the lead node' do
			front = [1, 0]
			back = [1, 2]
			expected = [0, 1, 2]
			expect(board.merge_directions(front, back)).to eq(expected)
		end

		it 'returns front if back is not supplied' do
			front = [1, 0]
			expect(board.merge_directions(front, nil)).to eq(front)
		end

		it 'returns back if the front is not supplied' do			
			back = [1, 2]
			expect(board.merge_directions(nil, back)).to eq(back)
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
			
			expect(board.create_full_row_from_directions(mock_directions, max_length)).to eq(expected_full_directions)
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