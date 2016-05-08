class UserInterface

	attr_accessor :input, :output, :default_alignment, :output_formatter

	def initialize(input: $stdin, output: $stdout, alignment: :center, message: Message, response: Response, output_formatter: OutputFormatter.new)
		@input = Input.new(input)
		@output = Output.new(output)
		@default_alignment = alignment
		@output_formatter = output_formatter
		@message = message
		@response = response
	end

	def display(text, alignment = @default_alignment)
		message = @message.new(text, alignment, ' ', @output, @output_formatter )
		message.send_output
	end

	def display_with_padding(text, padding = ' ', alignment = @default_alignment)
		message = @message.new(text, alignment, padding, @output, @output_formatter )
		message.send_output
	end

    def display_inline(text, beginning = true, alignment = @default_alignment)
		message = @message.new(text, alignment, ' ', @output, @output_formatter )
		message.send_output_inline(beginning)
	end

    def get_input(pattern = "^.*$", reminder_prompt = "")
    	reminder_message = @message.new(reminder_prompt, @default_alignment, ' ', @output, @output_formatter)
    	padder = @message.new('', @default_alignment, ' ', @output, @output_formatter)
    	response = @response.new(pattern, reminder_message, @input, padder)
    	response.get_input
	end
end