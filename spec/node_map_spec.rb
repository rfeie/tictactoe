require_relative 'spec_helper'

describe NodeMap do
	let(:nodemap) {NodeMap.new}

	context 'new' do
		it 'creates 9 nodes' do
			expect(nodemap.nodes.length).to eq(9)
		end
		
		it 'connects the horizontal nodes together' do
			horizontal_node = nodemap.nodes[0].directions[:right].directions[:right]
			expect(horizontal_node.pos).to eq(2)
		end

		it 'connects the vertical nodes together' do
			vertical_node = nodemap.nodes[0].directions[:below].directions[:below]
			expect(vertical_node.pos).to eq(6)
		end

		it 'connects the diagonal nodes together' do
			diagonal_node = nodemap.nodes[0].directions[:lower_right].directions[:lower_right]
			expect(diagonal_node.pos).to eq(8)
		end

		it 'notes the edge of a node' do
			lower_right_node = nodemap.nodes[8]
			expect(lower_right_node.directions[:right]).to eq(:edge)
		end
	end
end