require_relative 'board'

class Game
	#create players, board, set turn
	#messages object?
	attr_accessor :player1, :player2, :board, :turn
	
	def initialize
		@player1 = {:name => "Player 1", :color => :white}
		@player2 = {:name => "Player 2", :color => :black}
		@board = Board.new(@player1, @player2)
		@turn = @player1

	end
	#start game
	def start_game
		play_again = play

			while play_again
				@board = Board.new
				play_again = play
			end

		puts "Games are ended.\nShutting down!"

	end

	def play

		check_mate = false

		until check_mate
			#check if past move resulted in a check
			check = @board.check?(@board.board_info, @turn[:color])
			if check[:check_mate]
				puts @board.draw(@board.board_info)
				check_mate = true
				puts "Checkmate! #{turn[:name]} loses!" 
			elsif check[:check]
				#force them to move the king
				puts @board.draw(@board.board_info)
				puts "#{@turn[:name]} you are checked. Move your king to continue"
				move = get_move(true)
				@board.board_info = @board.make_move(@board.board_info, move)
				switch_turn
			else
				puts @board.draw(@board.board_info)
				move = get_move
				@board.board_info = @board.make_move(@board.board_info, move)
				switch_turn
			end
		end

		puts "Do you want to play again? (y/n)"
		play_again = gets.chomp.downcase
		until play_again == "y" or play_again == "n"
			puts "Invalid Input, Please type \"y\" or  \"n\""
		end
		return play_again.downcase == "y" ? true : false
	end

	def switch_turn
		@turn = (@turn == @player1) ? @player2 : @player1
	end

	def get_move(checked = false)
		puts "#{@turn[:name]} please choose the piece (#{(@turn[:color] == :black) ? "black" : "white" }) to move. Format should be \"x,y-x,y\", ex. \"0,1-0,2\""
		input = gets.chomp
		move = valid_move(input)

		if checked
			is_legal = @board.legal_move(@board.board_info, move, @turn[:color],:king)
			until is_legal[:legal] 
				puts is_legal[:message]
				input = gets.chomp
				move = valid_move(input)
				is_legal = @board.legal_move(@board.board_info, move, @turn[:color],:king)

			end
			check = check?(@board.board_info, @turn[:color], move[:to])
			until check[:false] == false
				puts "Move does not move you out of check, please enter again."
				input = gets.chomp
				move = valid_move(input)
				check = check?(@board.board_info, @turn[:color], move[:to])
			end
		else
			puts move
			is_legal = @board.legal_move(@board.board_info, move, @turn[:color])
			until is_legal[:legal] 
				puts is_legal[:message]
				input = gets.chomp
				move = valid_move(input)
				is_legal = @board.legal_move(@board.board_info, move, @turn[:color])
			end
		end

		move
	end

	def valid_move(input)
		move = { from: [], to: []}
		valid = false

		until valid
			process = input.split("-")

			if process.length == 2
				moves = []
				process.each do |input|
					list = input.scan(/\d/)
					list.map! {|i| i.to_i}
					moves.push(list)					
				end
				if moves[0].length == 2 and moves[1].length == 2
					move[:from] = moves[0]
					move[:to] = moves[1]
					valid = true
				else
					puts "Incorrect format from input #{input}. Please enter your input..."
					input = gets.chomp

				end


			else
				puts "Incorrect format from input #{input}. Please enter your input..."
				input = gets.chomp
			end
		end
		move
	end

end
game = Game.new
game.start_game
