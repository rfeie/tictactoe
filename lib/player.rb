class Player
	attr_accessor :mark, :ui, :name
	
	def initialize(name, mark, ui = UserInterface.new)
		@ui = ui
		@name = name
		@mark = mark
	end
  
end