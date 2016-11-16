class Move

  VALID_MOVE_REGEX = /^([0-9]),([0-9])-([0-9]),([0-9])$/

  attr_reader :message

  def initialize(input:, output:, board:, turn:)
    @_input = input
    @_output = output
    @board = board
    @turn = turn
  end

  def get_move
    call_to_action
    get_valid_input

    until is_legal?
      display message
      get_valid_input
    end

    move
  end

  def get_valid_input
    new_move = { from: [], to: []}

    input = get_input(VALID_MOVE_REGEX, 'x,y-x,y').match(VALID_MOVE_REGEX)

    new_move[:from] = [input[1].to_i, input[2].to_i]
    new_move[:to] = [input[3].to_i, input[4].to_i]
    @move = new_move
  end

  def is_legal?
      response = @board.legal_move(@board.board_info, move, @turn.color)
      @message = response[:message]
      response[:legal]
  end

  private

  attr_reader :move

  def call_to_action
    display "#{@turn.name} please choose the piece (#{(@turn.color == :black) ? "black" : "white" }) to move. Format should be \"x,y-x,y\", ex. \"0,1-0,2\""
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
