require 'spec_helper'

describe Game do
  let(:input) { FakeInput.new }
  let(:output) { FakeOutput.new }
  let(:player1) {double(Player, name: "Player 1", color: :black )}
  let(:player2) {double(Player, name: "Player 2", color: :white )}
  let(:board) { Board.new(player1, player2) }
  let(:game) {Game.new(player_1: player1, player_2: player2, input: input, output: output, board: board)}


  context '#get_move' do
    it 'creates a Move' do
      move_double = double(Move, get_move: [7,1])
      expect(Move).to receive(:new).with(input: input, output: output, board: board, turn: player1).and_return(move_double)

      game.get_move
    end

    it 'creates a CheckedMove if checked' do
      checked_double = double(CheckedMove, get_move: [7,1])
      allow(board).to receive(:checked?).and_return(true)

      expect(CheckedMove).to receive(:new).with(input: input, output: output, board: board, turn: player1).and_return(checked_double)

      game.get_move
    end
  end
end
