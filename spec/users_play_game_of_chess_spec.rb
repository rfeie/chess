require 'spec_helper'

describe "A game of chess" do
  let(:input) { FakeInput.new }
  let(:output) { FakeOutput.new }

  it "Allows for a complete game of chess" do
    winning_inputs.each do |user_input|
      input.responses << user_input
    end

    PlayChess.new(input: input, output: output)

    expect(output.messages).to include('Checkmate! Player 1 loses!')
  end

  def winning_inputs
    [
      "5,1-5,2", # white
      "4,6-4,4", # black
      "6,1-6,3", # white
      "3,7-7,3", # black
      "n"
    ]
  end
end
