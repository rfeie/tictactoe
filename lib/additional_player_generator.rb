class AdditionalPlayerGenerator < PlayerGenerator

	def create_person_player(existing_player)
		mark = get_player_mark(existing_player.mark)
		name = get_person_player_name(existing_player.name)
		person_player_class.new(name, mark, @ui)
	end

	def create_computer_player(existing_player)
		mark = get_player_mark(existing_player.mark)
		name = get_computer_player_name(existing_player.name)
		computer_player_class.new(name, mark, @ui)
	end

	private

	def get_person_player_name(existing_name)
		player_settings = get_player_settings_from_config("person_player")
		max_length = player_settings["maximum_length"]
		prompt = "Please choose the name for this player. \nIt must be 2-#{max_length} characters and not match and not match existing name '#{existing_name}'"
		reminder = "Please choose again.\nDo not include any irregular spaces and not match existing name '#{existing_name}'"
		regex = "^(?!#{existing_name}$)([a-zA-Z0-9][a-zA-Z0-9, ]{0,#{max_length -2}}[a-zA-Z0-9])$"
		ui.display(prompt)
		ui.get_input(regex, reminder)
	end	

	def get_computer_player_name(existing_name)
		player_settings = get_player_settings_from_config("computer_player")
		default_names = player_settings["default_names"]
		default_names.delete(existing_name)
		default_names.sample
	end	

	def get_player_mark(existing_mark)
		prompt = "Please choose the mark for this player. \nIt should be only one non-digit character and not match and not match existing mark '#{existing_mark}'"
		reminder = "Please choose again. \nIt should be only one non-digit character and not match and not match existing mark '#{existing_mark}'"
		regex = "^[^\\s,#{existing_mark}, \\d]$"
		ui.display(prompt)
		ui.get_input(regex, reminder)
	end

end