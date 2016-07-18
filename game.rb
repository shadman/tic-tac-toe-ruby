class Game
	attr_accessor :players_option, :game_option, :user_turn, :total_actions, :new_player

	
	def initialize
		@players_option
		@game_option
		@user_turn = 'X'
		@total_actions = 0
		@new_player
	end

	# Getting player options; 2 players or with computer
	def player_options
		option = 0
		while option.to_i != 1 && option.to_i != 2
			puts "\n\nPlayer Options: \n 1. 2 Players \n 2. With Computer \n Please select any one option by pressing 1 or 2: "
			option = gets.chomp
		end
		@players_option = option.to_i
	end


	# Getting user desidred game board 3x3/4x4/5x5
	def game_options
		option = 0
		while option.to_i != 1 && option.to_i != 2 && option.to_i != 3
			puts "\n\nGame Options: \n 1. 3x3 Boxes \n 2. 4x4 Boxes \n 3. 5x5 Boxes \n Please select any one option from 1 to 3: "
			option = gets.chomp
		end
		@game_option = convert_option option.to_i
	end


	# Converting user selected value into game required
	def convert_option option
		selected = case option
			when 1 then 3
			when 2 then 4
			when 3 then 5
			else 3
		end
		selected
	end


	# Winning patterns
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


	# Robot patterns, for auto players of every game board
	def default_robot_patterns

		type = @game_option

		turn = case type
			when 3	# 3 x 3 robot patterns
				return [5,1,9,3,4,6,2,8,7]
			when 4	# 4 x 4 robot patterns
				return [1,6,11,16,4,3,2,5,9,13,14,15,8,12,10,7]
			when 5	# 5 x 5 robot patterns
				return [1,7,13,19,25,5,4,3,2,21,16,11,6,15,20,10,23,22,24,17,18,12,14,8,9]
			end
	end


	# Verifying player; is won 
	def is_winner(player)
		winning_patterns.each do |pattern|
			intersected = pattern & player.actions
			if intersected.length == @game_option 
				return true
			end
		end
		return false
	end


	# Verifying is finished or someone won already
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


	# Initializing and starting main game
	def start(playerX, playerY)

		# Setting last player		
		player = @new_player
		player = playerX if player.nil?

		# Setting new player
		@new_player = play_and_switch(playerX, playerY) # Setting new player

		
		if is_finished(player) === false 
			# Draw normal board with turns counts
			draw_board(playerX, playerY)
			
			if @new_player.user_type == 'Y' && @players_option == 2
				robot(playerX, playerY)
			else 
				play(playerX, playerY)
			end

			start(playerX, playerY)
		else
			# Draw final board (won/draw)
			draw_board(playerX, playerY, 1)

			# Increase winner score & print current board
			player.score_increase 
			puts "\nCurrent Score of player #{playerX.name} is #{playerX.score}\nCurrent Score of player #{playerY.name} is #{playerY.score}" 
			
			# Ask to re-play
			puts "\nWant to play it again? press any key to continue or 'N' to close:"
			replay = gets.chomp.downcase
			if replay == 'N' || replay == 'n'
				puts "Ba bye !"
			else 
				reset(playerX, playerY)
			end

		end
	end


	# Auto player 
	def robot(playerX, playerY)
		position = robot_position(playerX, playerY)
		@new_player.actions.push(position.to_i) 
		@new_player.actions = @new_player.actions.sort
		@total_actions += 1
	end


	def robot_position(playerX, playerY)

		# from winning patterns; if near to win
		winning_patterns.each do |pattern|
			intersected = pattern & playerY.actions
			remaining_positions = pattern - playerY.actions
			if (intersected.length == @game_option - 1) && remaining_positions.length > 0 && !playerY.actions.include?(remaining_positions[0])
				return remaining_positions[0]
			end
		end

		# from winning patterns; if other player is going to win and nothing got from above 
		winning_patterns.each do |pattern|
			intersected = pattern & playerX.actions
			remaining_positions = pattern - playerX.actions
			if (intersected.length == @game_option - 1) && remaining_positions.length > 0 && !playerX.actions.include?(remaining_positions[0])
				return remaining_positions[0]
			end
		end

		# from defined pattern and nothing got from above 
		default_robot_patterns.each do |position|
			return position if is_valid_input(position, playerX, playerY) === true
		end

	end


	# Switching turn
	def play_and_switch(playerX, playerY)
		if @user_turn == 'Y'
			@user_turn = 'X'
			playerY
		else
			@user_turn = 'Y'
			playerX
		end
	end


	# Getting action from players
	def play(playerX, playerY)
		option = 0
		game_option = @game_option * @game_option
		while !(1..game_option).include?(option.to_i)
			puts "\n\n" + @new_player.name + ": Please select your desired position from 1 to #{game_option}:"
			input = gets.chomp.to_i
			option = 0

			# If someone already placed
			option = input if is_valid_input(input, playerX, playerY) === true
		end

		# Updating desired position
		@new_player.actions.push(option.to_i) 
		@new_player.actions = @new_player.actions.sort
		@total_actions += 1
		option
	end


	# Is input already occupied
	def is_valid_input(input, playerX, playerY)
		if !playerX.actions.include?(input) && !playerY.actions.include?(input) 
			return true
		else 
			puts "Sorry, already selected"
			return false
		end
	end


	# Drawing lines with header on every board drawing
	def draw_header(is_finished)
		line = ''
		max_col = 20 * @game_option
		(0..max_col).each do |a|
			line += '='
		end

		puts "\n" + line
		if @total_actions == 0
			puts "\n" + line
			puts "\t\tTic Tac Toe Game Started"
		elsif is_finished == 1
			puts "\t\tTic Tac Toe Game Finished"
		else 
			puts "\t\tTic Tac Toe Game (#{@total_actions+1} Turn)"
		end
		puts line + "\n\n"
	end 


	# Drawing board as per selected game option
	def draw_board(playerX, playerY, is_finished=0)
		draw_header(is_finished)

		count = 1
		string = ''
		# Rows
		(1..@game_option).each do |i|
			
			string = "\t\t\t\n"

			# Columns
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


	# Reseting game params for next round
	def reset(playerX, playerY)
		playerX.actions = []
		playerY.actions = []

		@user_turn='X'
		@total_actions=0
		@new_player=playerX

		start(playerX, playerY)
	end

end