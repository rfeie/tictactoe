require_relative 'spec_helper'

describe Response do

	context '#new' do
		it 'connects to an input' do
			expect(Input).to receive(:new)
			described_class.new
		end
		it 'takes reminder text as a Messager' do
			reminder_text = "reminder text"
			reminder_message = Message.new(reminder_text)
			response = described_class.new('',reminder_message)
			expect(response.reminder_message).to eq(reminder_message)
		end

		it 'takes pattern string and converts to regex' do
			test_pattern_string = "^test$"
			expected_regex = /^test$/
			response = described_class.new(test_pattern_string)
			expect(response.pattern).to eq(expected_regex)

		end

	end

	context '#get_input' do
		it 'calls for input until it matches the pattern' do
			silence_output
			input = "test"
			pattern = "^test$"
			response = described_class.new(pattern)			
			expect(response.input).to receive(:gets).twice.and_return("tset", "test")
			response.get_input
		end

		it 'pads the prompt with spaces to the center value' do
			response = described_class.new('')					
			response.padder.output.output = StringIO.new	
			allow(response.input).to receive(:gets).and_return('')
			response.get_input
			expected_padding = response.padder.output_formatter.center_inline('', ' ')
			expect(response.padder.output.output.string).to eq(expected_padding)
		end		
	end

	context "#valid_response" do
		it "returns the first match of the response and return" do
			input = "test"
			pattern = "^test$"
			response = described_class.new(pattern)			
			match = response.valid_response(input)
			expect(match).to eq(input)
		end	
	end			

end