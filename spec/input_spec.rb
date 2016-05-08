require_relative 'spec_helper'

describe Input do
	
	context '#new' do
		it 'takes an input method' do
			input_method = StringIO.new
			input = described_class.new(input_method)
			expect(input.input).to eq(input_method)
		end
	end

	context '#gets' do
		it 'gets input' do
			input = Input.new($stdin)
			expect(input.input).to receive(:gets)
			input.gets
		end
	end

end