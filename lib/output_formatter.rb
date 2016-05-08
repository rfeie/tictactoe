class OutputFormatter
	attr_accessor :width, :margin
	
	def initialize
		config = GameConfig.new
		@width = config.data["canvas"]["width"].nil? ? config.data["canvas"]["fallback_width"] : config.data["canvas"]["width"]
		@margin = config.data["canvas"]["margin"]
	end

	def center_inline(input, padding = ' ')
		left_align_amount = (@width / 2) + (input.length / 2)
		input.rjust(left_align_amount, padding)
	end

	def center(input, padding = ' ')
		if input.index("\n")
			handle_newline(input, padding, method(:center_line))
		else
			center_line(input, padding)		
		end
	end

	def left_align(input, padding = ' ')
		if input.index("\n")
			handle_newline(input, padding, method(:left_align_line))
		else
			left_align_line(input, padding)		
		end
	end

	def right_align(input, padding = ' ')
		if input.index("\n")
			handle_newline(input, padding, method(:right_align_line))
		else
			right_align_line(input, padding)		
		end
	end

	private

	def center_line(input, padding = ' ')
		input.center(@width, padding)
	end

	def left_align_line(input, padding = ' ')
		margin_plus_length = @margin + input.length
		input.rjust(margin_plus_length, padding)
	end 



	def right_align_line(input, padding = ' ')
		input.rjust(@width, padding)
	end

	def handle_newline(input, padding = ' ', run_operation)
		rows = input.split("\n")
		aligned_array =[]
		rows.each do |row|
			aligned_array << run_operation.call(row, padding)
		end
		aligned_array.join("\n")
	end

end