class Game

	attr_accessor :ui, :game_state, :player_1, :player_2, :current_turns_player, :board

	def initialize(ui: UserInterface.new)
		config = GameConfig.new
		@ui = ui
		width = config.data["board"]["width"]
		height = config.data["board"]["height"]
		@board = Board.new(width: width, height: height)
		@game_state = :in_progress
		@max_streak = height < width ? height : width
		@turn = 1
		start
	end

	def start
		create_players
		choose_player_to_go_first
		run		
	end

	def run
		while @game_state == :in_progress 
			display_text = "\n Turn #{@turn.to_s} \n\n #{@current_turns_player.name}'s Turn! "
			display_board_lockup(display_text, '-')
			take_turn
			update_game_state
			change_turn
		end
		end_game
	end

	def end_game
		case @game_state
		when :player_1_wins
			display_board_lockup("\n Game is over! #{@player_1.name} wins! \n\n Final board position: ", "*")
		when :player_2_wins
			display_board_lockup("\n Game is over! #{@player_2.name} wins! \n\n Final board position: ", "*")
		when :draw
			display_board_lockup("\n Game is over! This game was a draw! \n\n Final board position: ", "=")
		else
			@ui.display("Game is over!")
		end
		@ui.display("Thank you for playing!\nGoodbye!")		
	end


	def update_game_state
		players = [@player_1, @player_2]
		players.each do |player|
			mark = player.mark
			nodes = @board.get_all_with_content(mark)
			streak = @board.get_longest_streak(nodes)
			if streak.length >= @max_streak
				@game_state = player == @player_1 ? :player_1_wins : :player_2_wins
			end
		end

		if game_is_draw?
			@game_state = :draw
		end
	end

	def change_turn
		@current_turns_player = @current_turns_player == @player_1 ? @player_2 : @player_1
	end

	def take_turn
		@ui.display("#{@current_turns_player.name}, what is your move?")
		move = @current_turns_player.get_move
		until legal_move?(move)
			move = @current_turns_player.get_move
		end
		make_move(move)
		@ui.display("#{current_turns_player.name} chose #{move + 1}")
		@turn += 1
	end

	def make_move(move)
		mark = @current_turns_player.mark
		@board.set_nodes_content(move, mark)
	end

	def legal_move?(move)
		node = @board.nodes[move]
		if node && node.content.nil?
			return true
		end
		false
	end

	def choose_player_to_go_first
		@ui.display("Please choose which player should go first. #{@player_1.name} or #{@player_2.name}")
		choice = @ui.get_input("^(#{@player_1.name}|#{@player_2.name})$", "Please choose #{@player_1.name} or #{@player_2.name}")		
		if choice == @player_1.name
			@current_turns_player = @player_1	
		else
			@current_turns_player = @player_2	
		end
	end

	def create_players
		@player_1 = Player.new("Player 1", "X", @ui)
		@player_2 = Player.new("Player 2", "O", @ui)
	end

	def display_board_lockup(header_message, padding = nil)
		if padding
			@ui.display_with_padding(header_message, padding)		
		else
			@ui.display(header_message)
		end
		@ui.display(@board.generate_board, :center)
		@ui.display("#{@player_1.name}'s Mark: #{@player_1.mark}, #{@player_2.name}'s Mark: #{@player_2.mark}")
	end

	def game_is_draw?
		remaining_open_nodes = @board.get_all_with_content(nil)
		return remaining_open_nodes.length == 0
	end

	def first_player_generator
		FirstPlayerGenerator.new(@ui)
	end

	def second_player_generator
		AdditionalPlayerGenerator.new(@ui)
	end	

end