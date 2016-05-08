require_relative 'spec_helper'

describe Output do

	let(:output_method) {StringIO.new}
	let(:output) {described_class.new(output_method)}

	context '#new' do
		it 'takes an output method' do
			expect(output.output).to eq(output_method)
		end
	end

	context '#puts' do
		it 'adds string to the output' do
			test_string = "Test String"
			output.puts(test_string)
			expect(output.output.string).to eq("Test String\n")
		end
	end

	context '#print' do
		it 'adds string to the output' do
			test_string = "Test String"
			output.print(test_string)
			expect(output.output.string).to eq("Test String")
		end
	end
end