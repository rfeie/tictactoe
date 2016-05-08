require_relative 'required_files'

class TicTacToe

  attr_accessor :ui, :game

	def initialize(ui: UserInterface.new)
		@ui = ui
  	end

	def start
		@ui.display "Welcome to Tic Tac Toe!"
		game_choice = get_game_choice
		run(game_choice)
	end


	def run game_choice
		case game_choice
		when "1"
			@ui.display "Starting Person versus Computer Game!"
			@game = PersonVersusComputerGame.new(ui: @ui)
		when "2"
			@ui.display "Starting Person versus Person Game!"	
			@game = PersonVersusPersonGame.new(ui: @ui)
		when "3"
			@ui.display "Starting Computer versus Computer Game!"
			@game =  ComputerVersusComputerGame.new(ui: @ui)
		else
			start
		end 
		finish
	end

	def finish
		@ui.display "Do you want to play again? (y or n)"
		response = @ui.get_input("^(y|n)$", "Please choose again. (valid choices are y or n)")
		if response == "y"
			@ui.display("Starting another game!")
			game_choice = get_game_choice
			run(game_choice)
		else
			@ui.display "Thanks! It was great playing!"
		end
	end

	def get_game_choice
		@ui.display "What type of game do you want to play? Valid choices are:"
		choices =  "1. Person versus Computer\n2. Person versus Person\n3. Computer versus Computer"
		@ui.display choices
		@ui.display "Please choose 1, 2, or 3"
		game_choice = @ui.get_input("^(1|2|3)$", 
			"That is not a valid game choice, please choose again. Valid choices are:\n#{choices}")
	end

end

