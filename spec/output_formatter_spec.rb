require_relative 'spec_helper'


describe OutputFormatter do

	let(:output_formatter) do
		formatter = OutputFormatter.new
		formatter.width = 50
		formatter.margin = 10
		formatter
	end

	let(:test_string) {"Test String"}

	context '#center' do
		it 'centers a a supplied string' do
			expected = "                   Test String                    "
			expect(output_formatter.center(test_string)).to eq(expected)
		end
	end

	context '#left_align' do
		it 'adds a margin to the left of the supplied string' do
			expected = "          Test String"
			expect(output_formatter.left_align(test_string)).to eq(expected)
		end
	end

	context '#right_align' do
		it 'adds a margin to the supplied string to align it with the length of the board' do
			expected = "                                       Test String"
			expect(output_formatter.right_align(test_string)).to eq(expected)
		end
	end

	context '#center_inline' do
		it 'centers with no spaces on the right side' do
			expected = "                   Test String"
			expect(output_formatter.center_inline(test_string)).to eq(expected)
		end
	end
end