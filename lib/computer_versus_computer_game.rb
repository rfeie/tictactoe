class ComputerVersusComputerGame < Game

	def create_players
		@ui.display("Customize player 1:")
		@player_1 = first_player_generator.create_computer_player
		@player_1.board = @board
		@ui.display("Customize player 2:")
		@player_2 = second_player_generator.create_computer_player(@player_1)
		@player_2.board = @board
	end

end