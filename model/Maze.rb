class Maze
	@start_point
	@goal_point

	def initialize
		maze = create_maze
	end

	def create_maze
		maze_settings = read_settings

	end

	private
		def read_settings
			maze_settings_file = './mazes/mazes.yml'
			maze_settings = YAML.load_file maze_settings_file
			
			maze_settings[:start] = "S" if maze_settings[:start].blank?
			maze_settings[:goal] = "G" if maze_settings[:goal].blank?
			maze_settings[:obstacle] = "O" if maze_settings[:obstacle].blank?
			maze_settings[:free_block] = "F" if maze_settings[:free_block].blank?
			maze_settings[:maze_file] = "example" if maze_settings[:maze_file].blank?

			raise "Please check maze settings file #{maze_settings_file}" if maze_settings.values.	count != maze_settings.values.uniq.count
	
			return maze_settings
		end
end