require 'spec_helper'

describe PlayChess do

  let (:input) {FakeInput.new}
  let (:output) {FakeOutput.new}

  it "Welcomes the user" do
    stub_game
    input.responses << "n"
    described_class.new(input: input, output: output)

    expect(output.messages).to include("Welcome to Command Line Chess!")
  end

  it "creates the players" do
    player_1 = double(Player)
    player_2 = double(Player)
    generator = stub_generator(player_1, player_2)
    stub_game
    input.responses << "n"

    described_class.new(input: input, output: output)

    expect(output.messages).to include("Create Player 1:", "Create Player 2:")
    expect(generator).to have_received(:create_player).twice
  end

  it "creates the game" do
    player_1 = double(Player)
    player_2 = double(Player)
    board = stub_board
    stub_generator(player_1, player_2)
    stub_game
    input.responses << "n"

    described_class.new(input: input, output: output)
    
    expect(Game).to have_received(:new).with(player_1: player_1, player_2: player_2, input: input, output: output, board: board)
  end

  it "asks to play again and starts another" do
    player_1 = double(Player)
    player_2 = double(Player)
    stub_generator(player_1, player_2)
    stub_game
    allow(input).to receive(:gets).and_return("y", "n")

    described_class.new(input: input, output: output)

    expect(output.messages).to include("Game is over. Do you want to play again? (y/n)")
    expect(input).to have_received(:gets).twice
    expect(output.messages).to include("Starting another game!")
    expect(Game).to have_received(:new).twice
  end

  def stub_generator(player_1, player_2)
    generator = double(PlayerGenerator)
    allow(PlayerGenerator).to receive(:new).and_return(generator)
    allow(generator).to receive(:create_player).and_return(player_1, player_2)
    generator
  end

  def stub_game
    game = double(Game, start_game: nil, outcome: :finished)
    allow(Game).to receive(:new).and_return(game)
    game
  end

  def stub_board
    board = double(Board)
    allow(Board).to receive(:new).and_return(board)
    board
  end
end
