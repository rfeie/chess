class Board
  attr_accessor :board_info
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board_info = {
      white:{
        pawn:{loc: [[0, 1],[1, 1],[2, 1],[3, 1],[4, 1],[5, 1],[6, 1],[7, 1]], mark: "\u2659"},
        rook:{loc: [[0, 0],[7, 0]], mark: "\u2656"},
        knight:{loc: [[1, 0],[6, 0]], mark: "\u2658"},
        bishop:{loc: [[2, 0],[5, 0]], mark: "\u2657"},
        king:{loc: [[4, 0]], mark: "\u2655"},
        queen:{loc: [[3, 0]], mark: "\u2654"}

        },

      black:{
        pawn:{loc: [[0, 6],[1, 6],[2, 6],[3, 6],[4, 6],[5, 6],[6, 6],[7, 6]], mark: "\u265F"},
        rook:{loc: [[0, 7],[7, 7]], mark: "\u265C"},
        knight:{loc: [[1, 7],[6, 7]], mark: "\u265E"},
        bishop:{loc: [[2, 7],[5, 7]], mark: "\u265D"},
        king:{loc: [[4, 7]], mark: "\u265A"},
        queen:{loc: [[3, 7]], mark: "\u265B"}
        }

    }


  end

  def draw(board_info = [])
    info = create_board(board_info)

    board = "
    0   1   2   3   4   5   6   7
   _______________________________
  |   |   |   |   |   |   |   |   |
7 | [0,7] | [1,7] | [2,7] | [3,7] | [4,7] | [5,7] | [6,7] | [7,7] | 7
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
6 | [0,6] | [1,6] | [2,6] | [3,6] | [4,6] | [5,6] | [6,6] | [7,6] | 6
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
5 | [0,5] | [1,5] | [2,5] | [3,5] | [4,5] | [5,5] | [6,5] | [7,5] | 5
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
4 | [0,4] | [1,4] | [2,4] | [3,4] | [4,4] | [5,4] | [6,4] | [7,4] | 4
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
3 | [0,3] | [1,3] | [2,3] | [3,3] | [4,3] | [5,3] | [6,3] | [7,3] | 3
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
2 | [0,2] | [1,2] | [2,2] | [3,2] | [4,2] | [5,2] | [6,2] | [7,2] | 2
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
1 | [0,1] | [1,1] | [2,1] | [3,1] | [4,1] | [5,1] | [6,1] | [7,1] | 1
  |___|___|___|___|___|___|___|___|
  |   |   |   |   |   |   |   |   |
