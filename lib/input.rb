class Input
  def initialize(input: $stdin)
    @input = input
  end

  def gets
    @input.gets.chomp
  end
end
