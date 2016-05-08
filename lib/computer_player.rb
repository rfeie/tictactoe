class ComputerPlayer < Player

	attr_accessor :board

	def initialize(name, mark, ui = UserInterface.new, rater_class = MoveRater)
		@rater_class = rater_class
		super(name, mark, ui)
	end

	def get_move
		set_rater
		stop_and_think
		best_node = @rater.get_best_node_from_open_spaces
		move = best_node.pos
	end

	private

	def set_rater
		@rater ||= @rater_class.new(@mark, @board)
	end

	def stop_and_think(time = rand(1..4))
		wait_time = time
		@ui.display_inline("Thinking.", true)
		wait_time.times do |num|
			sleep(1)
			@ui.display_inline(".", false)
		end
		@ui.display('')
	end

end