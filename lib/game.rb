require_relative 'board'

class Game
	attr_accessor :player1, :player2, :board, :turn
	
  def initialize(player_1:, player_2:,input:, output:)
		@player1 = player_1
		@player2 = player_2
    @_input = input
    @_output = output
		@board = Board.new(@player1, @player2)
		@turn = @player1
  end

	def start_game
		play_again = play

			while play_again
				@board = Board.new
				play_again = play
			end

		display "Games are ended.\nShutting down!"

	end

	def play

		check_mate = false

		until check_mate
      check = @board.check?(@board.board_info, @turn.color)
			if check[:check_mate]
				display @board.draw(@board.board_info)
				check_mate = true
				display "Checkmate! #{turn.name} loses!" 
			elsif check[:check]
				#force them to move the king
				display @board.draw(@board.board_info)
				display "#{@turn.name} you are checked. Move your king to continue"
				move = get_move(true)
				@board.board_info = @board.make_move(@board.board_info, move)
				switch_turn
			else
				display @board.draw(@board.board_info)
				move = get_move
				@board.board_info = @board.make_move(@board.board_info, move)
				switch_turn
			end
		end

	end

	def switch_turn
		@turn = (@turn == @player1) ? @player2 : @player1
	end

	def get_move(checked = false)
		display "#{@turn.name} please choose the piece (#{(@turn.color == :black) ? "black" : "white" }) to move. Format should be \"x,y-x,y\", ex. \"0,1-0,2\""
		input = get_input
		move = valid_move(input)

		if checked
			is_legal = @board.legal_move(@board.board_info, move, @turn.color,:king)
			until is_legal[:legal] 
				display is_legal[:message]
				input = get_input
				move = valid_move(input)
				is_legal = @board.legal_move(@board.board_info, move, @turn.color,:king)

			end
			check = check?(@board.board_info, @turn.color, move[:to])
			until check[:false] == false
				display "Move does not move you out of check, please enter again."
				input = get_input
				move = valid_move(input)
				check = check?(@board.board_info, @turn.color, move[:to])
			end
		else
			display move
			is_legal = @board.legal_move(@board.board_info, move, @turn.color)
			until is_legal[:legal] 
				display is_legal[:message]
				input = get_input
				move = valid_move(input)
				is_legal = @board.legal_move(@board.board_info, move, @turn.color)
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
					display "Incorrect format from input #{input}. Please enter your input..."
					input = get_input
				end
			else
				display "Incorrect format from input #{input}. Please enter your input..."
				input = get_input
			end
		end
		move
	end

  private

  def get_input pattern = /.+/, valid_choices = "anything."
    input = @_input.gets.match(pattern)
    until input
      display "Incorrect input, your choices should look like #{valid_choices}"
      input = @_input.gets.match(pattern)
    end
    input[0]
  end

  def display message
    @_output.puts message
  end

end
