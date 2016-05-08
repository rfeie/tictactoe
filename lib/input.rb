class Input 

	attr_accessor :input

	def initialize(input = $stdin)
		@input = input
	end

	def gets
		@input.gets
	end

end