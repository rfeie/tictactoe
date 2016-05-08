class PersonVersusPersonGame < Game

	def create_players
		@ui.display("Customize first player:")
		@player_1 = first_player_generator.create_person_player
		@player_1.board = @board
		@ui.display("Customize second player:")
		@player_2 = second_player_generator.create_person_player(@player_1)
		@player_2.board = @board
	end

end