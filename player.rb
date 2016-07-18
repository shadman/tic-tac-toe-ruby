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