require 'spec_helper'

describe CheckedMove do
  let(:input) { FakeInput.new }
  let(:output) { FakeOutput.new }
  let(:turn) {double(Player, name: "Player 1", color: :black )}
  let(:board) { double(Board) } 
  let(:move) { CheckedMove.new(input: input, output: output, turn: turn, board: board) }

  it 'requests moves until legal and no longer checked' do
      stub_legal_move({legal: true, message: "Legal"}, {legal: true, message: "Legal"})
      stub_checked(true, false)
      stub_input('0,1-0,2', '0,1-0,2')

      move.get_move

      expect(input).to have_received(:gets).twice
  end

  def stub_legal_move(*moves)
    allow(board).to receive(:board_info).and_return('')
    allow(board).to receive(:legal_move).and_return(*moves)
  end

  def stub_checked(*moves)
    allow(board).to receive(:board_info).and_return('')
    allow(board).to receive(:checked?).and_return(*moves)
  end
  def stub_input(*strings)
    allow(input).to receive(:gets).and_return(*strings)
  end
end
