class FirstPlayerGenerator < PlayerGenerator

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

	private

	def get_person_player_name
		player_settings = get_player_settings_from_config("person_player")
		max_length = player_settings["maximum_length"]
		prompt = "Please choose the name for this player. \nIt must be 2-#{max_length} characters"
		reminder = "Please choose again.\nDo not include any irregular spaces"
		regex = "^([a-zA-Z0-9][a-zA-Z0-9, ]{,#{max_length -2}}[a-zA-Z0-9])$"
		ui.display(prompt)
		ui.get_input(regex, reminder)

	end	

	def get_computer_player_name
		player_settings = get_player_settings_from_config("computer_player")
		player_settings["default_names"].sample
	end	

	def get_player_mark
		prompt = "Please choose the mark for this player. \nIt should be only one non-digit character"
		reminder = "Please choose again. \nIt should be only one non-digit character"
		regex = "^[^\\s, \\d]$"
		ui.display(prompt)
		ui.get_input(regex, reminder)
	end

end