def generate_ui
	read = StringIO.new
	write = StringIO.new
	ui = UserInterface.new(input: read, output: write)
	ui.output_formatter.width = 50
	ui.output_formatter.margin = 10
	ui
end

def silence_output
	allow_any_instance_of(Output).to receive(:print)	
	allow_any_instance_of(Output).to receive(:puts)	
end

def block_game_running
	allow_any_instance_of(described_class).to receive(:run)
	allow_any_instance_of(described_class).to receive(:choose_player_to_go_first)	
end

def get_config_values
	file_path = File.join(File.dirname(__FILE__), "../config") + "/config.yml"
	yaml = YAML.load_file(file_path)
end