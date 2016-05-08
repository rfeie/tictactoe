class PersonVersusComputerGame < Game

	def create_players
		@ui.display("Customize human player:")
		@player_1 = first_player_generator.create_person_player
		@player_1.board = @board		
		@ui.display("Customize computer player:")
		@player_2 = second_player_generator.create_computer_player(@player_1)
		@player_2.board = @board
	end

end