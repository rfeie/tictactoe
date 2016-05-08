class Message

	attr_accessor :content, :output, :output_formatter, :alignment, :padding

	def initialize(content = "", alignment = :center, padding = ' ', output = Output.new, output_formatter = OutputFormatter.new)
		@content = content
		@output = output
		@output_formatter = output_formatter
        @alignment = alignment
        @padding = padding
	end

    def send_output
        @output.puts align_string(@content)

    end

    def send_output_inline(beginning = true)
        if beginning
            @output.print align_string(@content, true)
        else
            @output.print @content            
        end
    end

    private

    def align_string(string, inline = false)
        case @alignment
        when :center
            if inline
                @output_formatter.center_inline(string, @padding)
            else
                @output_formatter.center(string, @padding)
            end
        when :right
            @output_formatter.right_align(string, @padding)
        when :left 
            @output_formatter.left_align(string, @padding)
        else
            @output_formatter.left_align(string, @padding)
        end
        
    end

end