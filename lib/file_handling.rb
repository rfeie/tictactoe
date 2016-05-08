module FileHandling
	def load_yaml(file_name, sub_folder = '')
		file_path = File.join(File.dirname(__FILE__), sub_folder) + "/#{file_name}"
		yaml = YAML.load_file(file_path)
	end
end