require 'game.rb'
require 'player.rb'

class Play

	# Start game
	def start

		selections = Game.new
		game_players = selections.player_options
		selections.game_options

		# Player 1 initialization
		puts "\n1st Player Name: "
		playerX = Player.new(gets.chomp.capitalize, 'X')

		# Player 2 initialization
		if game_players == 1
			puts "\n2nd Player Name: "
			playerY = Player.new(gets.chomp.capitalize, 'Y')

		# If computer(robot) selected
		else 
			puts "\nComputer Initialized. "
			playerY = Player.new('Computer', 'Y')
		end

		# Drawing board as per options selected
		selections.start(playerX, playerY)
	end

end

game_initialize = Play.new
game_initialize.start

