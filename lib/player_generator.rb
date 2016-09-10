class PlayerGenerator

  def initialize
    @colors = [:white, :black]
    @names = ["Player 1", "Player 2"]
  end

  def create_player
    color = @colors.shift
    name = @names.shift

    Player.new(name: name, color: color)
  end

  
end
