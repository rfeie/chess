require_relative 'board'

class Game
  attr_accessor :player1, :player2, :board, :turn

  def initialize(player_1:, player_2:,input:, output:, board:)
    @player1 = player_1
    @player2 = player_2
    @_input = input
    @_output = output
    @board = board
    @turn = @player1
  end

  def start_game
    play
  end

  def play
    check_mate = false

    until check_mate
      check = @board.check?(@board.board_info, @turn.color)
      if check[:check_mate]
        display @board.draw(@board.board_info)
        check_mate = true
        display "Checkmate! #{turn.name} loses!" 
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

  def get_move
    if @board.checked?(@board.board_info, @turn.color)
      display "#{@turn.name} you are checked. Protect your king to continue."
      move = CheckedMove.new(input: input, output: output, board: board, turn: @turn)
    else
      move = Move.new(input: input, output: output, board: board, turn: @turn)
    end
    move.get_move
  end

  private

  attr_reader :board

  def output
    @_output
  end

  def input
    @_input
  end

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
