require_relative 'spec_helper'

describe TicTacToe do

	let (:tictactoe) do
		ui = generate_ui
		described_class.new(ui: ui)
	end
	let (:game_choices) {
		{
			person_computer_game: "1",
			person_person_game: "2",
			computer_computer_game: "3"
		}
	}
	before :each do
	  	@output = tictactoe.ui.output
	  	allow(tictactoe.ui).to receive(:get_input)
	  	allow(PersonVersusPersonGame).to receive(:new)
	end

	context "welcome messages" do
		it "delivers a welcome message" do
	        set_game_choice_and_start game_choices[:person_person_game]
			expect(@output.output.string).to match(/Welcome to Tic Tac Toe!/)
		end
		it "prompts for game choice" do
	        set_game_choice_and_start game_choices[:person_person_game]
			expect(@output.output.string).to match(/What type of game do you want to play\?/)
		end
	end

	context "game choice" do
		it "recognizes input for a Person versus Computer Game and starts a game" do
			expect(PersonVersusComputerGame).to receive(:new)
	        set_game_choice_and_start game_choices[:person_computer_game]
			expect(@output.output.string).to match(/Starting Person versus Computer Game!/)
		end

		it "recognizes input for a Person versus Person Game and starts a game" do
			expect(PersonVersusPersonGame).to receive(:new)
	        set_game_choice_and_start game_choices[:person_person_game]
			expect(@output.output.string).to match(/Starting Person versus Person Game!/)
		end

		it "recognizes input for a Computer versus Computer Game and starts a game" do
			expect(ComputerVersusComputerGame).to receive(:new)
	        set_game_choice_and_start game_choices[:computer_computer_game]
			expect(@output.output.string).to match(/Starting Computer versus Computer Game!/)
		end
	end

	context "#run" do
		it "starts a new game run does not find a match choice" do
			expect(tictactoe).to receive(:start)
			tictactoe.run("not valid")
		end
	end

	context "#finish" do
		before :each do
			game = double(:game)
			tictactoe.game = game
		end

		it "asks you if you want to play again" do
			allow(tictactoe.ui).to receive(:get_input)
			tictactoe.finish
			expect(@output.output.string).to match(/Do you want to play again\?/)
		end

		it "prompts for user choice" do
			expect(tictactoe.ui).to receive(:get_input)
			tictactoe.finish
		end
		it "starts a new game choice if user replies 'y'" do
			allow(tictactoe.ui).to receive(:get_input).and_return("y")
			allow(tictactoe).to receive(:get_game_choice).and_return(game_choices[:person_person_game])
			expect(tictactoe).to receive(:run).with(game_choices[:person_person_game])
			tictactoe.finish
		end

		it "ends the session if user replies 'n'" do
			allow(tictactoe.ui).to receive(:get_input).and_return("n")
			tictactoe.finish
			expect(@output.output.string).to match(/Thanks! It was great playing!/)
		end

	end	

	def set_game_choice_and_start game_choice
	    allow(tictactoe.ui).to receive(:get_input).and_return(game_choice)
		tictactoe.start	
	end
end

