require_relative 'file_handling'

class GameConfig
	include FileHandling

	def initialize(config_file = 'config.yml', file_folder = '../config')
		@data = load_yaml(config_file, file_folder)
        width = attempt_to_get_width
        if width
            @data["canvas"]["width"] = width         
        end
	end

    def data
        @data
    end

    private


    def attempt_to_get_width
        begin
            require 'io/console'
             IO.console.winsize[1]
        rescue
            nil
        end     
    end
end