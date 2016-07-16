
class TicTacToe
	attr_accessor :players_option, :game_option, :user_turn, :total_actions

	
	def initialize
		@players_option
		@game_option
		@user_turn = 'X'
		@total_actions = 0
	end

	def player_options
		option = 0
		while option.to_i != 1 && option.to_i != 2
			puts "\n\nPlayer Options: \n 1. 2 Players \n 2. With Computer \n Please select any one option by pressing 1 or 2: "
			option = gets.chomp
		end
		@players_option = option.to_i
	end

	def game_options
		option = 0
		while option.to_i != 1 && option.to_i != 2 && option.to_i != 3
			puts "\n\nGame Options: \n 1. 3x3 Boxes \n 2. 4x4 Boxes \n 3. 5x5 Boxes \n Please select any one option from 1 to 3: "
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


	def start(playerX, playerY)
		self.draw_board
		player = play_and_switch(playerX, playerY)
		if is_finished === false
			self.play(player)
			start(playerX, playerY)
		end
	end 

	def play_and_switch(playerX, playerY)
		if self.user_turn == 'Y'
			self.user_turn = 'X'
			playerY
		else
			self.user_turn = 'Y'
			playerX
		end
	end

	def is_finished
		game_option = self.game_option * self.game_option
		if self.total_actions == game_option
			puts 'Game Draw !!'
			return true
		end
		return false
	end

	def draw_header
		line = ''
		max_col = 20 * self.game_option
		(0..max_col).each do |a|
			line += '='
		end

		puts "\n" + line
		if @total_actions == 0
			puts "\t\tTic Tac Toe Game Started   "
		else 
			puts "\t\tTic Tac Toe Game (#{@total_actions} Turn)   "
		end
		puts line + "\n\n"
	end 

	def draw_board
		self.draw_header

		count = 1
		string = ''
		(1..self.game_option).each do |i|
			
			string = "\t\t\t\n"
			(1..self.game_option).each do |y|
				string += "\t|\t" + count.to_s
				count += 1
			end
			puts string + "\t|\n\n"
		end
	end 

	def play(player)
		puts "Your actions:" + (player.actions.to_s)
		option = 0
		game_option = self.game_option * self.game_option
		while !(1..game_option).include?(option.to_i)
			puts "\n\n" + player.name + ": Please select your desired position from 1 to #{game_option}:"
			option = gets.chomp
		end
		player.actions.push(option) 	
		self.total_actions += 1
		option
	end

end


class Player
	attr_accessor :name, :score, :user_type, :actions
	
	def initialize(name, user_type)
		@name = name
		@score = 0
		@user_type
		@actions = []
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

		# Player 1 initialization
		puts "\n1st Player Name: "
		playerX = Player.new(gets.chomp, 'X')

		# Player 2 initialization
		if game_players == 1
			puts "\n2nd Player Name: "
			playerY = Player.new(gets.chomp, 'Y')
		else 
			puts "\nComputer Initialized. "
			playerY = Player.new('Computer', 'Y')
		end

		# Drawing board as per option selection
		selections.start(playerX, playerY)
	end

end

game_initialize = Play.new
game_initialize.start

