
class TicTacToe

	def options
		option = 0
		while option.to_i != 1 && option.to_i != 2
			puts "\n\nPlayer Options: \n 1. 2 Players \n 2. With Computer \n Please select any one option ( 1 or 2 ): "
			option = gets.chomp
		end
		option
	end

end


class Player
	attr_accessor :name, :score
	
	def initialize(name)
		@name = name
		@score = 0
	end

	def score_increase
		@score = @score+1
	end

end


class Play

	attr_accessor :game_type

	def initialize()
		@game_type
	end

	def start

		option = TicTacToe.new.options
		@game_type = option.to_i

		puts "\n1st Player Name: "
		playerX = Player.new(gets.chomp)

		if @game_type == 1
			puts "\n2nd Player Name: "
			playerY = Player.new(gets.chomp)
		else 
			playerY = Player.new('Computer')
		end

	end

end

game_initialize = Play.new
game_initialize.start

