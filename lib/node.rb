class Node
	attr_accessor :pos, :content, :directions

	def initialize(pos, content = nil)
		@pos = pos				
		@content = nil
		@below = nil
		@directions = {
			above: nil,
			below: nil,
			left: nil,
			right: nil,
			upper_left: nil,
			upper_right: nil,
			lower_left: nil,
			lower_right: nil
		}
	end

end