class Robot
	attr_accessor :known_maze
	attr_reader :position

	def initialize
		@position = Point.new 0,0 #set up an invalide position
	end

	def set_position(point)
		@position = point
	end

end