0 | [0,0] | [1,0] | [2,0] | [3,0] | [4,0] | [5,0] | [6,0] | [7,0] | 0
  |___|___|___|___|___|___|___|___|
    0   1   2   3   4   5   6   7"

    info.each_with_index do |list, x|
      list.each_with_index do |item, y|
        if item
          idx = "[#{x},#{y}]"
          board = board.gsub(idx, item[:mark])
        end
      end
    end   
    board = board.gsub(/\[\d\,\d\]/, " ")
    board
  end

  def legal_move(board_info, move, color, required = nil)
    from = move[:from]
    to = move[:to]
    board = create_board(board_info)
    return_info = {legal: false, message: ""}
    #check from/to, within bounds?
    if (from[0] > 7 or from[1] > 7) or (to[0] > 7 or to[1] > 7) or (from[0] < 0 or from[1] < 0) or (to[0] < 0 or to[1] < 0)
      return_info[:message] = "Move is out of bounds"
      return return_info
    end
    if from == to
      return_info[:message] = "Does not move the piece. Please select again"
      return return_info  
    end
    #check if from is valid piece
    piece = board[from[0]][from[1]]
    
    if piece
      if piece[:color] != color
        return_info[:message] = "Piece selected to move is not yours. Please select again."
        return return_info
      end 
    end

    if required
      if piece[:piece] != required 
        return_info[:message] = "Piece selected to move is not the required piece. Please select again."
        return return_info
      end 

    end
    valid = false
    if piece
      valid = check_move(board, from, to, color)
    end
    #for this type. could it move to the location at move?
    # use bfs from knights travails to see if legal?
    if valid
      return_info[:legal] = true
      return_info[:message] = "Valid Move."
      return return_info
    else
      return_info[:message] = "Invalid move for the selected piece."
      return return_info
    end
  end

  def check_move(board, from, to, color)

    #get piece type at location 

    type = board[from[0]][from[1]][:piece]

    #longass case statement?
    #if it requires a n+ number of moves.
      # push to helper method that checks each chain?
    #return true or false

    destination = board[to[0]][to[1]]
    if destination
      return false if destination[:color] == color    
    end
    #destination is either other player or nil
    case type
    when :pawn
      difference = [to[0] - from[0] ,to[1] - from[1]]

      if color == :white
        # +1
        #[1, 0], [2, 0], [1, 1], [1,-1]
        case difference
        when [0,1]
          if destination == nil
            return true
          else
            return false
          end 
        when [0,2]
          if from[1] == 1 and destination == nil
            return true
          else
            return false
          end
        when [-1,1],[1,1]
          if destination
            return true if destination[:color] == :black        
          else
            return false
          end
        else
          return false
        end
        
      else
        #[1, 0], [2, 0], [1, 1], [1,-1]
        case difference
        when [0,-1]
          if destination == nil
            return true
          else
            return false
          end 
        when [0,-2]
          if from[1] == 6 and destination == nil
            return true
          else
            return false
          end
        when [-1,1],[1,1]
          if destination
            return true if destination[:color] == :black        
          else
            return false
          end       
        else
          return false
        end
      end

    when :rook
      return move_search(board, from, to, color, :axis)
    when :knight

      difference = [(to[0] - from[0]).abs ,(to[1] - from[1]).abs]
      if difference == [1,2] or difference == [2,1]

        if destination
          if destination[:color] == color
            return false 
          else
            return true
          end

        else
          return true
        end
      else
        return false
      end

    when :bishop
      return move_search(board, from, to, color, :diagonal)
    when :queen
      return move_search(board, from, to, color, :omni)
    when :king
      difference = [(to[0] - from[0]).abs ,(to[1] - from[1]).abs]
      greater_than_1 = difference.any? {|num| num > 1}
      if greater_than_1 
        
        return false
      elsif destination
        return false if destination[:color] == color
      else
        return true
      end
      #run check?
    end   
  end

  def move_search(board, from, to, color, direction)
    #omni, axis, or diagonal
    queue = [Node.new(from)]
    moves = {
      omni:[[0,1], [1,0], [0, -1], [-1, 0], [1,1], [-1,-1], [1,-1], [-1,1]], 
      axis:[[0,1], [1,0], [0, -1], [-1, 0]], 
      diagonal:[[1,1], [-1,-1], [1,-1], [-1,1]]
    }

    until queue == []
      #look at first in queue
      current = queue.shift

      #see if it matches
      if current.value == to
        return true
      else
        #if no match, see if the current node is a valid movement location
          #see if node has a pattern (not the root node)
        if current.pattern
          piece = board[current.value[0]][current.value[1]]
          if piece == nil

            #if so see if a node at the next line in the pattern is within bounds, if so create and add to queue
            new_x = current.value[0] + current.pattern[0]
            new_y = current.value[1] + current.pattern[1]
            
            if new_x < 8 and new_y < 8
              node = Node.new([new_x, new_y], current)
              node.pattern = current.pattern
              queue.push(node)
            end
          end
      ###   return true

        else
          #if no pattern add a node for each direction in the moves object,
          #see if it is within bounds, push
          moves[direction].each do |dir|
            new_x = current.value[0] + dir[0]
            new_y = current.value[1] + dir[1]
            if new_x < 8 and new_y < 8
              node = Node.new([new_x, new_y], current)
              node.pattern = dir
              queue.push(node)
            end

          end

        end         

      end
    end
    #if no match is found will return false
    false
    
  end

  def make_move(board_info, move)
    board = create_board(board_info)
    info = board_info
    start_piece = board[move[:from][0]][move[:from][1]]
    destination = board[move[:to][0]][move[:to][1]]

    if destination
      info[destination[:color]][destination[:piece]][:loc].delete(move[:to])
    end

    info[start_piece[:color]][start_piece[:piece]][:loc].delete(move[:from])
    info[start_piece[:color]][start_piece[:piece]][:loc].push(move[:to])

    info
  end

  def create_board(board_info = [])
    #nil or {piece: color:}
    board = []

    (0..7).to_a.each_with_index do |list, x|
      board.push([])
      (0..7).to_a.each_with_index do |item, y|
        board[x].push(nil)
      end

    end

    board_info.each do |color, pieces|
      pieces.each do |piece, info|
        info[:loc].each do |location|
          obj = {piece: piece,  color: color, mark: info[:mark]}
          x = location[0]
          y = location[1]
          board[x][y] = obj
        end
      end
    end


    board
    
  end

  def checked?(board_info, color, king_location = nil)
    check?(board_info, color, king_location = nil)[:check]
  end

  def check?(board_info, color, king_location = nil)
    message = {check: false, check_mate: false}
    board = create_board(board_info)
    opposing_color = (color == :white) ? :black : :white
    moves = []

    #check king's legal moves and pos, add to array
    #for each if opposing can legal move pop
    #if current pos doesn't remain, check
    #if none remain. check mate
    if king_location
      moves.push(king_location)
    else

      king_loc = board_info[color][:king][:loc][0]
      patterns = [[0,1], [1,0], [0, -1], [-1, 0], [1,1], [-1,-1], [1,-1], [-1,1]]
      moves.push(king_loc)
      patterns.each do |pattern|
        new_loc = [king_loc[0] + pattern[0],king_loc[1] + pattern[1]]
        if new_loc[0] < 7 and new_loc[1] < 7 and new_loc[0] > 0 and new_loc[1] > 0
          piece = board[new_loc[0]][new_loc[1]]
          if piece
            if piece[:color] != color
              moves.push(new_loc)
            end
          else
            moves.push(new_loc)
          end
        end
      end
    end
    opposing_pieces = []
    board_info[opposing_color].each do |piece, info| 
      info[:loc].each { |pl| opposing_pieces.push(pl)}
    end 


    proc = Proc.new do |board_info, location, pieces, color|
      move_required = false
      pieces.each do |test_piece|
        move = {from: test_piece, to: location}
        legal = legal_move(board_info, move, opposing_color)
        if legal[:legal]
          move_required = true
        end
      end
      move_required
    end

    # first piece

    first_piece = proc.call(board_info, moves.shift, opposing_pieces, color)
  
    #check check_mate
    if first_piece
      message[:check] = true
      check_mate = true

      moves.each do |do_move|
        need_move = proc.call(board_info, do_move, opposing_pieces, color)

        check_mate = false if !need_move
      end
      message[:check_mate] = true if check_mate
      
    end
    return message
  end

end

class Node
  attr_accessor :value, :children, :parent, :pattern

  def initialize(value, parent = nil )
    @value = value
    @parent = parent
    @pattern = nil
  end
end

