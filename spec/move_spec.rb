require 'spec_helper'

describe Move do
  let(:input) { FakeInput.new }
  let(:output) { FakeOutput.new }
  let(:turn) {double(Player, name: "Player 1", color: :black )}
  let(:board) { double(Board) } 
  let(:move) { Move.new(input: input, output: output, turn: turn, board: board) }

  context '#get_move' do
    it 'calls for move' do
      stub_legal_move({legal: true, message: "Legal"})
      stub_input('0,1-0,2')

      move.get_move

      expect(input).to have_received(:gets).once
      expect(output.messages).to include(/please choose the piece .+ to move/)
    end

    it 'gets for input until legal' do
      stub_legal_move({legal: false, message: "Not legal"}, {legal: true, message: "Legal"})
      stub_input('0,1-0,2', '0,1-0,2')

      move.get_move

      expect(input).to have_received(:gets).twice
    end
  end

  context '#is_legal' do
    it 'returns true if legal move' do
      stub_legal_move({legal: true, message: "Legal"})

      expect(move.is_legal?).to be( true )
      end

    it 'returns false if illegal' do
      stub_legal_move({legal: false, message: "Not Legal"})

      expect(move.is_legal?).to be( false )
    end

    it 'sets the message with the move legality' do
      stub_legal_move({legal: true, message: "Legal"})

      move.is_legal?

      expect(move.message).to eq("Legal")
    end

  end

  context '#valid_input' do
    it 'requests valid input' do
      valid_input = "0,1-0,2"
      stub_input(valid_input)

      actual_move = move.get_valid_input

      expect(actual_move).to eq({from:[0,1], to: [0,2]})
    end

    it 'asks until input is valid' do
      invalid_inputs = ["wrong input", "01-02", "0-1,0-2"]
      valid_input = "0,1-0,2"
      stub_input(*invalid_inputs, valid_input)

      actual_move = move.get_valid_input

      expect(actual_move).to eq({from:[0,1], to: [0,2]})
      expect(input).to have_received(:gets).exactly(4).times
    end
  end

  def stub_legal_move(*moves)
    allow(board).to receive(:board_info).and_return('')
    allow(board).to receive(:legal_move).and_return(*moves)
  end

  def stub_input(*strings)
    allow(input).to receive(:gets).and_return(*strings)
  end
end
