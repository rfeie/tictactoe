require_relative 'spec_helper'

describe PathOperator do

	let (:path_operator) { described_class.new }
	let(:nodes) {NodeMap.new.nodes}

	context '#path_empty?' do
		let (:path) do
			[nodes[0], nodes[1], nodes[2]]
		end
		it 'returns true if the content in the nodes in the path are all nil' do
			expect(path_operator.path_empty?(path)).to be(true)
		end

		it 'returns false if there is non-nil content' do
			path[0].content = "X"
			expect(path_operator.path_empty?(path)).to be(false)
		end
	end

	context '#count_unmixed_mark' do
		let (:path) do
			[nodes[0], nodes[1], nodes[2]]
		end

		it 'returns 0 if there are two different marks' do
			path[0].content = "X"
			path[1].content = "O"
			expect(path_operator.count_unmixed_mark(path)).to eq(0)
		end
		it 'returns 0 if the path is empty' do
			expect(path_operator.count_unmixed_mark(path)).to eq(0)
		end
		it 'returns 2 if there are two of a mark in the path' do
			path[0].content = "X"
			path[1].content = "X"
			expect(path_operator.count_unmixed_mark(path)).to eq(2)
		end
	end

	context '#find_unmixed_mark' do
		let (:path) do
			[nodes[0], nodes[1], nodes[2]]
		end

		it 'returns nil if there are two different marks' do
			path[0].content = "X"
			path[1].content = "O"
			expect(path_operator.find_unmixed_mark(path)).to eq(nil)
		end
		it 'returns nil if the path is empty' do
			expect(path_operator.find_unmixed_mark(path)).to eq(nil)
		end
		it 'returns "X" if there are two of a mark in the path' do
			path[0].content = "X"
			path[1].content = "X"
			expect(path_operator.find_unmixed_mark(path)).to eq("X")
		end
	end

end