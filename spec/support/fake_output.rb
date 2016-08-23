class FakeOutput

  attr_reader :messages
  
  def initialize
    @messages = []
  end

  def puts message
    @messages << message
  end
end
