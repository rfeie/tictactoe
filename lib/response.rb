class Response

	attr_accessor :reminder_message, :pattern, :input, :padder

	def initialize(pattern = "^.*$", reminder_message = Message.new, input = Input.new, padder = Message.new)
		@input = input
		@reminder_message = reminder_message
		@pattern = Regexp.new(pattern)
        @padder = padder
	end

    def get_input
        pad_prompt
        untested_input = @input.gets.strip
        message = valid_response(untested_input)
        until message
            @reminder_message.send_output
            pad_prompt
            untested_input = @input.gets.strip
            message = valid_response(untested_input)
        end
        message
    end

    def valid_response(input)
        match = @pattern.match(input)
        if match
            match[0]
        else
            nil
        end
    end
    
    def pad_prompt
        @padder.send_output_inline('')      
    end
end