require 'spec_helper'

describe Board do
	before :each do
    player_1 = double(Player, name: "Player 1", color: :white)
    player_2 = double(Player, name: "Player 2", color: :black)
    input = FakeInput.new
    output = FakeOutput.new
		@game = Game.new(input: input, output: output, player_1: player_1, player_2: player_2)
		@board = Board.new(@game.player1, @game.player2)
	end

	context "draw board runs correctly" do
		it "is blank with no game data" do
			output = @board.draw
			expected = "
    0   1   2   3   4   5   6   7	
   _______________________________		
  |   |   |   |   |   |   |   |   |
7 |   |   |   |   |   |   |   |   | 7
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
6 |   |   |   |   |   |   |   |   | 6
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
5 |   |   |   |   |   |   |   |   | 5
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
4 |   |   |   |   |   |   |   |   | 4
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
3 |   |   |   |   |   |   |   |   | 3
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
2 |   |   |   |   |   |   |   |   | 2
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
1 |   |   |   |   |   |   |   |   | 1
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
0 |   |   |   |   |   |   |   |   | 0
  |___|___|___|___|___|___|___|___|
    0   1   2   3   4   5   6   7"
			expect(output).to eq(expected)

		end
		it "draws the starting board correctly" do
			output = @board.draw(@board.board_info)
			expected = "
    0   1   2   3   4   5   6   7	
   _______________________________		
  |   |   |   |   |   |   |   |   |
7 | ♜ | ♞ | ♝ | ♛ | ♚ | ♝ | ♞ | ♜ | 7
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
6 | ♟ | ♟ | ♟ | ♟ | ♟ | ♟ | ♟ | ♟ | 6
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
5 |   |   |   |   |   |   |   |   | 5
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
4 |   |   |   |   |   |   |   |   | 4
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
3 |   |   |   |   |   |   |   |   | 3
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
2 |   |   |   |   |   |   |   |   | 2
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
1 | ♙ | ♙ | ♙ | ♙ | ♙ | ♙ | ♙ | ♙ | 1
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
0 | ♖ | ♘ | ♗ | ♔ | ♕ | ♗ | ♘ | ♖ | 0
  |___|___|___|___|___|___|___|___|
    0   1   2   3   4   5   6   7"

			expect(output).to eq(expected)


		end

		it "draws a in-progress board correctly" do
			test_data = {
				white:{
					pawn:{loc: [[0, 2],[1, 1],[2, 1],[3, 1],[4, 1],[5, 1],[6, 1],[7, 1]], mark: "\u2659"},
					rook:{loc: [[0, 0],[7, 0]], mark: "\u2656"},
					knight:{loc: [[1, 0],[6, 0]], mark: "\u2658"},
					bishop:{loc: [[2, 0],[5, 0]], mark: "\u2657"},
					king:{loc: [[3, 0]], mark: "\u2655"},
					queen:{loc: [[4, 0]], mark: "\u2654"}

					},

				black:{
					pawn:{loc: [[0, 6],[1, 6],[3, 6],[4, 6],[5, 6],[6, 6],[7, 6]], mark: "\u265F"},
					rook:{loc: [[0, 7],[7, 7]], mark: "\u265C"},
					knight:{loc: [[2, 5],[6, 7]], mark: "\u265E"},
					bishop:{loc: [[2, 7],[5, 7]], mark: "\u265D"},
					king:{loc: [[3, 7]], mark: "\u265A"},
					queen:{loc: [[4, 7]], mark: "\u265B"}
					}

			}

			output = @board.draw(test_data)
						expected = "
    0   1   2   3   4   5   6   7	
   _______________________________		
  |   |   |   |   |   |   |   |   |
