class PlayerGenerator

	attr_accessor :ui

	def initialize(ui = UserInterface.new)
		@ui = ui
		@config = GameConfig.new
	end

	def create_person_player
		mark = get_player_mark
		name = get_person_player_name
		person_player_class.new(name, mark, @ui)
	end

	def create_computer_player
		mark = get_player_mark
		name = get_computer_player_name
		computer_player_class.new(name, mark, @ui)
	end

	def ui
		@ui
	end

	private

	def get_person_player_name
		raise NotImplementedError
	end	

	def get_computer_player_name
		raise NotImplementedError
	end	

	def get_player_mark
		raise NotImplementedError
	end

	def get_player_settings_from_config(player_type)
		config.data["player"][player_type]
	end

	def player_type
		''
	end

	def person_player_class
		PersonPlayer
	end

	def computer_player_class
		ComputerPlayer
	end

	def config
		@config
	end

end