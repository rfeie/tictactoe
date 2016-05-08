require_relative 'spec_helper'

describe UserInterface do

	let (:input) { StringIO.new }
	let (:output) { StringIO.new }
	let (:ui) { described_class.new(input: input, output: output) }
	let (:test_string) { "test string" }
	let (:message) {double(:message, :send_output => '', :send_output_inline => '')}
	let (:response) {double(:response, :get_input => '')}

	context '#new' do

		it 'creates an Input from supplied input' do
			expect(ui.input.input).to eq(input)
		end

		it 'creates an output from supplied output' do
			expect(ui.output.output).to eq(output)
		end

		it 'has a default alignment of :center' do
			expect(ui.default_alignment).to eq(:center)
		end

		it 'creates a output formatter' do
			expect(ui.output_formatter.class).to eq(OutputFormatter)			
		end
	end

	context 'display' do

		it 'creates a Message' do
			expect(Message).to receive(:new).and_return(message)
			ui.display(test_string)
		end

		it 'creates a message with the output formatter, output and default_alignment if none is provided' do
			expect(Message).to receive(:new)
				.with(test_string, ui.default_alignment, ' ', ui.output, ui.output_formatter)
				.and_return(message)
			ui.display(test_string)			
		end

		it 'uses specific alignment if one is provided'	do
			expect(Message).to receive(:new)
				.with(test_string, :left, ' ', ui.output, ui.output_formatter)
				.and_return(message)
			ui.display(test_string, :left)			

		end

		it 'outputs to the output' do
			ui.display(test_string)			
			expect(ui.output.output.string).to match(Regexp.new(test_string))
		end
	end

	context 'get_input' do

		it 'creates a Response' do
			allow(ui.input).to receive(:gets).and_return('')
			expect(Response).to receive(:new).and_return(response)
			ui.get_input
		end

		it 'creates a response with a message' do
			allow(ui.input).to receive(:gets).and_return('')
			expect(Message).to receive(:new).twice.and_return(message)
			ui.get_input
		end	
		it 'calls for input a message with the input' do
			expect(ui.input).to receive(:gets).and_return('')
			ui.get_input
		end
	end
end