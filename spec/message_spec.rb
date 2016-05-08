require_relative 'spec_helper'

describe Message do

	let(:test_string) { "test string" }
	let(:output){ Output.new(StringIO.new) }
	let(:message) { described_class.new(test_string) }

	before :each do
		message.output = output
		message.output_formatter.width = 50
		message.output_formatter.margin = 10
	end
	context '#new' do
		it 'connects to an output formatter' do
			expect(OutputFormatter).to receive(:new)
			described_class.new('')
		end

		it 'connects to an output' do
			expect(Output).to receive(:new)
			described_class.new('')
		end

		it 'takes content' do
			test_string = "Test String"
			message = described_class.new(test_string)
			expect(message.content).to eq(test_string)
		end
	end


	context '#send_output_inline' do
		it "left aligns the output" do
			message.alignment = :left
			expected_string = "          test string"
			message.send_output_inline(true)
			expect(message.output.output.string).to eq(expected_string)
		end

		it "does not left align the output if provided with false" do
			message.alignment = :left
			added_string = "."
			expected_string = "          test string."
			message.send_output_inline(true)
			message.content = added_string
			message.send_output_inline(false)
			expect(message.output.output.string).to eq(expected_string)
		end
	end

	context '#send_output' do
		it "displays the output" do
			message.send_output
			expect(message.output.output.string).to match(Regexp.new(test_string))
		end

		it "left aligns the output" do
			message.alignment = :left			
			expected_string = "          test string"
			message.send_output
			expect(message.output.output.string).to match(Regexp.new(expected_string))

		end

		it "center aligns the output" do
			message.alignment = :center
			expected_string = "                   test string                    "
			message.send_output
			expect(message.output.output.string).to match(Regexp.new(expected_string))

		end

		it "left aligns multi-line output" do
			test_lines= "test\nstring\nlines"
			message.content = test_lines
			message.alignment = :left
			expected_string = "          test\n          string\n          lines"
			message.send_output
			expect(message.output.output.string).to match(Regexp.new(expected_string))
		end
		
		it "right aligns multi-line output" do
			test_line_1 = "test"
			test_line_2 = "string"
			test_line_3 = "lines"

			test_lines= "#{test_line_1}\n#{test_line_1}\n#{test_line_1}"
			expected_string = "#{test_line_1.rjust(50)}\n#{test_line_1.rjust(50)}\n#{test_line_1.rjust(50)}\n"
			message.content = test_lines
			message.alignment = :right
			message.send_output
			expect(message.output.output.string).to eq(expected_string)
		end
	end

	context "#send_output_with_padding" do
		it "aligns the output with the padding character" do
			message.padding = '-'			
			expected_string = "-------------------test string--------------------"
			message.send_output
			expect(message.output.output.string.chomp).to eq(expected_string)

		end
	end
end
