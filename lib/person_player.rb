class PersonPlayer < Player 
	attr_accessor :board
	
	def get_move
		length = @board.height * @board.width
		regex = generate_regex_for_move(length)
		prompt = "Move must be 1-#{length.to_s} and in a space that is not taken"
		@ui.display(prompt)
		move = @ui.get_input("^(#{regex})$", "Please choose again. #{prompt}")
		adjusted_move = move.to_i - 1
	end
	
	private

	def generate_regex_for_move(length)
		each_option = []
		length.times do |num|
			each_option << num + 1
		end
		each_option.reverse!
		each_option.join("|")
	end
end