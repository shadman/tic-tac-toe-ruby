
class TicTacToe
	attr_accessor :players_option, :game_option

	
	def initialize
		@players_option
		@game_option
	end

	def player_options
		option = 0
		while option.to_i != 1 && option.to_i != 2
			puts "\n\nPlayer Options: \n 1. 2 Players \n 2. With Computer \n Please select any one option by pressing (1 / 2) : "
			option = gets.chomp
		end
		@players_option = option.to_i
	end

	def game_options
		option = 0
		while option.to_i != 1 && option.to_i != 2 && option.to_i != 3
			puts "\n\nGame Options: \n 1. 3x3 Boxes \n 2. 4x4 Boxes \n 3. 5x5 Boxes \n Please select any one option ( 1 | 2 | 3 ): "
			option = gets.chomp
		end
		@game_option = convert_option option.to_i
	end

	def convert_option option
		selected = case option
			when 1 then 3
			when 2 then 4
			when 3 then 5
			else 3
		end
		selected
	end

	def draw_header
		line = ''
		max_col = 20*@game_option
		(0..max_col).each do |a|
			line += '='
		end

		puts "\n" + line
		puts "\t\tTic Tac Toe Game Started   "
		puts line + "\n\n"
	end 

	def draw_board
		self.draw_header

		count = 1
		string = ''
		(1..@game_option).each do |i|
			
			string = "\t\t\t\n"
			(1..@game_option).each do |y|
				string += "\t|\t" + count.to_s
				count += 1
			end
			puts string + "\t|\n\n"
		end

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

	def start

		selections = TicTacToe.new
		game_players = selections.player_options
		selections.game_options

		puts "\n1st Player Name: "
		playerX = Player.new(gets.chomp)

		if game_players == 1
			puts "\n2nd Player Name: "
			playerY = Player.new(gets.chomp)
		else 
			puts "\nComputer Initialized. "
			playerY = Player.new('Computer')
		end

		selections.draw_board
	end

end

game_initialize = Play.new
game_initialize.start

