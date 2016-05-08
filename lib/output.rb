class Output
	attr_accessor :output

	def initialize(output = $stdout)
		@output = output
	end

	def puts(output)
		@output.puts(output)
	end

	def print(output)
		@output.print(output)
	end

end