class CheckedMove < Move

  def is_legal?
    if @board.checked?(@board.board_info, @turn.color, move[:to])
      @message = "Move does not move you out of check, please enter again."
      return false
    end
    super
  end

end