7 | ♜ |   | ♝ | ♚ | ♛ | ♝ | ♞ | ♜ | 7
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
6 | ♟ | ♟ |   | ♟ | ♟ | ♟ | ♟ | ♟ | 6
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
5 |   |   | ♞ |   |   |   |   |   | 5
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
4 |   |   |   |   |   |   |   |   | 4
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
3 |   |   |   |   |   |   |   |   | 3
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
2 | ♙ |   |   |   |   |   |   |   | 2
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
1 |   | ♙ | ♙ | ♙ | ♙ | ♙ | ♙ | ♙ | 1
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
0 | ♖ | ♘ | ♗ | ♕ | ♔ | ♗ | ♘ | ♖ | 0
  |___|___|___|___|___|___|___|___|
    0   1   2   3   4   5   6   7"

			expect(output).to eq(expected)


		end

	end

	context "create_board helper creates correct data" do
		it "correctly translates starting game data" do
			output = @board.create_board(@board.board_info)
			expected = [
				[{:piece=>:rook, :color=>:white, :mark=>"♖"}, {:piece=>:pawn, :color=>:white, :mark=>"♙"}, nil, nil, nil, nil, {:piece=>:pawn, :color=>:black, :mark=>"♟"}, {:piece=>:rook, :color=>:black, :mark=>"♜"}], 
				[{:piece=>:knight, :color=>:white, :mark=>"♘"}, {:piece=>:pawn, :color=>:white, :mark=>"♙"}, nil, nil, nil, nil, {:piece=>:pawn, :color=>:black, :mark=>"♟"}, {:piece=>:knight, :color=>:black, :mark=>"♞"}], 
				[{:piece=>:bishop, :color=>:white, :mark=>"♗"}, {:piece=>:pawn, :color=>:white, :mark=>"♙"}, nil, nil, nil, nil, {:piece=>:pawn, :color=>:black, :mark=>"♟"}, {:piece=>:bishop, :color=>:black, :mark=>"♝"}], 
				[{:piece=>:queen, :color=>:white, :mark=>"♔"}, {:piece=>:pawn, :color=>:white, :mark=>"♙"}, nil, nil, nil, nil, {:piece=>:pawn, :color=>:black, :mark=>"♟"}, {:piece=>:queen, :color=>:black, :mark=>"♛"}], 
				[{:piece=>:king, :color=>:white, :mark=>"♕"}, {:piece=>:pawn, :color=>:white, :mark=>"♙"}, nil, nil, nil, nil, {:piece=>:pawn, :color=>:black, :mark=>"♟"}, {:piece=>:king, :color=>:black, :mark=>"♚"}], 
				[{:piece=>:bishop, :color=>:white, :mark=>"♗"}, {:piece=>:pawn, :color=>:white, :mark=>"♙"}, nil, nil, nil, nil, {:piece=>:pawn, :color=>:black, :mark=>"♟"}, {:piece=>:bishop, :color=>:black, :mark=>"♝"}], 
				[{:piece=>:knight, :color=>:white, :mark=>"♘"}, {:piece=>:pawn, :color=>:white, :mark=>"♙"}, nil, nil, nil, nil, {:piece=>:pawn, :color=>:black, :mark=>"♟"}, {:piece=>:knight, :color=>:black, :mark=>"♞"}], 
				[{:piece=>:rook, :color=>:white, :mark=>"♖"}, {:piece=>:pawn, :color=>:white, :mark=>"♙"}, nil, nil, nil, nil, {:piece=>:pawn, :color=>:black, :mark=>"♟"}, {:piece=>:rook, :color=>:black, :mark=>"♜"}]]

			expect(output).to eq(expected)			
		end
		it "correctly translates in-progress game data" do
			test_data = {
				white:{
					pawn:{loc: [[0, 2],[1, 1],[2, 1],[3, 1],[4, 1],[5, 1],[6, 1],[7, 1]], mark: "\u2659"},
					rook:{loc: [[0, 0],[7, 0]], mark: "\u2656"},
					knight:{loc: [[1, 0],[6, 0]], mark: "\u2658"},
					bishop:{loc: [[2, 0],[5, 0]], mark: "\u2657"},
					king:{loc: [[3, 0]], mark: "\u2655"},
					queen:{loc: [[4, 0]], mark: "\u2654"}

					},

				black:{
					pawn:{loc: [[0, 6],[1, 6],[3, 6],[4, 6],[5, 6],[6, 6],[7, 6]], mark: "\u265F"},
					rook:{loc: [[0, 7],[7, 7]], mark: "\u265C"},
					knight:{loc: [[2, 5],[6, 7]], mark: "\u265E"},
					bishop:{loc: [[2, 7],[5, 7]], mark: "\u265D"},
					king:{loc: [[3, 7]], mark: "\u265A"},
					queen:{loc: [[4, 7]], mark: "\u265B"}
					}

			}
			output = @board.create_board(test_data)
			expected = [
				[{:piece=>:rook, :color=>:white, :mark=>"♖"}, nil, {:piece=>:pawn, :color=>:white, :mark=>"♙"}, nil, nil, nil, {:piece=>:pawn, :color=>:black, :mark=>"♟"}, {:piece=>:rook, :color=>:black, :mark=>"♜"}], 
				[{:piece=>:knight, :color=>:white, :mark=>"♘"}, {:piece=>:pawn, :color=>:white, :mark=>"♙"}, nil, nil, nil, nil, {:piece=>:pawn, :color=>:black, :mark=>"♟"}, nil], 
				[{:piece=>:bishop, :color=>:white, :mark=>"♗"}, {:piece=>:pawn, :color=>:white, :mark=>"♙"}, nil, nil, nil, {:piece=>:knight, :color=>:black, :mark=>"♞"}, nil, {:piece=>:bishop, :color=>:black, :mark=>"♝"}], 
				[{:piece=>:king, :color=>:white, :mark=>"♕"}, {:piece=>:pawn, :color=>:white, :mark=>"♙"}, nil, nil, nil, nil, {:piece=>:pawn, :color=>:black, :mark=>"♟"}, {:piece=>:king, :color=>:black, :mark=>"♚"}], 
				[{:piece=>:queen, :color=>:white, :mark=>"♔"}, {:piece=>:pawn, :color=>:white, :mark=>"♙"}, nil, nil, nil, nil, {:piece=>:pawn, :color=>:black, :mark=>"♟"}, {:piece=>:queen, :color=>:black, :mark=>"♛"}], 
				[{:piece=>:bishop, :color=>:white, :mark=>"♗"}, {:piece=>:pawn, :color=>:white, :mark=>"♙"}, nil, nil, nil, nil, {:piece=>:pawn, :color=>:black, :mark=>"♟"}, {:piece=>:bishop, :color=>:black, :mark=>"♝"}], 
				[{:piece=>:knight, :color=>:white, :mark=>"♘"}, {:piece=>:pawn, :color=>:white, :mark=>"♙"}, nil, nil, nil, nil, {:piece=>:pawn, :color=>:black, :mark=>"♟"}, {:piece=>:knight, :color=>:black, :mark=>"♞"}], 
				[{:piece=>:rook, :color=>:white, :mark=>"♖"}, {:piece=>:pawn, :color=>:white, :mark=>"♙"}, nil, nil, nil, nil, {:piece=>:pawn, :color=>:black, :mark=>"♟"}, {:piece=>:rook, :color=>:black, :mark=>"♜"}]]

			expect(output).to eq(expected)	
		end
	end

	context "legal_move functions correctly" do

		it "does not allow a move out of bounds" do

			move_1 = {from: [1, 8], to: [2,7]}
			move_2 = {from: [1, 1], to: [9,7]}
			output_1 = @board.legal_move(@board.board_info, move_1, :white)	
			output_2 = @board.legal_move(@board.board_info, move_2, :white)	

			expect(output_1[:message]).to eq("Move is out of bounds")	
			expect(output_1[:legal]).to eq(false)	
			expect(output_2[:message]).to eq("Move is out of bounds")	
			expect(output_1[:legal]).to eq(false)	

		end

		it "does not allow a selection of other players piece" do

			move_1 = {from: [0, 6], to: [2,7]}
			move_2 = {from: [4, 7], to: [5,7]}
			output_1 = @board.legal_move(@board.board_info, move_1, :white)	
			output_2 = @board.legal_move(@board.board_info, move_2, :white)	

			expect(output_1[:message]).to eq("Piece selected to move is not yours. Please select again.")	
			expect(output_1[:legal]).to eq(false)	
			expect(output_2[:message]).to eq("Piece selected to move is not yours. Please select again.")	
			expect(output_1[:legal]).to eq(false)				
		end

		it "makes you move the king if necessary" do
			move_1 = {from: [0, 0], to: [2,7]}
			move_2 = {from: [3, 0], to: [5,7]}
			output_1 = @board.legal_move(@board.board_info, move_1, :white, :king)	
			output_2 = @board.legal_move(@board.board_info, move_2, :white, :king)	

			expect(output_1[:message]).to eq("Piece selected to move is not the required piece. Please select again.")	
			expect(output_1[:legal]).to eq(false)	
			expect(output_2[:message]).to eq("Piece selected to move is not the required piece. Please select again.")	
			expect(output_2[:legal]).to eq(false)				

		end

		it "does not allow a move of a pawn outside it's legal moves, but allows legal moves" do
			move_1 = {from: [0, 1], to: [0,3]} #forward two - legal
			move_2 = {from: [0, 1], to: [0,2]} #forward one - legal
			move_3 = {from: [0, 1], to: [1,2]} #diagonal - illegal

			output_1 = @board.legal_move(@board.board_info, move_1, :white)	
			output_2 = @board.legal_move(@board.board_info, move_2, :white)	
			output_3 = @board.legal_move(@board.board_info, move_3, :white)	

			expect(output_1[:message]).to eq("Valid Move.")	
			expect(output_1[:legal]).to eq(true)	
			expect(output_2[:message]).to eq("Valid Move.")	
			expect(output_2[:legal]).to eq(true)	
			expect(output_3[:message]).to eq("Invalid move for the selected piece.")	
			expect(output_3[:legal]).to eq(false)			
			
		end

		it "allows for legal move of knight" do
			
			test_data = {
				white:{
					pawn:{loc: [], mark: "\u2659"},
					rook:{loc: [], mark: "\u2656"},
					knight:{loc: [[3, 3],[5, 2]], mark: "\u2658"},
					bishop:{loc: [], mark: "\u2657"},
					king:{loc: [], mark: "\u2655"},
					queen:{loc: [], mark: "\u2654"}

					},

				black:{
					pawn:{loc: [], mark: "\u265F"},
					rook:{loc: [], mark: "\u265C"},
					knight:{loc: [[2, 5]], mark: "\u265E"},
					bishop:{loc: [], mark: "\u265D"},
					king:{loc: [], mark: "\u265A"},
					queen:{loc: [], mark: "\u265B"}
					}

			}

			move_1 = {from: [3, 3], to: [2,5]} #white to black space - legal
			move_2 = {from: [3, 3], to: [4,5]} #white to blank space - legal
			move_3 = {from: [3, 3], to: [5,2]} #white to white space - illegal

			output_1 = @board.legal_move(test_data, move_1, :white)	
			output_2 = @board.legal_move(test_data, move_2, :white)	
			output_3 = @board.legal_move(test_data, move_3, :white)	

			expect(output_1[:message]).to eq("Valid Move.")	
			expect(output_1[:legal]).to eq(true)	
			expect(output_2[:message]).to eq("Valid Move.")	
			expect(output_2[:legal]).to eq(true)	
			expect(output_3[:message]).to eq("Invalid move for the selected piece.")	
			expect(output_3[:legal]).to eq(false)		

		end

		it "allows for legal move of rook/queen/bishop" do
			test_data = {
				white:{
					pawn:{loc: [], mark: "\u2659"},
					rook:{loc: [[0,0]], mark: "\u2656"},
					knight:{loc: [[3, 3],[5, 2]], mark: "\u2658"},
					bishop:{loc: [[3,0]], mark: "\u2657"},
					king:{loc: [], mark: "\u2655"},
					queen:{loc: [[0,3]], mark: "\u2654"}

					},

				black:{
					pawn:{loc: [], mark: "\u265F"},
					rook:{loc: [], mark: "\u265C"},
					knight:{loc: [[2, 5]], mark: "\u265E"},
					bishop:{loc: [], mark: "\u265D"},
					king:{loc: [], mark: "\u265A"},
					queen:{loc: [], mark: "\u265B"}
					}

			}

			queen_move_1 = {from: [0, 3], to: [2,5]} # true - takes black piece
			queen_move_2 = {from: [0, 3], to: [4,3]} # false - past white piece
			queen_move_3 = {from: [0, 3], to: [1,5]} # false - not in pattern
			rook_move_1 = {from: [0, 0], to: [0,4]} # false - moves past white piece 
			rook_move_2 = {from: [0, 0], to: [2,0]} # true
			bishop_move_1 = {from: [3, 0], to: [1,2]} # true
			bishop_move_2 = {from: [3, 0], to: [4,7]} # false - out of pattern

			queen_output_1 = @board.legal_move(test_data, queen_move_1, :white)
			queen_output_2 = @board.legal_move(test_data, queen_move_2, :white)
			queen_output_3 = @board.legal_move(test_data, queen_move_3, :white)
			rook_output_1 = @board.legal_move(test_data, rook_move_1, :white)
			rook_output_2 = @board.legal_move(test_data, rook_move_2, :white)
			bishop_output_1 = @board.legal_move(test_data, bishop_move_1, :white)
			bishop_output_2 = @board.legal_move(test_data, bishop_move_2, :white)

			expect(queen_output_1[:message]).to eq("Valid Move.")	
			expect(queen_output_1[:legal]).to eq(true)	
			expect(queen_output_2[:message]).to eq("Invalid move for the selected piece.")	
			expect(queen_output_2[:legal]).to eq(false)	
			expect(queen_output_3[:message]).to eq("Invalid move for the selected piece.")	
			expect(queen_output_3[:legal]).to eq(false)	
			expect(rook_output_1[:message]).to eq("Invalid move for the selected piece.")	
			expect(rook_output_1[:legal]).to eq(false)	
			expect(rook_output_2[:message]).to eq("Valid Move.")	
			expect(rook_output_2[:legal]).to eq(true)	
			expect(bishop_output_1[:message]).to eq("Valid Move.")	
			expect(bishop_output_1[:legal]).to eq(true)	
			expect(bishop_output_2[:message]).to eq("Invalid move for the selected piece.")	
			expect(bishop_output_2[:legal]).to eq(false)	

		end

		it "allows for legal move of king" do
			test_data = {
				white:{
					pawn:{loc: [], mark: "\u2659"},
					rook:{loc: [[0,0]], mark: "\u2656"},
					knight:{loc: [[3, 3],[5, 2]], mark: "\u2658"},
					bishop:{loc: [[3,0]], mark: "\u2657"},
					king:{loc: [[4,0]], mark: "\u2655"},
					queen:{loc: [[0,3]], mark: "\u2654"}

					},

				black:{
					pawn:{loc: [], mark: "\u265F"},
					rook:{loc: [], mark: "\u265C"},
					knight:{loc: [[2, 5]], mark: "\u265E"},
					bishop:{loc: [], mark: "\u265D"},
					king:{loc: [], mark: "\u265A"},
					queen:{loc: [], mark: "\u265B"}
					}

			}

			king_move_1 = {from: [4, 0], to: [5,1]} # true
			king_move_2 = {from: [4, 0], to: [6,2]} # false - out of range 
			king_move_3 = {from: [4, 0], to: [3,0]} # false - piece in place

			king_output_1 = @board.legal_move(test_data, king_move_1, :white)
			king_output_2 = @board.legal_move(test_data, king_move_2, :white)
			king_output_3 = @board.legal_move(test_data, king_move_3, :white)

			expect(king_output_1[:message]).to eq("Valid Move.")	
			expect(king_output_1[:legal]).to eq(true)	
			expect(king_output_2[:message]).to eq("Invalid move for the selected piece.")	
			expect(king_output_2[:legal]).to eq(false)	
			expect(king_output_3[:message]).to eq("Invalid move for the selected piece.")	
			expect(king_output_3[:legal]).to eq(false)	

		end

	end

	context "check returns the correct results" do

		it "a check returns check" do
			test_data = {
				white:{
					pawn:{loc: [], mark: "\u2659"},
					rook:{loc: [[0,0]], mark: "\u2656"},
					knight:{loc: [[3, 3],[5, 2]], mark: "\u2658"},
					bishop:{loc: [[3,0]], mark: "\u2657"},
					king:{loc: [[4,0]], mark: "\u2655"},
					queen:{loc: [[0,3]], mark: "\u2654"}

					},

				black:{
					pawn:{loc: [], mark: "\u265F"},
					rook:{loc: [[4,4], [7,0]], mark: "\u265C"},
					knight:{loc: [[2, 5]], mark: "\u265E"},
					bishop:{loc: [], mark: "\u265D"},
					king:{loc: [], mark: "\u265A"},
					queen:{loc: [], mark: "\u265B"}
					}

			}
			output = @board.check?(test_data, :white)
			expect(output[:check]).to eq(true)
			expect(output[:check_mate]).to eq(false)
		end

		it "a check mate returns checkmate" do
			test_data = {
				white:{
					pawn:{loc: [], mark: "\u2659"},
					rook:{loc: [[0,0]], mark: "\u2656"},
					knight:{loc: [[3, 3],[5, 2]], mark: "\u2658"},
					bishop:{loc: [[3,0]], mark: "\u2657"},
					king:{loc: [[4,0]], mark: "\u2655"},
					queen:{loc: [[0,3]], mark: "\u2654"}

					},

				black:{
					pawn:{loc: [], mark: "\u265F"},
					rook:{loc: [[4,4], [7,0]], mark: "\u265C"},
					knight:{loc: [[2, 5]], mark: "\u265E"},
					bishop:{loc: [], mark: "\u265D"},
					king:{loc: [], mark: "\u265A"},
					queen:{loc: [[7,1]], mark: "\u265B"}
					}

			}
			output = @board.check?(test_data, :white)
			expect(output[:check]).to eq(true)
			expect(output[:check_mate]).to eq(true)

		end

	end
	context "checks make move" do
		it "a move works correctly returns check" do
			test_data_before = {
				white:{
					pawn:{loc: [], mark: "\u2659"},
					rook:{loc: [[0,0]], mark: "\u2656"},
					knight:{loc: [[3, 3],[5, 2]], mark: "\u2658"},
					bishop:{loc: [[6,0]], mark: "\u2657"},
					king:{loc: [[4,0]], mark: "\u2655"},
					queen:{loc: [[0,3]], mark: "\u2654"}

					},

				black:{
					pawn:{loc: [], mark: "\u265F"},
					rook:{loc: [[4,0], [7,0]], mark: "\u265C"},
					knight:{loc: [[2, 5]], mark: "\u265E"},
					bishop:{loc: [], mark: "\u265D"},
					king:{loc: [], mark: "\u265A"},
					queen:{loc: [], mark: "\u265B"}
					}

			}
			test_data_after = {
				white:{
					pawn:{loc: [], mark: "\u2659"},
					rook:{loc: [[4,0]], mark: "\u2656"},
					knight:{loc: [[3, 3],[5, 2]], mark: "\u2658"},
					bishop:{loc: [[6,0]], mark: "\u2657"},
					king:{loc: [[4,0]], mark: "\u2655"},
					queen:{loc: [[0,3]], mark: "\u2654"}

					},

				black:{
					pawn:{loc: [], mark: "\u265F"},
					rook:{loc: [[7,0]], mark: "\u265C"},
					knight:{loc: [[2, 5]], mark: "\u265E"},
					bishop:{loc: [], mark: "\u265D"},
					king:{loc: [], mark: "\u265A"},
					queen:{loc: [], mark: "\u265B"}
					}

			}
			move = {from: [0,0], to:[4,0]}
			output = @board.make_move(test_data_before, move)
			expect(output).to eq(test_data_after)
		end
	end

end
