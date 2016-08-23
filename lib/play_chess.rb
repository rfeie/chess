require 'player'
require 'player_generator'

class PlayChess

  def initialize(input: Input.new, output: Output.new)
    @_input = input
    @_output = output
    @players = {}

    welcome
  end

  def welcome
    display("Welcome to Command Line Chess!")
    create_players
    start_game
  end

  def create_players
    display("Create Player 1:")
    @players[:player_1] = player_generator.create_player
    display("Create Player 2:")
    @players[:player_2] = player_generator.create_player
  end

  def start_game
    @game = Game.new(player_1: @players[:player_1], player_2: @players[:player_2], input: @_input, output: @_output)
    @game.start_game
    process_game_ending
  end

  def process_game_ending
    display "Game is over. Do you want to play again? (y/n)"
    response = get_input(/y|n/, "y,n")

    if response == "y"
      display "Starting another game!"
      start_game
    else
      display "Thanks for playing!"
    end
  end

  private

  def get_input pattern, valid_choices
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

  def player_generator
    @_player_generator ||= PlayerGenerator.new
  end
end