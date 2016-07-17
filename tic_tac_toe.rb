
class TicTacToe
	attr_accessor :players_option, :game_option, :user_turn, :total_actions, :new_player

	
	def initialize
		@players_option
		@game_option
		@user_turn = 'X'
		@total_actions = 0
		@new_player
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

	def winning_patterns
			
			type = @game_option

			wins = case type
					when 3	# 3 x 3 winning patterns
						return [ 
								[1,2,3], [4,5,6], [7,8,9],
						 		[1,4,7], [2,5,8], [3,6,9], 
						 		[1,5,9], [3,5,7]
					 			] 
					when 4	# 4 x 4 winning patterns
						return [ 
								[1,2,3,4], [5,6,7,8], [9,10,11,12], [13,14,15,16],
						 		[1,5,9,13], [2,6,10,14], [3,7,11,15], [4,8,12,16],
						 		[4,7,10,13], [1,6,11,16]
								]
					when 5	# 5 x 5 winning patterns
						return [ 
								[1,2,3,4,5], [6,7,8,9,10], [11,12,13,14,15], [16,17,18,19,20], [21,22,23,24,25],
						 		[1,6,11,16,21], [2,7,12,17,22], [3,8,13,18,23], [4,9,14,19,24], [5,10,15,20,25],
						 		[1,7,13,19,25], [5,9,13,17,21]
						 		]
					end
	end

	def is_winner(player)
		winning_patterns.each do |pattern|
			intersected = pattern & player.actions
			if intersected.length == @game_option 
				return true
			end
		end
		return false
	end

	def start(playerX, playerY)
		
		player = @new_player
		player = playerX if player.nil?

			# Setting last player
		@new_player = play_and_switch(playerX, playerY) # Setting new player

		if is_finished(player) === false 
			draw_board(playerX, playerY)
			play(playerX, playerY)
			start(playerX, playerY)
		else
			# if won/draw
			# increase winner score and print current scores
			player.score_increase 
			puts "\nCurrent Score of player #{playerX.name} is #{playerX.score}\nCurrent Score of player #{playerY.name} is #{playerY.score}" 
			
			# Ask to re-play
			puts "\nWant to play it again? press Y to continue:"
			replay = gets.chomp.downcase
			if replay == 'y' || replay == 'yes'
				reset(playerX, playerY)
			else 
				puts "Ba bye !"
			end

		end
	end

	def is_valid_input(input, playerX, playerY)
		if !playerX.actions.include?(input) && !playerY.actions.include?(input) 
			return true
		else 
			puts "Sorry, already selected"
			return false
		end
	end

	def reset(playerX, playerY)
		playerX.actions = []
		playerY.actions = []
		@user_turn='X'
		@total_actions=0
		@new_player=playerX
		start(playerX, playerY)
	end

	def play_and_switch(playerX, playerY)
		if @user_turn == 'Y'
			@user_turn = 'X'
			playerY
		else
			@user_turn = 'Y'
			playerX
		end
	end

	def is_finished(player)
		game_option = @game_option * @game_option
		
		# Verifying is anyone won
		if is_winner(player) == true
			puts "Yay!! #{player.name} Won !"
			return true
		end

		# Verifying is draw
		if @total_actions == game_option
			puts 'Game Draw !!'
			return true
		end
		return false
	end

	def draw_header
		line = ''
		max_col = 20 * @game_option
		(0..max_col).each do |a|
			line += '='
		end

		puts "\n" + line
		if @total_actions == 0
			puts "\t\tTic Tac Toe Game Started   "
		else 
			puts "\t\tTic Tac Toe Game (#{@total_actions+1} Turn)   "
		end
		puts line + "\n\n"
	end 

	def draw_board(playerX, playerY)
		draw_header

		count = 1
		string = ''
		(1..@game_option).each do |i|
			
			string = "\t\t\t\n"
			(1..@game_option).each do |y|
				position = count
				position = playerX.user_type if playerX.actions.include?(count)
				position = playerY.user_type if playerY.actions.include?(count)
				string += "\t|\t" + position.to_s
				count += 1
			end
			puts string + "\t|\n\n"
		end
	end 

	def play(playerX, playerY)
		option = 0
		game_option = @game_option * @game_option
		while !(1..game_option).include?(option.to_i)
			puts "\n\n" + @new_player.name + ": Please select your desired position from 1 to #{game_option}:"
			input = gets.chomp.to_i
			option = 0
			option = input if is_valid_input(input, playerX, playerY) === true
		end
		@new_player.actions.push(option.to_i) 
		@new_player.actions = @new_player.actions.sort
		@total_actions += 1
		option
	end

end


class Player
	attr_accessor :name, :score, :user_type, :actions
	
	def initialize(name, user_type)
		@name = name
		@score = 0
		@user_type = user_type
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
		playerX = Player.new(gets.chomp.capitalize, 'X')

		# Player 2 initialization
		if game_players == 1
			puts "\n2nd Player Name: "
			playerY = Player.new(gets.chomp.capitalize, 'Y')
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

